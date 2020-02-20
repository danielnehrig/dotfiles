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
from getpass import getuser
from datetime import datetime
from distutils.spawn import find_executable

now = datetime.now()
current_time = now.strftime('%H:%M:%S')
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
        "radare2",
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


class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class Log(Colors):
    user = getuser()

    def now(self):
        time = datetime.now()
        return time.strftime('%H:%M:%S')

    def Success(self, string):
        st = '{0}-' + self.OKGREEN + '{1}:{2} ' + self.ENDC + ' {3} {4}'
        print(st.format(self.now(), self.user, 'SUCCESS', arrow, string))

    def Error(self, string):
        st = '{0}-' + self.FAIL + '{1}:{2}   ' + self.ENDC + ' {3} {4}'
        print(st.format(self.now(), self.user, 'ERROR', arrow, string))

    def Critical(self, string):
        st = '{0}-' + self.FAIL + '{1}:{2} ' + self.ENDC + ' {3} {4}'
        print(st.format(self.now(), self.user, 'CRITICAL', arrow, string))

    def Info(self, string):
        st = '{0}-' + self.OKBLUE + '{1}:{2}    ' + self.ENDC + ' {3} {4}'
        print(st.format(self.now(), self.user, 'INFO', arrow, string))

    def Step(self, string, step):
        st = '{0}-' + self.OKBLUE + '{1}:{2}    ' + self.ENDC + ' {3} Step : {4} {5}'
        print(st.format(self.now(), self.user, 'STEP', arrow, step, string))


log = Log()


def Call(cmd):
    try:
        inPath = find_executable(cmd) is not None
        if not inPath:
            raise Exception("Not in Path")
    except subprocess.CalledProcessError as e:
        log.Error('Call Check Failed with return code {1}'.format(e.returncode))


def CompileDependency(arg):
    try:
        log.Info('Compile {0}'.format(arg))
        cmdArr = arg.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
        log.Success('Success Compile')
    except subprocess.CalledProcessError as e:
        log.Error('Compilation Failed with return code {0}'.format(e.errno))


def InstallPackages(installCall, arr, options):
    for package in arr:
        log.Info('Installing {0}'.format(package))
        install = '{0} {1} {2}'.format(installCall, package, options)
        cmdArr = install.split()
        try:
            with open(os.devnull, "w") as f:
                subprocess.call(cmdArr, stdout=f)
                f.close()
            log.Success('Success Installing')
        except subprocess.CalledProcessError as e:
            log.Error('Failed to install {0} with code {1}'.format(package, e.returncode))


def InstallTap(tap):
    try:
        log.Info('Installing tap {0}'.format(tap))
        with open(os.devnull, "w") as f:
            subprocess.call(["brew", "tap", tap], stdout=f)
            f.close()
        log.Success('Success Installing tap')
    except subprocess.CalledProcessError as e:
        log.Error('Failed to install {0} with code {1}'.format(tap, e.returncode))


def Install(call):
    try:
        log.Info('Installing {0}'.format(call))
        cmdArr = call.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
    except subprocess.CalledProcessError as e:
        log.Error('Failed to install {0}'.format(call))


def LinkFile(source, dest):
    try:
        log.Info('Linking File {0} to {1}'.format(source, dest))
        with open(os.devnull, "w") as f:
            subprocess.call('ln -s {0}/{1} {2}'.format(current_folder, source, dest), stdout=f)
            f.close()
    except subprocess.CalledProcessError as e:
        log.Error('Failed to Link {0} to {1}'.format(source, dest))


def LinkFiles():
    try:
        for link in linking_files:
            # this loop is needed becouse chaining it into a string will result
            # in a cancelation of the installation of the packages if a brew package gets removed
            LinkFile(link.source, link.dest)
    except:
        log.Error('Failed to Link files')


def Copy(source, dest):
    try:
        log.Info('Copy File {0}'.format(source))
        system('rm {0}'.format(dest))
        system('cp {0}/{1} {2}'.format(current_folder, source, dest))
        log.Success('Success Copy')
    except:
        log.Error('Failed to move file')


def Main():
    log.Info("Starting Installation")
    log.Info("Installing Dependencies")

    # check if git is installed
    try:
        log.Step("Check if git is installed", 2)
        Call("git")
    except OSError as e:
        log.Error("git not found installing dev tools")
        Install('xcode-select --install')

    # check if brew is installed
    try:
        log.Step("Check if Homebrew is installed", 2)
        Call("brew")
    except OSError as e:
        log.Error("brew not found installing brew")
        system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')

    # git submodule pull
    log.Step("Pulling submodules", 4)
    Install('git submodule update --init --recursive')

    # install brew taps
    log.Step("Installing Homebrew Taps", 5)
    InstallTap('homebrew/cask-fonts')

    # install brew dependencies
    log.Step("Installing Homebrew CLI dependencies", 6)
    InstallPackages('brew install', brew_dependencies, '')

    # install git lfs

    # install cask dependencies
    log.Step("Installing Homebrew GUI dependencies", 7)
    InstallPackages('brew cask install', cask_dependencies, '')

    # install node
    log.Step("Installing Node", 8)
    Install('nodenv install 12.8.0')
    Install('nodenv global 12.8.0')

    # node packages
    log.Step("Installing Node Packages", 9)
    InstallPackages('npm install', node_packages, '--global')

    # install python packages
    log.Step("Installing Pythom PIP Packages", 10)
    InstallPackages('pip3.7 install', pip_packages, '')

    # powerline players.py fix for ger local
    log.Step("Installing Powerline Fix", 11)
    Copy('./.powerlineFix/players.py', '/usr/local/lib/python3.7/site-packages/powerline/segments/common/players.py')

    # install fonts
    try:
        # Fonts https://github.com/gabrielelana/awesome-terminal-fonts
        log.Step("Installing Fonts", 12)
        # and nerd fonts https://github.com/ryanoasis/nerd-fonts
        FONT = "https://github.com/gabrielelana/awesome-terminal-fonts/blob/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf"
        FONT_NAME = "SourceCodeProAwesome.ttf"
        system('wget -L ' + FONT + ' -O ' + FONT_NAME + ' > /dev/null 2>&1')
        system('cp ' + current_folder + '/' + FONT_NAME + ' ~/Library/Fonts/' + FONT_NAME)
    except OSError as e:
        log.Error("Error while installing fonts")

    # cloning dependencies zsh theme and plugins
    try:
        log.Step("Cloning Shell Dependencies Themes Plugins", 13)
        system('cp -r ./powerlevel10k ' + current_folder + '/oh-my-zsh/custom/themes/')
        system('cp -r zsh-syntax-highlighting ' + current_folder + '/oh-my-zsh/custom/plugins/')

        # autosuggest
        system('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        # fzf docker
        system('git clone https://github.com/pierpo/fzf-docker ' + current_folder + '/oh-my-zsh/custom' + '/plugins/fzf-docker')
    except OSError as e:
        log.Error("Error while cloning")

    # linking files
    try:
        log.Step("Linking zsh and vim files Symbolic", 14)
        LinkFiles()
    except OSError as e:
        log.Error("Error while linking files")

    # set default shell
    try:
        log.Step("Set zsh default shell", 15)
        system('chsh -s /usr/local/bin/zsh $(whoami)')
    except OSError as e:
        log.Error("Error while settings zsh shell")

    # option to not compile
    for option in sys.argv:
        if option == '--all':
            log.Step("Compile Programs", 16)
            # compile youcompleteme
            log.Info("Compile YCM")
            CompileDependency('./.dotfiles-vim/bundle/YouCompleteMe/install.py --all')
            # compile pwndbg for reversing c / c++
            log.Info("Compile pwndbg")
            CompileDependency('./pwndbg/setup.sh')

    # exec zsh
    log.Success("Installation Done")
    system('zsh')


if __name__ == "__main__":
    Main()
