#!/bin/sh

### Install Script by Daniel Nehrig
### daniel.nehrig@dnehrig.com

# Set Colors
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  LILA="$(tput setaf 5)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

# Global Vars
DEBUG="false"
ARROW="${BLUE}======>"
ERROR="${RED}ERROR:${NORMAL}"
WARNING="${LILA}Warning:${NORMAL}"
brew_depend="vim mpv mplayer unrar tmux w3m zsh youtube-dl wget wine dark-mode archey"
brew_dev_depend="nodenv ruby python@2 python3 mongodb gdb maven mysql go docker docker-compose docker-machine ctags cmake gcc perl lua mono rust"
brew_cask_depend="xquartz virtualbox vagrant iterm2 visual-studio-code 1password google-chrome firefox intellij-idea paw skype-for-business slack microsoft-office arduino"
node_depend_global="webpack nodemon license-generator"
gem_depend="mailcatcher sass"
pip_depend="pylint setuptools unicorn wheel wrapt youtube-dl Pygments powerline-status psutil mercurial pip isort"
NODENV_GLOBAL="9.11.1"

# System Validation
if sys="$(uname)" && [[ $sys -ne 'Darwin' ]]; then
  printf "$ARROW $ERROR System is ${BLUE}$sys ${NORMAL}but has to be ${GREEN}Darwin\n"
  exit 1
fi

# Install Validation
if [ ! -n "$DOTUNIX" ]; then
  DOTUNIX=$(pwd)
  printf "$ARROW ${GREEN}Installing\n"
else
  printf "$ARROW $ERROR ${RED}Allready installed\n\t${NORMAL}Use uninstaller\n"
  exit 1
fi

command -v git >/dev/null 2>&1 || {
  printf "$ARROW $ERROR ${NORMAL}Git is ${RED}not installed\n"
  exit 1
}

if [ -f "config" ]; then
  printf "$ARROW ${GREEN}Sourced SSH Connection config\n"
  source config
  sleep 2
fi

if [ -f "depend" ]; then
  source depend
  printf "$ARROW ${GREEN}Sourced Depend config\n"
  sleep 2
fi

### Download Repo Dependencies (TMUX, oh-my-zsh, dotfiles-vim, powerlevel9kTheme, syntax-highlight-zsh)
printf "$ARROW ${GREEN}Loading GIT Submodules\n"
git submodule update --init --recursive &> /dev/null

# Installing Dependencies
### Brew Install Validation
if ! brew_loc="$(type -p "brew")" || [[ -z $brew_loc ]]; then
  printf "$ARROW ${GREEN}Installing Brew\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask &> /dev/null
  sleep 2
else
  printf "$ARROW ${NORMAL}Brew is ${RED}allready installed\n"
  sleep 2
fi

### Brew Dependencies
if ! brew_loc="$(type -p "brew")" || [[ ! -z $brew_loc ]]; then
  printf "$ARROW ${GREEN}Install System Utilitys\n"
  printf "$ARROW ${BOLD}$brew_depend\n"
  brew install $brew_depend
  printf "$ARROW ${GREEN}Install Dev Utilitys\n"
  printf "$ARROW ${BOLD}$brew_dev_depend\n"
  brew install $brew_dev_depend
  sleep 2
else
  echo "Brew not found"
  sleep 2
fi

### Nodenv Setup
printf "$ARROW ${GREEN}Installing nodenv setting $NODENV_GLOBAL as Global node version\n"
nodenv install 10.0.0 -s
nodenv install 9.11.1 -s
nodenv install 9.0.0 -s
nodenv global $NODENV_GLOBAL

### Brew cask Dependencies
printf "$ARROW ${GREEN}Installing Cask Depend\n"
printf "$ARROW ${BOLD}$brew_cask_depend\n"
brew cask install $brew_cask_depend
eval "$(nodenv init -)" &> /dev/null

### NodeJS NPM Dependencies
if ! node_loc="$(type -p "npm")" || [[ ! -z $node_loc ]]; then
  printf "$ARROW ${GREEN}Installing Node Dependencies\n"
  npm install npm@latest -g &> /dev/null
  npm install $node_depend_global --global &> /dev/null
  sleep 2
fi

### Ruby GEM Dependencies
if ! gem_loc="$(type -p "gem")" || [[ ! -z $gem_loc ]]; then
  printf "$ARROW ${GREEN}Installing Gem Dependencies\n"
  printf "$ARROW ${BOLD}$gem_depend\n"
  gem install $gem_depend
  sleep 2
fi

### Python PIP Dependencies
if ! python_loc="$(type -p "python")" || [[ ! -z $python_loc ]]; then
  printf "$ARROW ${GREEN}Installing Pip Dependencies\n"
  printf "$ARROW ${BOLD}$pip_depend\n"
  pip3.7 install $pip_depend
  sleep 2
else
  printf "$ARROW ${RED}Python not found\n"
  sleep 2
fi

# Backup Files
printf "$ARROW ${GREEN}Backingup Files\n"
mkdir ~/.dot-backup
mv ~/.zshrc ~/.dot-backup/
mv ~/.tmux.conf ~/.dot-backup
mv ~/.vim ~/.dot-backup
mv ~/.vimrc ~/.dot-backup

# Linking Files
printf "$ARROW ${GREEN}Linking Files\n"
ln -s $DOTUNIX/.zsh/zshrc ~/.zshrc
cp $DOTUNIX/.tmux/.tmux.conf ~/.tmux.conf
ln -s $DOTUNIX/.dotfiles-vim/ ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s $DOTUNIX/.tmux.conf ~/.tmux.conf
ln -s $DOTUNIX/.ssh/config ~/.ssh/config

# Make ZSH default shell
printf "$ARROW ${GREEN}Making ZSH default shell\n"
ZSH_IN_SHELLS="cat /etc/shells | grep usr | grep zsh"
sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
chsh -s /usr/local/bin/zsh $(whoami)
sleep 2
exec zsh

# Downloading Private Files if Permission granted
### SSH KEYS
if [ -n "$SSH_SERV" ]; then
  printf "$ARROW ${GREEN}Downloading SSH Keys\n"
  scp -r $SSH_USER@$SSH_SERV:~/.ssh/$SSH_PRIVATE_KEY ~/.ssh/
  sleep 2
else
  printf "$ARROW ${RED}No SSH Credentials specified\n"
  sleep 2
fi

### Eval Node Env
eval "$(nodenv init -)" &> /dev/null

### Fonts https://github.com/gabrielelana/awesome-terminal-fonts
printf "$ARROW ${GREEN}Downloading Fonts\n"
mkdir fonts
FONT="https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
FONT_NAME="SourceCodeProAwesome.ttf"
wget -L $FONT -O $FONT_NAME > /dev/null 2>&1
mv $DOTUNIX/$FONT_NAME $DOTUNIX/custom/fonts/$FONT_NAME
sleep 2

### Install Powerlevel9k Plugin
cp -r powerlevel9k $DOTUNIX/oh-my-zsh/custom/themes/
sleep 2

### zsh-syntax-highlight
cp -r zsh-syntax-highlighting $DOTUNIX/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sleep 2

### Installing vim Plugins
printf "$ARROW ${GREEN}Installing Vim Plugins\n"
vim -c PluginInstall &> /dev/null

### Compiling YouCompleteMe
printf "$ARROW ${GREEN}Compiling YCM\n"
./.dotfiles-vim/bundle/YouCompleteMe/install.py --all &> /dev/null

### Compiling pwndbg
printf "$ARROW ${GREEN}Compiling pwndbg\n"
./pwndbg/setup.sh &> /dev/null

### Set installation is done
printf "$ARROW ${GREEN}Installation Completed\n"
exec zsh -l
