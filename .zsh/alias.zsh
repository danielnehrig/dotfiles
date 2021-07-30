export SHOP_ENV=~/code/work/vagrantboxes
export CODE_SHOP=~/code/work/shop-apotheke
export NODE_SYNC=~/code/work/shopapotheke-sync-new
export SHOP_SERVICES=~/code/work/frontend-services
export CODE_DIR=~/code/
export HOSTS=/etc/hosts
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias krtlc="kubectl config rename-context gke-production rtl-production"
alias kcc="kubectl config use-context"
alias kbl="setxkbmap -layout us,de -option caps:escape -option 'grp:alt_shift_toggle'"
alias ca='clear && neofetch'
alias cao='clear && archey'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias iLock='pmset displaysleepnow'
alias gatling='vagrant gatling-rsync-auto'
alias grname='git config --get remote.origin.url'
alias git-com='gitcommitcheck'
alias gpab='git branch -r | grep -v "\->" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done'
alias git-pupf='gitcommitcheckpupf'
alias updateAll='brew update'
alias gcosh='shopCheckout'
alias wlanM='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I en1'
alias oyna=nvim
alias la='colorls -la'
# alias j='autojump'

# Linux virt manager qemu boxes
if [[ `uname` == 'Linux' ]]; then
  alias win-games='virsh -c qemu:///system start win10-games-2'
  alias win-edit='virsh -c qemu:///system start win10-edit'
fi
