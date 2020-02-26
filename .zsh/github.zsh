# git reset HEAD (unstage) selector
github::pr() {
  type -p fzf &>/dev/null
  fzf=$?
  type -p hub &>/dev/null
  hub=$?
  type -p kokot &>/dev/null
  kokot=$?
  git remote show origin &>/dev/null
  isGit=$?

  if [[ $fzf == 1 || $hub == 1 ]]; then
    echo "Install fzf and hub (brew install fzf hub)"
    return 1
  fi
  if [[ $isGit == 128 ]]; then
    echo "Not a git Repository"
    return 1
  fi

  remote=$(git remote get-url origin)
  pull='/pull/'
  result=$(hub pr list -f '%t - %I%n' | fzf --preview='' | sed 's/.* - //')

  if [[ ! -z $result ]]; then
    open $remote$pull$result
    return 0
  else
    return 1
  fi
}

alias ghp='github::pr'
