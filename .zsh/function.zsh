# Work related Functions

function fzfp() {
  fzf --preview '[[ $(file --mime {}) =~ binary  ]] && \
    echo {} is a binary file || \
    (bat --style=numbers --color=always {} || \
    highlight -O ansi -l {} || \
    coderay {} || \
    rougify {} || \
    cat {}) 2> /dev/null | head -500'
}

function shopUpdate() {
  if [ ! -z $SHOP_ENV ];
  then
    echo "Update Vagrent ENV"
    cd $SHOP_ENV
    ./update.sh
    echo "Update Shop-Repo"
    cd $SHOP_CODE
    git pull
    echo "Update NodeSync"
    cd $NODE_SYNC
    git pull
    echo "Update Shop Services"
    cd $SHOP_SERVICE
    cd pupf-client
    git pull
  else
    echo "env not set"
  fi
}

function shopCheckout() {
  isShopRepo=$(git remote -v)
  if ! [[ $isShopRepo =~ '(shop-apotheke|shopeav)' ]]; then
      echo "Not In Shop Repo"
      return
  fi
  if [ ! -z $1 ];
  then
    if [[ $1 =~ '[0-9]{4}' ]]
    then
      git checkout bugfix/CSEAV-$1
    else
      echo 'No Valid Ticket Number specified'
      return
    fi
  else
    echo 'Needs 1 Arguments'
    return
  fi

}

function gitcommitcheck() {
  isShopRepo=$(git remote -v)
  if ! [[ $isShopRepo =~ '(shop-apotheke|shopeav)' ]]; then
      echo "Not In Shop Repo"
      return
  fi
  currentbranch=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f2)
  if [[ $currentbranch =~ 'PTBUY-[0-9]{1-4}' ]]
  then
    if [[ ! -z $1 ]]
    then
      commitname=$(echo $currentbranch-$1)
      git commit -m "$currentbranch: $1"
    else
      echo 'No Changes specified'
      return
    fi
  else
    echo 'Branch has wrong Formating'
    return
  fi
}

function gitcommitcheckpupf() {
  currentbranch=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f2)
  if [[ $currentbranch =~ 'PTBUY-[0-9]{1-4}' ]]
  then
    if [[ ! -z $1 ]]
    then
      commitname=$(echo "($currentbranch): $1")
      git commit -m "fix($currentbranch): $1"
    else
      echo 'No Changes specified'
      return
    fi
  else
    echo 'Not IN Pupf Repo'
    return
  fi
}

function tarPackUnpack() {
  case "$1" in
    pack)
      echo "packing $2"
      tar cfzv "$2.tar.gz" $2
      ;;
    unpack)
      echo "unpacking $2"
      tar xfvz "$2.tar.gz"
      ;;
    *)
      echo "Usage: $0 pack|unpack"
      ;;
  esac
}

function nodeClear() {
  rm -rf node_modules
  rm package-lock.json
  node cache verify
  node install
}

# Random

function darkTheme() {
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/dnehrig/wallpaper/dark.jpg"'
  dark-mode on
}

function lightTheme() {
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/dnehrig/wallpaper/light.jpg"'
  dark-mode off
}

function countCode() {
  find . -name '*.$1' | xargs wc -l
}

# Swagger ui preview
function swagger_yaml2json() {
  TMP_DIR="/tmp/vim-swagger-preview/"
  LOG=$TMP_DIR"validate.log"
  docker run  --rm -v $(pwd):/docs openapitools/openapi-generator-cli validate -i /docs/"$1" > $LOG 2>&1
  count=$(wc -l < $LOG)
  if [[ $count -gt 2 ]]; then
    # File exists and has a size greater than zero
    return 1
  else
    if grep -q "docker daemon running" $LOG; then
      return 2
    else
      # dump the stdout stderr to file otherwise the caller function complains
      docker run -v $(pwd):/docs -v $TMP_DIR:/out openapitools/openapi-generator-cli generate -i /docs/"$1" -g openapi -o /out > $LOG 2>&1
      # clear the log file
      cp /dev/null $LOG
      # https://github.com/swagger-api/swagger-codegen/issues/9140
     # docker run -v $(pwd):/docs -v $TMP_DIR:/out swaggerapi/swagger-codegen-cli-v3:3.0.9 generate -i /docs/"$1" -l openapi -o /out > /dev/null 2>&1
      return 0

    fi
  fi
}
function swagger_ui_start() {
    CONTAINER_NAME=${1:-swagger-ui-preview}
    TMP_DIR="/tmp/vim-swagger-preview/"
    # VOLUME=$(echo $(pwd) | tr "/" "_")
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "exited, cleaning"
            # cleanup
            # echo removing: 
            docker rm $CONTAINER_NAME
        fi
        # run the container
        docker run --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/docs/openapi.json -v $TMP_DIR:/docs swaggerapi/swagger-ui
    elif [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "is already running"
    fi
}
function swagger_preview() {
    TMP_DIR="/tmp/vim-swagger-preview/"
    LOG=$TMP_DIR"validate.log"
    SOURCE=${1:-swagger.yaml}
    $(swagger_yaml2json $SOURCE)
    YAML2JSON_RETURN_CODE=$?
    if [ "$YAML2JSON_RETURN_CODE" -eq "0" ]; then
      swagger_ui_start
    else
      cat $LOG
      echo "Converting to json failed!"
    fi
}
