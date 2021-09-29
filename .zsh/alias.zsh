export CODE_DIR=~/code/
export HOSTS=/etc/hosts
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias krtlc="kubectl config rename-context gke-production rtl-production"
alias kcc="kubectl config use-context"
alias kbl="setxkbmap -layout us,de -option caps:escape -option 'grp:alt_shift_toggle'"
alias ca='clear && neofetch'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias iLock='pmset displaysleepnow'
alias gatling='vagrant gatling-rsync-auto'
alias grname='git config --get remote.origin.url'
alias la='exa -la --icons'
alias ls='exa'
alias n='nvim'
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'

# Linux virt manager qemu boxes
if [[ `uname` == 'Linux' ]]; then
  alias win-games='virsh -c qemu:///system start win10-games-2'
  alias win-edit='virsh -c qemu:///system start win10-edit'
  alias vm-work='virsh -c qemu:///system start archlinux'
fi
