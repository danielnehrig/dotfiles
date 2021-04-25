[![CircleCI](https://circleci.com/gh/danielnehrig/.dotfiles-darwin.svg?style=svg)](https://circleci.com/gh/danielnehrig/.dotfiles-darwin) ![CatalinaBadge](https://img.shields.io/badge/OS-Catalina-green?logo=apple&OS=Catalina)

# Dotfiles for OSX / DARWIN System Catalina

- [Dotfiles for OSX / DARWIN System Catalina](#dotfiles-for-osx---darwin-system-catalina)
  - [Description](#description)
  - [Features](#features)
    - [GUI Programs (Default)](#gui-programs-default)
    - [CLI Programs (Default)](#cli-programs-default)
    - [ZSH Configuration](#zsh-configuration)
  - [Installation](#installation)
    - [OSX](#osx)
    - [LINUX](#linux)

## Description

A fully automated system dev installation

using various packet managers

---

## Features

TMUX, VIM, ZSH Configurations

### GUI Programs (Default)

- VS-Code
- All Major Browsers
- VirtualBox
- Ghidra
- Postman
- etc... see install.py

### CLI Programs (Default)

- docker
- htop
- tmux
- fzf
- nvim
- gdb
- radare2
- etc... see install.py

### ZSH Configuration

- Oh-My-ZSH
- Custom Aliases
- Powerline10k ( NERD-FONT is default )
- FZF
- Syntaxhighlight
- Autosuggest

## Installation

### OSX

- install xcode from app store
- xcode-select --install
- ./install.py
- options
  - --all (to compile ycm and pwndbg)
- note check makefile or ./install.py --help

### LINUX

Auto install Not Supported yet

#### Dependencies

See pacman.txt

- arch // distro
- i3-gaps // wm
- dunst // notifcation
- rofi // application launcher/search
- feh // background
- pywal // colorscheme
- scrot // screenshot
- looking glass client // vm
- polybar // statusbar info
- lxsession
- virt-manager // vm
- spotify // music
- alacritty // terminal
- firefox // browser
- picom // composite manager
- gromit-mpx // on screen draw
- ...etc

#### Fonts / Theme

Needs Nerdfonts and material icons font
Nordic Theme GTK

#### Hotkeys

Mod = cmd/win
- alt move window floating mode
- mod+shift+w looking-glass-client
- mod+shift+d i3 config vim
- mod+i loopback voice
- mod+shift+s scrot screenshot area


## Thumbnails

### Arch Thumbnails

## Seasonschange
[![Thumbnail2 arch](https://i.imgur.com/xWP2mlu.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/arch)
[![Thumbnail3 arch](https://i.imgur.com/DWxgVRB.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/arch)
[![Thumbnail4 arch](https://i.imgur.com/5QFGV6y.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/arch)
