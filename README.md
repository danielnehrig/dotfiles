# Dotfiles for OSX / DARWIN System High Sierra

- [Dotfiles for OSX / DARWIN System High Sierra](#dotfiles-for-osx---darwin-system-high-sierra)
  - [Description](#description)
  - [Features](#features)
    - [GUI Programs (Default)](#gui-programs-default)
    - [CLI Programs (Default)](#cli-programs-default)
    - [ZSH Configuration](#zsh-configuration)
  - [Installation](#installation)

## Description

A fully automated system dev installation

using various packet managers

---

## Features

TMUX, VIM, ZSH Configurations

### GUI Programs (Default)

- VS-Code
- iTerm2
- 1Password
- PAW
- All Major Browsers
- Slack
- Skype for Business
- VirtualBox

### CLI Programs (Default)

- Vagrant
- Docker
- TMUX
- VIM
- GDB
- MYSQL
- MONGODB
- MAVEN
- WINE

### ZSH Configuration

- Correct Commiting
- Powerline
- Custom Aliases

---

## Installation

- SHH-Keys(Optional)
  - ```cp config.example config```
  - Change the Contents of the file **accordingly**
  - (Note) if omitted no SSH-Keys will be downloaded from remote
- Custom-Dependencies(Optional)
  - ```cp depend.example depend```
  - Change the Contents of the file **accordingly**
  - (Note) if omitted default dependencies will be installed
  - (Note) this will overwrite the default given dependencies
- ./install.sh
- VIM(Optional)
  - :PluginInstall