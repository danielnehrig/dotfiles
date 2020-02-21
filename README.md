[![CircleCI](https://circleci.com/gh/danielnehrig/.dotfiles-darwin.svg?style=svg)](https://circleci.com/gh/danielnehrig/.dotfiles-darwin) ![CatalinaBadge](https://img.shields.io/badge/OS-Catalina-green?logo=apple&OS=Catalina)

# Dotfiles for OSX / DARWIN System Catalina

- [Dotfiles for OSX / DARWIN System Catalina](#dotfiles-for-osx---darwin-system-catalina)
  - [Description](#description)
  - [Features](#features)
    - [GUI Programs (Default)](#gui-programs-default)
    - [CLI Programs (Default)](#cli-programs-default)
    - [ZSH Configuration](#zsh-configuration)
    - [Todo](#todo)
  - [Installation](#installation)
    - [OSX](#osx)
    - [LINUX](#linux)
  - [Thumbnails](#thumbnails)
    - [OSX](#osx)
      - [Cherry](#cherry-profile)
      - [Default](#default-profile)
      - [Parklet](#parklet-profile)

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
- All Major Browsers
- Slack
- Skype for Business
- Cheatsheet
- VirtualBox
- Ghidra
- Postman
- etc... see install.py

### CLI Programs (Default)

- docker
- htop
- tmux
- fzf
- vim
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

### Todo

- Adding automated Key signing for debuging (gdb, radare2)
- Automated installation of iterm2 settings
- Adding dotnet
- Adding Linux Support
- Adding Windows Support

## Installation

### OSX

- install xcode from app store
- xcode-select --install
- ./install.py
- options
  - --all (to compile ycm and pwndbg)
- note check makefile or ./install.py --help

#### Iterm2

How to import from above JSON file format which is actually a plist format:

- go to your home directory cd ~
- cd Library/Application Support/iTerm2/DynamicProfiles
- copy your json file you saves to this DynamicProfiles folder
- cp dotfilesrepo/itermprofiles.json .
- Restart iTerm2 now in profiles it should show all your old profiles

### LINUX

Not Supported yet

## Thumbnails

### OSX Thumbnails

- Images Showcase iTerm2 Color Schemes and tmux powerline theme
- Showcasing zsh vim tmux fzf
- Click Image to see more Screenshots

#### Cherry Profile

[![Thumbnail1 Terminal](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/cherry/terminal.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Cherry)
[![Thumbnail1 vim fzf](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/cherry/vim%202%20fzf.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Cherry)

#### Default Profile

[![Thumbnail2 Terminal](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/default/terminal_suggest.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Default)
[![Thumbnail2 vim fzf](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/default/vim_fzf.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Default)

#### Parklet Profile

[![Thumbnail3 Terminal](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/parklet/terminal.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Parklet)
[![Thumbnail3 vim fzf](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/parklet/vim_fzf.png)](https://github.com/danielnehrig/.dotfiles-darwin/wiki/Parklet)
