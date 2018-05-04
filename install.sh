#!/bin/sh

### Install Script by Daniel Nehrig inet-pwnZ
### @inetpwnZ // daniel.nehrig@dnehrig.com

# Installing Dependencies
### Brew Install Validation
if ! brew_loc="$(type -p "brew")" || [[ -z $brew_loc ]]; then
  echo "Installing Brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Brew is allready installed"
fi

### Brew Dependencies
brew_depend="vim mpv mplayer unrar tmux shairport-sync w3m zsh youtube-dl wget wine"
brew_dev_depend="node ruby python mongodb gdb maven mysql go docker docker-compose docker-machine ctags cmake perl lua"
if ! brew_loc="$(type -p "brew")" || [[ ! -z $brew_loc ]]; then
  echo "Install System Utilitys"
  echo $brew_depend
  brew install $brew_depend
  echo "Install Dev Utilitys"
  echo $brew_dev_depend
  brew install $brew_dev_depend
else
  echo "Brew not found"
fi

### NodeJS NPM Dependencies
node_depend_global="webpack nodemon"
if ! node_loc="$(type -p "npm")" || [[ ! -z $node_loc ]]; then
  npm install $node_depend_global --global
fi

### Ruby GEM Dependencies
gem_depend="mailcatcher sass"
if ! gem_loc="$(type -p "gem")" || [[ ! -z $gem_loc ]]; then
  echo "Installing Gem Dependencies"
  echo $gem_depend
  gem install $gem_depend
fi

### Python PIP Dependencies
pip_depend="pylint setuptools unicorn wheel wrapt youtube-dl Pygments powerline-status mercurial pip isort"
if ! python_loc="$(type -p "python")" || [[ ! -z $python_loc ]]; then
  echo "Installing Pip Dependencies"
  echo $pip_depend
  pip install $pip_depend
else
  echo "Python not found"
fi

# Make ZSH default shell

# Downloading Private Files if Permission granted
### SSH KEYS

### Fonts

# Linking Files
