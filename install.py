#!/usr/bin/env python

import subprocess
import os
import sys
from os import system
import logging

current_folder = os.path.abspath(os.getcwd())

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
        "cheatsheet",
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

arrow = '=====>'

def Call(arg):
    try:
        with open(os.devnull, "w") as f: subprocess.call(arg, stdout=f)
    except OSError as e:
        print(e.errno)


def InstallPackages(installCall, arr):
    try:
        for package in arr:
            logging.info('{0} Installing {1}'.format(arrow, package))
            system('{0} {1}'.format(installCall, package))
    except:
        logging.error('{0} Failed to install {1}'.format(arrow, package))

def CallCheck(args, **kwargs):
    try:
        with open(os.devnull, "w") as f: subprocess.call(args, stdout=f)
    except subprocess.CalledProcessError as e:
        logging.critical('{0} {1} is Required'.format(arrow, args))
        sys.exit(e.returncode)

def Install(call):
    try:
        logging.info('{0} Installing {1}'.format(arrow, call))
        system(call)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Failed to install {1}'.format(arrow, call))

def IsInstalled(call, installstr):
    try:
        logging.info('{0} Is {1} Installed ?'.format(arrow, call))
        subprocess.call([call])
    except subprocess.CalledProcessError as e:
        logging.error('{0} Failed to install {1}'.format(arrow, call))
        system(installstr)

def main():
    logging.info("Starting Installation")
    logging.info("Installing Dependencys")

    # check if brew is installed
    try:
        logging.info("{0} brew check".format(arrow))
        Call("brew")
    except OSError as e:
        logging.error("{0} brew not found installing brew".format(arrow))
        system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')

    # check if git lfs is installed
    try:
        logging.info("{0} git lfs check".format(arrow))
        Call("git lfs")
    except OSError as e:
        logging.error("{0} git lfs not found installing git lfs".format(arrow))
        system('brew install git-lfs')
        system('git lfs install')

    # git submodule pull
    try:
        logging.info("{0} git pull submodules".format(arrow))
        Call('git submodule update --init --recursive')
    except OSError as e:
        logging.error("{0} git pull submodules failed".format(arrow))

    # install brew dependencies
    try:
        logging.info("{0} Install brew dependencies".format(arrow))
        s = " "
        system('brew install ' + s.join(brew_dependencies))
    except OSError as e:
        logging.error("{0} Error while installing brew dependencies".format(arrow))

    # install cask dependencies
    try:
        logging.info("Install cask dependencies".format(arrow))
        s = " "
        system('brew cask install ' + s.join(cask_dependencies))
    except OSError as e:
        print("Error while installing cask dependencies")

    # install node
    try:
        logging.info("{0} Install node".format(arrow))
        system('nodenv install 12.8.0')
        system('nodenv global 12.8.0')
    except OSError as e:
        logging.error("{0} Error while installing node".format(arrow))

    # install python packages
    try:
        logging.info("{0} Install pip packages".format(arrow))
        s = " "
        system('pip3.7 install ' + s.join(pip_packages))
    except OSError as e:
        logging.error("{0} Error while installing pip packages".format(arrow))

    # install fonts
    try:
        ### Fonts https://github.com/gabrielelana/awesome-terminal-fonts
        logging.info("{0} Installing Fonts".format(arrow))
        ### and nerd fonts https://github.com/ryanoasis/nerd-fonts
        FONT="https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
        FONT_NAME="SourceCodeProAwesome.ttf"
        system('wget -L ' + FONT + ' -O ' + FONT_NAME + ' > /dev/null 2>&1')
        system('cp ' + current_folder + '/' + FONT_NAME + ' ~/Library/Fonts/' + FONT_NAME)
        system('brew tap homebrew/cask-fonts')
        system('brew cask install font-hack-nerd-font')
    except OSError as e:
        logging.error("{0} Error while installing fonts".format(arrow))

    # cloning dependencies
    try:
        logging.info("Cloning Dependencies".format(arrow))
        system('cp -r ./powerlevel10k ' + current_folder +  '/oh-my-zsh/custom' + '/themes/powerlevel10k')
        system('cp -r zsh-syntax-highlighting ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/zsh-syntax-highlighting')

        ### autosuggest
        system('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        ### fzf docker
        system('git clone https://github.com/pierpo/fzf-docker ' + current_folder +  '/oh-my-zsh/custom' + '/plugins/fzf-docker')
    except OSError as e:
        logging.error("{0} Error while cloning".format(arrow))

    # linking files
    try:
        logging.info("{0} Linking zsh and vim files Symbolic".format(arrow))
        system('ln -s ' + current_folder + '/.zsh/zshrc ~/.zshrc')
        system('ln -s ' + current_folder + '/.dotfiles-vim/ ~/.vim')
        system('ln -s ' + current_folder + '/.vim/vimrc ~/.vimrc')
        system('ln -s ' + current_folder + '/.tmux.conf ~/.tmux.conf')
        system('ln -s ' + current_folder + '/.ssh/config ~/.ssh/config')
    except OSError as e:
        logging.error("{0} Error while settings zsh shell".format(arrow))

    # set default shell
    try:
        logging.info("{0} Set zsh default shell".format(arrow))
        system('chsh -s /usr/local/bin/zsh $(whoami)')
    except OSError as e:
        loggin.error("{0} Error while settings zsh shell".format(arrow))

    # vim plugins
    try:
        logging.info("{0} Install vim plugins".format(arrow))
    except OSError as e:
        logging.error("{0} Error while installing vim plugins".format(arrow))

    # compile youcompleteme
    try:
        logging.info("{0} Compile YCM".format(arrow))
        system('./.dotfiles-vim/bundle/YouCompleteMe/install.py --all')
    except OSError as e:
        logging.error("{0} Error while compiling ycm".format(arrow))

    logging.info("{0} Installation Done".format(arrow))
    system('zsh')

if __name__ == "__main__":
    CallCheck('git')
    main()
