#!/usr/bin/env python

# This Script will install following items
# brew
# brew packages
# brew cask packages
# node packages
# python packages
# symbolic links
# fonts
# powerline tmux theme
# pwndbg
# ycm vim completion engine
# note : see following arrays and or adjust them

import subprocess
import os
import sys
from os import system
import logging

current_folder = os.path.abspath(os.getcwd())

# source is context current folder + repo item
linking_files = [
        {
            "source": "powerline",
            "dest": "~/.config"
            },
        {
            "source": ".tmux.conf",
            "dest": "~/.tmux.conf"

            },
        {
            "source": ".zsh/zshrc",
            "dest": "~/.zshrc"
            },
        {
            "source": ".ssh/config",
            "dest": "~/.ssh/config"
            },
        {
            "source": ".dotfiles-vim",
            "dest": "~/.vim"
            },
        {
            "source": ".dotfiles-vim/vimrc",
            "dest": "~/.vimrc"
            },
        {
            "source": ".uncrustify",
            "dest": "~/.uncrustify"
            }
        ]

pip_packages = [
        "powerline-status",
        "psutil"
        ]

brew_dependencies = [
        "mono",
        "tree",
        "gdb",
        "bat",
        "unrar",
        "cmake",
        "ctags",
        "the_silver_searcher",
        "kubectl",
        "sqlite",
        "mysql",
        "neofetch",
        "archey",
        "radare2"
        "gcc",
        "htop",
        "make",
        "python",
        "tmux",
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
        "google-cloud-sdk",
        "cheatsheet",
        "firefox",
        "ghidra",
        "sketch",
        "abstract",
        "adobe-creative-cloud",
        "slack",
        "1password",
        "visual-studio-code",
        "microsoft-office",
        "skype-for-business",
        "postman",
        "iterm2",
        "docker",
        "whatsapp",
        "discord",
        "font-hack-nerd-font"
        ]

node_packages = [
        "nodemon",
        "webpack",
        "yarn",
        "typescript"
        ]

arrow = '========>'


def Error(string):
    color = ''
    logging.error('TIME : ERROR: {0} {1}'.format(arrow, string))


def Success(string):
    color = ''
    logging.error('TIME : SUCCESS : {0} {1}'.format(arrow, string))


def Info(string):
    color = ''
    logging.info('TIME : INFO : {0} {1}'.format(arrow, string))


def Call(arg):
    try:
        cmdArr = arg.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Call Failed with return code {1}'.format(arrow, e.returncode))


def CompileDependency(arg):
    try:
        cmdArr = arg.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Compilation Failed with return code {1}'.format(arrow, e.errno))


def InstallPackages(installCall, arr, options):
    for package in arr:
        print('{0} Installing {1}'.format(arrow, package))
        install = '{0} {1} {2}'.format(installCall, package, options)
        cmdArr = install.split()
        try:
            with open(os.devnull, "w") as f:
                subprocess.call(cmdArr, stdout=f)
        except subprocess.CalledProcessError as e:
            logging.error('{0} Failed to install {1} with code {2}'.format(arrow, package, e.returncode))


def InstallTap(tap):
    print('{0} Installing tap {1}'.format(arrow, tap))
    try:
        with open(os.devnull, "w") as f:
            subprocess.call("brew tap {0}".format(tap), stdout=f)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Failed to install {1} with code {2}'.format(arrow, tap, e.returncode))


def CallCheck(args, **kwargs):
    try:
        cmdArg = args.split()
        with open(os.devnull, "w") as f: subprocess.call(cmdArg, stdout=f)
    except subprocess.CalledProcessError as e:
        logging.critical('{0} {1} is Required'.format(arrow, args))
        sys.exit(e.returncode)


def Install(call):
    try:
        print('{0} Installing {1}'.format(arrow, call))
        cmdArr = call.split()
        with open(os.devnull, "w") as f: subprocess.call(cmdArr, stdout=f)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Failed to install {1}'.format(arrow, call))


def LinkFile(source, dest):
    try:
        print('{0} Linking File {1} to {2}'.format(arrow, source, dest))
        with open(os.devnull, "w") as f:
            subprocess.call('ln -s {0}/{1} {2}'.format(current_folder, source, dest), stdout=f)
    except subprocess.CalledProcessError as e:
        logging.error('{0} Failed to Link {1} to {2}'.format(arrow, source, dest))


def LinkFiles():
    try:
        for link in linking_files:
            # this loop is needed becouse chaining it into a string will result
            # in a cancelation of the installation of the packages if a brew package gets removed
            LinkFile(link.source, link.dest)
    except:
        logging.error('{0} Failed to Link files'.format(arrow))


def Move(source, dest):
    try:
        system('rm -ri {0}'.format(dest))
        system('cp {0}/{1} {2}'.format(current_folder, source, dest))
    except:
        logging.error('{0} Failed to move file'.format(arrow))


def main():
    print("{0} Starting Installation".format(arrow))
    print("{0} Installing Dependencies".format(arrow))

    # check if xcode dev tools are installed becouse of git
    try:
        CallCheck('xcode-select --install')
    except subprocess.CalledProcessError as e:
        print("{0} xcode dev tools is not installed installing".format(arrow))
        Install('xcode-select --install')

    # check if brew is installed
    try:
        print("{0} brew check".format(arrow))
        Call("brew")
    except OSError as e:
        logging.error("{0} brew not found installing brew".format(arrow))
        system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')

    # check if git lfs is installed
    try:
        print("{0} git lfs check".format(arrow))
        Call("git lfs")
    except OSError as e:
        logging.error("{0} git lfs not found installing git lfs".format(arrow))
        system('brew install git-lfs')
        system('git lfs install')

    # git submodule pull
    print("{0} git pull submodules".format(arrow))
    Call('git submodule update --init --recursive')

    # install brew dependencies
    print("{0} Install brew dependencies".format(arrow))
    InstallPackages('brew install', brew_dependencies, '')

    # install brew taps
    InstallTap('homebrew/cask-fonts')

    # install cask dependencies
    print("{0} Install cask dependencies".format(arrow))
    InstallPackages('brew cask install', cask_dependencies, '')

    # install node
    print("{0} Install node".format(arrow))
    Install('nodenv install 12.8.0')
    Install('nodenv global 12.8.0')

    # node packages
    print("{0} Install node packages".format(arrow))
    InstallPackages('npm install', node_packages, '--global')

    # install python packages
    print("{0} Install pip packages".format(arrow))
    InstallPackages('pip3.7 install', pip_packages, '')

    # powerline players.py fix for ger local
    print("{0} Install pip packages".format(arrow))
    Move('./.powerlineFix/players.py', '/usr/local/lib/python3.7/site-packages/powerline/')

    # install fonts
    try:
        ### Fonts https://github.com/gabrielelana/awesome-terminal-fonts
        print("{0} Installing Fonts".format(arrow))
        ### and nerd fonts https://github.com/ryanoasis/nerd-fonts
        FONT="https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
        FONT_NAME="SourceCodeProAwesome.ttf"
        system('wget -L ' + FONT + ' -O ' + FONT_NAME + ' > /dev/null 2>&1')
        system('cp ' + current_folder + '/' + FONT_NAME + ' ~/Library/Fonts/' + FONT_NAME)
    except OSError as e:
        logging.error("{0} Error while installing fonts".format(arrow))

    # cloning dependencies zsh theme and plugins
    try:
        print("Cloning Dependencies".format(arrow))
        system('cp -r ./powerlevel10k ' + current_folder + '/oh-my-zsh/custom' + '/themes/powerlevel10k')
        system('cp -r zsh-syntax-highlighting ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-syntax-highlighting')

        ### autosuggest
        system('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        ### fzf docker
        system('git clone https://github.com/pierpo/fzf-docker ' + current_folder + '/oh-my-zsh/custom' + '/plugins/fzf-docker')
    except OSError as e:
        logging.error("{0} Error while cloning".format(arrow))

    # linking files
    try:
        print("{0} Linking zsh and vim files Symbolic".format(arrow))
        LinkFiles()
    except OSError as e:
        logging.error("{0} Error while linking files".format(arrow))

    # set default shell
    try:
        print("{0} Set zsh default shell".format(arrow))
        system('chsh -s /usr/local/bin/zsh $(whoami)')
    except OSError as e:
        logging.error("{0} Error while settings zsh shell".format(arrow))

    # option to not compile
    for option in sys.argv:
        if option == '--all':
            # compile youcompleteme
            print("{0} Compile YCM".format(arrow))
            CompileDependency('./.dotfiles-vim/bundle/YouCompleteMe/install.py --all')
            # compile pwndbg for reversing c / c++
            print("{0} Compile pwndbg".format(arrow))
            CompileDependency('./pwndbg/setup.sh')

    # exec zsh
    print("{0} Installation Done".format(arrow))
    system('zsh')


if __name__ == "__main__":
    CallCheck('git')
    main()
