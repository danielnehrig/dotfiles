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
# note : see following arrays and or adjust them

import subprocess
import os
import sys
from os import system
from getpass import getuser
from datetime import datetime
from distutils.spawn import find_executable

now = datetime.now()
current_time = now.strftime('%H:%M:%S')
current_folder = os.path.abspath(os.getcwd())
user = getuser()
home = os.environ["HOME"] + '/'
pacman_packages = []

# source is context current folder + repo item
linking_files_mac = [
    {
        "source": ".config/alacritty_mac.yml",
        "dest": ".config/alacritty.yml"
    },
    {
        "source": ".tmux.mac.conf",
        "dest": ".tmux.conf"
    },
    {
        "source": ".config/yabai/yabairc",
        "dest": ".config/yabai/yabairc"
    },
    {
        "source": ".config/kak",
        "dest": ".config/kak"
    },
    {
        "source": ".config/skhd/skhdrc",
        "dest": ".config/skhd/skhdrc"
    },
    {
        "source": ".zsh/zshrc",
        "dest": ".zshrc"
    },
    {
        "source": ".ssh/config",
        "dest": ".ssh/config"
    },
    {
        "source": ".dotfiles-vim",
        "dest": ".vim"
    },
    {
        "source": ".config/nvim",
        "dest": ".config/nvim"
    },
    {
        "source": ".dotfiles-vim/vimrc",
        "dest": ".vimrc"
    },
    {
        "source": ".uncrustify",
        "dest": ".uncrustify"
    }
]

# TODO add logic to link executables to path
bin_files_arch = [
    {
        "source": "./scripts/locker.sh",
        "dest": "/usr/local/bin"
    }
]

linking_files_arch = [
    {
        "source": ".tmux.conf",
        "dest": ".tmux.conf"

    },
    {
        "source": ".zsh/zshrc",
        "dest": ".zshrc"
    },
    {
        "source": ".ssh/config",
        "dest": ".ssh/config"
    },
    {
        "source": ".dotfiles-vim",
        "dest": ".vim"
    },
    {
        "source": ".config/kak",
        "dest": ".config/kak"
    },
    {
        "source": ".dotfiles-vim/vimrc",
        "dest": ".vimrc"
    },
    {
        "source": ".config/nvim",
        "dest": ".config/nvim"
    },
    {
        "source": ".config/i3",
        "dest": ".config/i3"
    },
    {
        "source": ".config/dunst",
        "dest": ".config/dunst"
    },
    {
        "source": "themes/rofi/oxide",
        "dest": ".config/rofi"
    },
    {
        "source": ".config/picom.conf",
        "dest": ".config/picom.conf"
    },
    {
        "source": ".config/alacritty.yml",
        "dest": ".config/alacritty.yml"
    },
    {
        "source": ".xinitrc",
        "dest": ".xinitrc"
    },
    {
        "source": ".Xresources",
        "dest": ".Xresources"
    },

    {
        "source": "polybar-powerline",
        "dest": ".config/polybar"
    }
]
pip_packages = [
    "psutil"
]

brew_dependencies = [
    "mono",
    "tree",
    "gdb",
    "fzf",
    "bat",
    "unrar",
    "cmake",
    "kubectl",
    "neofetch",
    "git-lfs",
    "neofetch",
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
    "github/gh/gh",
    "hub",
    "lua",
    "neovim --HEAD",
    "zsh",
    "nodenv",
    "docker",
    "koekeishiya/formulae/skhd",
    "koekeishiya/formulae/yabai",
    "docker-compose"
]

cask_dependencies = [
    "virtualbox",
    "google-chrome",
    "brave-browser",
    "google-cloud-sdk",
    "firefox",
    "ghidra",
    "abstract",
    "visual-studio-code",
    "microsoft-office",
    "postman",
    "docker",
    "alacritty",
    "whatsapp",
    "discord",
    "font-hack-nerd-font"
]

node_packages = [
    "nodemon",
    "yarn",
    "typescript-language-server",
    "typescript",
    "lua-fmt",
    "vscode-html-languageserver-bin",
    "css-language-server",
    "svelte-language-server",
    "bash-language-server",
    "yaml-language-server",
    "dockerfile-language-server-nodejs",
    "dprint",
    "pyright",
    "@bitwarden/cli"
]

go_packages = [
    "mvdan.cc/sh/v3/cmd/shfmt"
]
rust_packages = []

arrow = '====>'


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

    def buildLogString(self, kind, color):
        start = '{2} {0} ' + color + '{1}:' + kind + ' ' + self.ENDC
        attach = self.HEADER + ': {3}' + self.ENDC
        return start + attach

    def buildStepString(self, kind, color):
        start = '{2} {0} ' + color + '{1}:' + kind + ' {4}/16' + self.ENDC
        attach = self.BOLD + ': {3}' + self.ENDC
        return start + attach

    def Success(self, string):
        st = self.buildLogString('SUCCESS', self.OKGREEN)
        print(st.format(self.now(), self.user, arrow, string))

    def Warning(self, string):
        st = self.buildLogString('WARNING', self.WARNING)
        print(st.format(self.now(), self.user, arrow, string))

    def Error(self, string):
        st = self.buildLogString('ERROR', self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Critical(self, string):
        st = self.buildLogString('CRITICAL', self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Info(self, string):
        st = self.buildLogString('INFO', self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string))

    def Step(self, string, step):
        st = self.buildStepString('STEP', self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string, step))


log = Log()


def IsCI():
    result = False
    if os.environ["CI"] == 'yes':
        result = True
    return result


def Call(cmd):
    try:
        inPath = find_executable(cmd) is not None
        if not inPath:
            log.Warning("Not in Path {0}".format(cmd))
        return inPath
    except subprocess.CalledProcessError as e:
        log.Error('Call Check {0} Failed with return code {1}'.format(cmd, e.returncode))


def CompileDependency(arg):
    try:
        log.Info('Compile {0}'.format(arg))
        cmdArr = arg.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
        log.Success('Success Compile')
    except subprocess.CalledProcessError as e:
        log.Error('Compilation Failed with return code {0}'.format(e))


def InstallCliPackages(installCall, arr, options = ''):
    for package in arr:
        log.Info('Installing CLI Package {0}'.format(package))
        install = '{0} {1} {2}'.format(installCall, package, options)
        cmdArr = install.split()
        try:
            inPath = Call(package)
            if not inPath:
                with open(os.devnull, "w") as f:
                    subprocess.call(cmdArr, stdout=f)
                    f.close()
                log.Success('Success Installing')
        except subprocess.CalledProcessError as e:
            log.Error('Failed to install {0} with code {1}'.format(package, e.returncode))


def InstallPackages(installCall, arr, options = ''):
    for package in arr:
        log.Info('Installing Package {0}'.format(package))
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
    except subprocess.CalledProcessError:
        log.Error('Failed to install {0}'.format(call))


def LinkFile(source, dest):
    " Creates a Symbolic Link "
    try:
        log.Info('Linking File {0} to {1}'.format(source, dest))
        with open(os.devnull, "w") as f:
            subprocess.call(['ln', '-sfn', current_folder + '/' + source, home + dest], stdout=f)
            f.close()
        log.Success('Successfull linked file {0}'.format(source))
    except subprocess.CalledProcessError:
        log.Error('Failed to Link {0} to {1}'.format(source, dest))


def LinkFiles(files):
    for dic in files:
        source = None
        dest = None
        for key in dic:
            if key == 'source':
                source = dic[key]
            if key == 'dest':
                dest = dic[key]
            # this loop is needed becouse chaining it into a string will result
            # in a cancelation of the installation of the packages if a brew package gets removed

        LinkFile(source, dest)


def Copy(source, dest):
    try:
        log.Info('Copy File {0}'.format(source))
        system('rm {0}'.format(dest))
        system('cp {0}/{1} {2}'.format(current_folder, source, dest))
        log.Success('Success Copy')
    except:
        log.Error('Failed to move file')


def Help():
    for option in sys.argv:
        if option == '--help' or option == '-h':
            log.Info('./install.py [options]')
            log.Info('Options:')
            log.Info('-u option, --update=option       | option = linux,darwin,sym')
            sys.exit(0)


def UpgradeDarwin():
    for option in sys.argv:
        if option == '--update=darwin' or option == '-u darwin':
            InstallCliPackages('brew upgrade', brew_dependencies)
            sys.exit(0)

def UpgradeLinux():
    for option in sys.argv:
        if option == '--update=linux' or option == '-u linux':
            InstallCliPackages('yay -Syu', [''])
            sys.exit(0)

def UpdateSymLinks(files_dict):
    for option in sys.argv:
        if option == '--update=sym' or option == '-u sym':
            LinkFiles(files_dict)
            sys.exit(0)

def Linux():
    UpgradeLinux()
    UpdateSymLinks(linking_files_arch)
    log.Critical('Linux is WIP')
    Install('mkdir -p ' + home + '/Pictures/Screenshots')
    Install('mkdir -p ' + home + '/.config')

    # git submodule pull
    log.Step("Pulling submodules", 1)
    Install('git submodule update --init --recursive')

    # cloning dependencies zsh theme and plugins
    try:
        Install('sudo pacman -S base-devel nvidia zsh docker docker-compose alacritty network-manager-applet kubectl xclip go rustup clang gcc cmake lightdm lightdm-webkit2-greeter vim tmux i3-gaps xorg networkmanager pulseaudio bat fd ripgrep neofetch python2 pyhton2-pip python python-pip rust-analyzer ninja')
        Install('yay -S nodenv nodenv-node-build-git brave-bin python-pynvim ueberzug neovim-nightly-git dunst-git polybar-git rofi-git picom-ibhagwan-git ttf-material-design-icon-webfont ttf-nerd-fonts-hack-complete-git bitwarden-bin bitwarden-rofi-git git-delta lightdm-webkit2-theme-glorious jdtls teams-for-linux rofi-emoji gromit-mpx')

        # nodenv setup
        Install('nodenv install 14.0.1')
        Install('nodenv install 12.8.0')
        Install('nodenv install 14.16.0')
        Install('nodenv global 14.16.0')

        # python setup
        Install('pip install neovim bpytop')
        Install('pip2 install neovim')

        # npm
        InstallCliPackages('npm install -g', node_packages)

        # rust setup
        Install('rustup install nightly')
        Install('rustup +nightly component add rust-analyzer-preview')

        # langservers
        Install('go get github.com/mattn/efm-langserver')

        # lua lsp
        Install('git clone https://github.com/sumneko/lua-language-server')

        # autosuggest
        Install('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        # highlight
        Install('git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-syntax-highlighting')

        # powerlevel10k
        Install('git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ' + current_folder + '/oh-my-zsh/custom' + '/themes/powerlevel10k')

        # tmux plugin manager
        Install('mkdir -p ' + home + '/.tmux/plugins/tpm')
        Install('git clone https://github.com/tmux-plugins/tpm ' + home + '/.tmux/plugins/tpm')

        # fzf docker
        Install('git clone https://github.com/pierpo/fzf-docker ' + current_folder + '/oh-my-zsh/custom' + '/plugins/fzf-docker')

        # linking
        Install('mkdir -p ' + home + '/.config/')
        LinkFiles(linking_files_arch)
    except OSError:
        log.Error("Error while install")


    sys.exit(0)

def Cygwin():
    log.Critical('Cygwin is Not Supported Yet')
    sys.exit(0)


def Darwin():
    UpgradeDarwin()
    log.Info("Starting Installation")
    log.Info("Installing Dependencies")
    Install('mkdir -p ' + home + '/Pictures/Screenshots')
    Install('mkdir -p ' + home + '/.config')

    # check if git is installed
    try:
        log.Step("Check if git is installed", 1)
        if not Call("git"):
            Install('xcode-select --install')
    except OSError:
        log.Error("git not found installing dev tools")
        Install('xcode-select --install')

    # check if brew is installed
    try:
        log.Step("Check if Homebrew is installed", 2)
        if not Call("brew"):
            system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
    except OSError:
        log.Error("brew not found installing brew")

    # git submodule pull
    log.Step("Pulling submodules", 4)
    Install('git submodule update --init --recursive')

    # install brew taps
    log.Step("Installing Homebrew Taps", 5)
    InstallTap('homebrew/cask-fonts')

    # install brew dependencies
    log.Step("Installing Homebrew CLI dependencies", 6)
    InstallCliPackages('brew install', brew_dependencies)

    # install git lfs
    log.Step("Installing git lfs", 6)
    Install('git lfs install')

    # install cask dependencies
    if not IsCI():
        log.Step("Installing Homebrew GUI dependencies", 7)
        InstallPackages('brew install --cask', cask_dependencies)

    # install node
    log.Step("Installing Node", 8)
    Install('nodenv install 12.8.0')
    Install('nodenv install 14.16.0')
    Install('nodenv global 14.16.0')

    # node packages
    log.Step("Installing Node Packages", 9)
    InstallCliPackages('npm install -g', node_packages)

    # install python packages
    log.Step("Installing Python PIP Packages", 10)
    InstallPackages('pip3 install', pip_packages)

    # cloning dependencies zsh theme and plugins
    try:
        log.Step("Cloning Shell Dependencies Themes Plugins", 13)
        # autosuggest
        Install('git clone https://github.com/zsh-users/zsh-autosuggestions ' + current_folder + '/oh-my-zsh/custom' + '/plugins/zsh-autosuggestions')

        Install('git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ' + current_folder + '/oh-my-zsh/custom' + '/themes/powerlevel10k')

        Install('git clone https://github.com/tmux-plugins/tpm ' + home + '/.tmux/plugins/tpm')

        # fzf docker
        Install('git clone https://github.com/pierpo/fzf-docker ' + current_folder + '/oh-my-zsh/custom' + '/plugins/fzf-docker')
    except OSError:
        log.Error("Error while cloning")

    # linking files
    try:
        log.Step("Linking zsh and vim files Symbolic", 14)
        LinkFiles(linking_files_mac)
    except OSError:
        log.Error("Error while linking files")

    # set default shell
    try:
        log.Step("Set zsh default shell", 15)
        Install('sudo chsh -s /usr/local/bin/zsh ' + user)
    except OSError:
        log.Error("Error while settings zsh shell")

    # exec zsh
    finish = datetime.now().strftime('%H:%M:%S')
    log.Success("Installation Done {0} - {1}".format(current_time, finish))
    system('zsh')
    sys.exit(0)


if __name__ == "__main__":
    Help()
    if sys.platform == 'linux':
        Linux()
    if sys.platform == 'darwin':
        Darwin()
    if sys.platform == 'cygwin':
        Cygwin()
