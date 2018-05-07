#!/bin/sh

### Install Script by Daniel Nehrig inet-pwnZ
### @inetpwnZ // daniel.nehrig@dnehrig.com

# Install Validation
if [ ! -n "$DOTUNIX" ]; then
  DOTUNIX="$(pwd)"
fi

# if [ -d "$DOTUNIX" ]; then
#   printf "You already have DOTUNIX installed.\n"
#   printf "You'll need to remove $DOTUNIX if you want to re-install.\n"
#   exit
# fi

command -v git >/dev/null 2>&1 || {
  echo "Error git is not installed"
  exit 1
}

### Download Repo Dependencies (TMUX, oh-my-zsh, dotfiles-vim, powerlevel9kTheme, syntax-highlight-zsh)
git submodule update --init --recursive --remote

CURRENT_SHELL=$(expr "$SHELL" : '.*/(.*\)')

if [ -f "config" ]; then
  echo "Sourced SSH config"
  source config
  sleep 2
fi

# Installing Dependencies
### Brew Install Validation
echo "Enter Permission Credentials"
if ! brew_loc="$(type -p "brew")" || [[ -z $brew_loc ]]; then
  echo "Installing Brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sleep 2
else
  echo "Brew is allready installed"
  sleep 2
fi

### Brew Cask
brew tap caskroom/cask

### Brew Dependencies
brew_depend="vim --with-python@2 mpv mplayer unrar tmux shairport-sync w3m zsh youtube-dl wget wine dark-mode"
brew_dev_depend="node ruby python mongodb gdb maven mysql go docker docker-compose docker-machine ctags cmake perl lua"
if ! brew_loc="$(type -p "brew")" || [[ ! -z $brew_loc ]]; then
  clear
  echo "Install System Utilitys"
  echo $brew_depend
  brew install $brew_depend
  echo "Install Dev Utilitys"
  echo $brew_dev_depend
  brew install $brew_dev_depend
  sleep 2
else
  echo "Brew not found"
  sleep 2
fi

### Brew cask Dependencies
brew_cask_depend="xquartz virtualbox vagrant iterm2 visual-studio-code 1password google-chrome firefox intellij-idea paw skype-for-business slack microsoft-office"
echo "Installing Cask Depend"
echo $brew_cask_depend
brew cask install $brew_cask_depend

### NodeJS NPM Dependencies
node_depend_global="webpack nodemon license-generator"
if ! node_loc="$(type -p "npm")" || [[ ! -z $node_loc ]]; then
  clear
  npm install $node_depend_global --global
  sleep 2
fi

### Ruby GEM Dependencies
gem_depend="mailcatcher sass"
if ! gem_loc="$(type -p "gem")" || [[ ! -z $gem_loc ]]; then
  clear
  echo "Installing Gem Dependencies"
  echo $gem_depend
  gem install $gem_depend
  sleep 2
fi

### Python PIP Dependencies
pip_depend="pylint setuptools unicorn wheel wrapt youtube-dl Pygments powerline-status mercurial pip isort"
if ! python_loc="$(type -p "python")" || [[ ! -z $python_loc ]]; then
  clear
  echo "Installing Pip Dependencies"
  echo $pip_depend
  pip install $pip_depend
  sleep 2
else
  echo "Python not found"
  sleep 2
fi

# Make ZSH default shell
clear
echo "Making ZSH default shell"
echo "/usr/local/bin/zsh" >> /etc/shells
chsh -s /usr/local/bin/zsh $(whoami)
sleep 2

# Downloading Private Files if Permission granted
### SSH KEYS
if [ -n "$SSH_SERV" ]; then
  clear
  echo "Downloading SSH Keys"
  scp -r $SSH_USER@$SSH_SERV:~/.ssh/$SSH_PRIVATE_KEY ~/.ssh/
  sleep 2
else
  echo "No SSH Credentials specified"
  sleep 2
fi

### Fonts
clear
echo "Downloading Fonts"
mkdir fonts
FONT="https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
FONT_NAME="SourceCodeProAwesome.ttf"
wget -L $FONT -O $FONT_NAME > /dev/null 2>&1
mv $DOTUNIX/$FONT_NAME $DOTUNIX/custom/fonts/$FONT_NAME
sleep 2

### zsh-syntax-highlight
clear
cp -r zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sleep 2

# Linking Files
clear
echo "Linking Files"
ln -s $DOTUNIX/.zsh/zshrc ~/.zshrc
ln -s $DOTUNIX/.tmux/.tmux.conf ~/.tmux.conf
ln -s $DOTUNIX/.dotfiles-vim/ ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s $DOTUNIX/.ssh/config ~/.ssh/config

echo "Installation Completed"
