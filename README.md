[![CircleCI](https://circleci.com/gh/danielnehrig/.dotfiles-darwin.svg?style=svg)](https://circleci.com/gh/danielnehrig/.dotfiles-darwin)

# Dotfiles for OSX / DARWIN System High Sierra and Catalina

- [Dotfiles for OSX / DARWIN System High Sierra](#dotfiles-for-osx---darwin-system-high-sierra)
  - [Description](#description)
  - [Features](#features)
    - [GUI Programs (Default)](#gui-programs-default)
    - [CLI Programs (Default)](#cli-programs-default)
    - [ZSH Configuration](#zsh-configuration)
    - [Todo](#todo)
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

#### Cherry Profile

![Thumbnail1 Terminal](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/terminal.png)
![Thumbnail1 Terminal suggest](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/terminal%20suggest.png)
![Thumbnail1 Terminal fzf](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/terminal%20fzf.png)
![Thumbnail1 vim](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/vim.png)
![Thumbnail1 vim fzf](https://raw.githubusercontent.com/danielnehrig/.dotfiles-darwin/master/.thumbnails/vim%202%20fzf.png)
