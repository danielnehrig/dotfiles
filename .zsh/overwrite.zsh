LAST_REPO=""
function __zoxide_z() {
  if [ "$#" -eq 0 ]; then
    __zoxide_cd ~
  elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
    if [ -n "${OLDPWD}" ]; then
      __zoxide_cd "${OLDPWD}"
    else
      # shellcheck disable=SC2016
      \builtin printf 'zoxide: $OLDPWD is not set'
      return 1
    fi
  elif [ "$#" -eq 1 ] && [ -d "$1" ]; then
    __zoxide_cd "$1"
  else
    \builtin local result
    result="$(zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" \
      && __zoxide_cd "${result}"
  fi

  git rev-parse 2>/dev/null

  if [ $? -eq 0 ]; then
    if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
      onefetch
      LAST_REPO=$(basename $(git rev-parse --show-toplevel))
    fi
  fi
}
