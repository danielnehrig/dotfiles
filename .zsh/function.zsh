# Work related Functions

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
  if [[ $currentbranch =~ 'CSEAV-[0-9]{4}' ]]
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
  if [[ $currentbranch =~ 'CSEAV-[0-9]{4}' ]]
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
