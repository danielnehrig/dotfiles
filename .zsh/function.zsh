# Work related Functions
#
function shopCheckout() {
  isShopRepo=`git remote -v | grep shop-apotheke`
  if [ "$?" -ne "0" ]; then
    echo "Not In Shop Repo"
    exit 1
  fi
  if [ ! -z $1 ];
  then
    if [[ $1 =~ '[0-9]{4}' ]]
    then
      git checkout bugfix/CSEAV-$1
    else
      echo 'No Valid Ticket Number specified'
    fi
  else
    echo 'Needs 1 Arguments'
  fi

}

function gitcommitcheck() {
  isShopRepo=`git remote -v | grep shop-apotheke`
  if [ "$?" -ne "0" ]; then
    echo "Not In Shop Repo"
    exit 1
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
    fi
  else
    echo 'Branch has wrong Formating'
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
    fi
  else
    echo 'Not IN Pupf Repo'
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
