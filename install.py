#!/usr/bin/env python

import subprocess
import os
from os import system

current_folder = os.path.abspath(os.getcwd())
system('export DOTUNIX="' + current_folder + '"')

pip_packages = [
        "powerline-status",
        "psutil"
        ]

brew_dependencies = [
        "mono",
        "gcc",
        "htop",
        "make",
        "python",
        "ruby",
        "go",
        "rust",
        "perl",
        "lua",
        "vim",
        "zsh",
        "nodenv",
        "docker",
        "docker-compose",
        "docker-machine"
        ]

cask_dependencies = [
        "virtualbox",
        "google-chrome",
        "firefox",
        "slack",
        "visual-studio-code",
        "microsoft-office",
        "skype-for-business",
        "postman",
        "iterm2",
        "docker"
        ]

node_packages = [
        "nodemon",
        "webpack",
        "webpack-cli"
        ]

def main():
    print("Starting Installation")
    print("Installing Dependencys")

    # check if brew is installed
    try:
        print("brew check")
        subprocess.call(["brew"])
    except OSError as e:
        print("brew not found installing brew")
        system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')

    # check if git lfs is installed
    try:
        print("git lfs check")
        subprocess.call(["git", "lfs"])
    except OSError as e:
        print("git lfs not found installing git lfs")
        system('brew install git-lfs')
        system('git lfs install')

    # git submodule pull
    try:
        print("git pull submodules")
        system('git submodule update --init --recursive')
    except OSError as e:
        print("git pull submodules failed")

    # install brew dependencies
    try:
        print("Install brew dependencies")
        s = " "
        system('brew install ' + s.join(brew_dependencies))
    except OSError as e:
        print("Error while installing brew dependencies")

    # install cask dependencies
    try:
        print("Install cask dependencies")
        s = " "
        system('brew cask install ' + s.join(cask_dependencies))
    except OSError as e:
        print("Error while installing cask dependencies")

    # install node
    try:
        print("Install node")
        system('nodenv install 12.8.0')
        system('nodenv global 12.8.0')
    except OSError as e:
        print("Error while installing node")

    # install python packages
    try:
        print("Install pip packages")
        s = " "
        system('pip3.7 install ' + s.join(pip_packages))
    except OSError as e:
        print("Error while installing pip packages")

    # install fonts
    try:
        ### Fonts https://github.com/gabrielelana/awesome-terminal-fonts
        ### and nerd fonts https://github.com/ryanoasis/nerd-fonts
        print("Installing Fonts")
        FONT="https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
        FONT_NAME="SourceCodeProAwesome.ttf"
        system('wget -L ' + FONT + ' -O ' + FONT_NAME + ' > /dev/null 2>&1')
        system('cp ' + current_folder + '/' + FONT_NAME + ' ~/Library/Fonts/' + FONT_NAME)
        system('brew tap homebrew/cask-fonts')
        system('brew cask install font-hack-nerd-font')
    except OSError as e:
        print("Error while installing fonts")

    # cloning dependencies
    try:
        print("Cloning Dependencies")
        system('cp -r ./powerlevel10k ' + current_folder +  '/oh-my-zsh/custom' + '/themes/powerlevel10k')
        system('cp -r zsh-syntax-highlighting ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/zsh-syntax-highlighting')

        ### autosuggest
        system('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        ### fzf docker
        system('git clone https://github.com/pierpo/fzf-docker ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/fzf-docker')
    except OSError as e:
        print("Error while cloning")

    # linking files
    try:
        print("Linking zsh and vim files Symbolic")
        system('ln -s ' + current_folder + '/.zsh/zshrc ~/.zshrc')
        system('ln -s ' + current_folder + '/.dotfiles-vim/ ~/.vim')
        system('ln -s ' + current_folder + '/.vim/vimrc ~/.vimrc')
        system('ln -s ' + current_folder + '/.tmux.conf ~/.tmux.conf')
        system('ln -s ' + current_folder + '/.ssh/config ~/.ssh/config')
    except OSError as e:
        print("Error while settings zsh shell")

    # set default shell
    try:
        print("Set zsh default shell")
        system('chsh -s /usr/local/bin/zsh $(whoami)')
    except OSError as e:
        print("Error while settings zsh shell")

    # vim plugins
    try:
        print("Install vim plugins")
    except OSError as e:
        print("Error while installing vim plugins")

    # compile youcompleteme
    try:
        print("Compile YCM")
        system('./.dotfiles-vim/bundle/YouCompleteMe/install.py --all')
    except OSError as e:
        print("Error while compiling ycm")

    system('zsh')

    print("Installation Done")

main()
