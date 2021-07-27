#!/usr/bin/env python

# This Script will install following items
# brew
# brew packages
# brew cask packages
# node packages
# python packages
# cargo packages
# go packages
# symbolic links
# note : see following arrays and or adjust them
# TODO: Get list of installed dependencies from stdout
# example: pip list
# pacman -Q
# pacman -Qm = yay dep

import subprocess
import os
import sys
from os import system
from getpass import getuser
from datetime import datetime
from distutils.spawn import find_executable

now = datetime.now()
current_time = now.strftime("%H:%M:%S")
current_folder = os.path.abspath(os.getcwd())
user = getuser()
home = "{0}{1}".format(os.environ.get("HOME"), "/")
pacman_packages = []

# source is context current folder + repo item
linking_files_mac = [
    {"source": ".config/alacritty_mac.yml", "dest": ".config/alacritty.yml"},
    {"source": ".tmux.mac.conf", "dest": ".tmux.conf"},
    {"source": ".config/yabai/yabairc", "dest": ".config/yabai/yabairc"},
    {"source": ".config/kak", "dest": ".config/kak"},
    {"source": ".config/skhd/skhdrc", "dest": ".config/skhd/skhdrc"},
    {"source": ".zsh/zshrc", "dest": ".zshrc"},
    {"source": ".ssh/config", "dest": ".ssh/config"},
    {"source": ".dotfiles-vim", "dest": ".vim"},
    {"source": ".config/nvim", "dest": ".config/nvim"},
    {"source": ".dotfiles-vim/vimrc", "dest": ".vimrc"},
    {"source": ".uncrustify", "dest": ".uncrustify"},
]

# TODO add logic to link executables to path
bin_files_arch = [{"source": "./scripts/locker.sh", "dest": "/usr/local/bin"}]

linking_files_arch = [
    {"source": ".tmux.conf", "dest": ".tmux.conf"},
    {"source": ".zsh/zshrc", "dest": ".zshrc"},
    {"source": ".ssh/config", "dest": ".ssh/config"},
    {"source": ".dotfiles-vim", "dest": ".vim"},
    {"source": ".config/kak", "dest": ".config/kak"},
    {"source": ".dotfiles-vim/vimrc", "dest": ".vimrc"},
    {"source": ".config/nvim", "dest": ".config/nvim"},
    {"source": ".config/i3", "dest": ".config/i3"},
    {"source": ".config/dunst", "dest": ".config/dunst"},
    {"source": "themes/rofi/oxide", "dest": ".config/rofi"},
    {"source": ".config/picom.conf", "dest": ".config/picom.conf"},
    {"source": ".config/alacritty.yml", "dest": ".config/alacritty.yml"},
    {"source": ".xinitrc", "dest": ".xinitrc"},
    {"source": ".Xresources", "dest": ".Xresources"},
    {"source": "polybar-powerline", "dest": ".config/polybar"},
]

pip_packages = [
    [ "psutil", "psutil" ],
    [ "black", "blackd" ],
    [ "aiohttp", "aiohttp" ],
    [ "aiohttp_cors", "aiohttp_cors" ],
    [ "neovim", "nvim" ]
]

brew_dependencies = [
    [ "mono", "mono" ],
    [ "tree",  "tree" ],
    [ "gdb", "gdb" ],
    [ "fzf", "fzf" ],
    [ "bat", "bat" ],
    [ "unrar", "unrar" ],
    [ "cmake", "cmake" ],
    [ "kubectl", "kubectl" ],
    [ "neofetch", "neofetch" ],
    [ "git-lfs", "git-lfs" ],
    [ "neofetch", "neofetch" ],
    [ "radare2", "radare2" ],
    [ "gcc", "gcc" ],
    [ "htop", "htop" ],
    [ "bashtop", "bashtop" ],
    [ "make", "make" ],
    [ "python", "python" ],
    [ "tmux", "tmux" ],
    [ "ruby", "ruby" ],
    [ "go", "go" ],
    [ "perl", "perl" ],
    [ "github/gh/gh", "gh" ],
    [ "hub", "hub" ],
    [ "lua", "lua" ],
    [ "--HEAD neovim", "nvim" ],
    [ "zsh", "zsh" ],
    [ "nodenv", "nodenv" ],
    [ "docker", "docker" ],
    [ "koekeishiya/formulae/skhd", "skhd" ],
    [ "koekeishiya/formulae/yabai", "yabai" ],
    [ "docker-compose", "docker-compose" ],
]

cask_dependencies = [
    [ "virtualbox", "virtualbox" ],
    [ "google-chrome", "google-chrome" ],
    [ "brave-browser", "brave-browser" ],
    [ "google-cloud-sdk", "google-cloud-sdk" ],
    [ "firefox", "firefox" ],
    [ "ghidra", "ghidra" ],
    [ "abstract", "abstract" ],
    [ "visual-studio-code", "visual-studio-code" ],
    [ "microsoft-office", "microsoft-office" ],
    [ "postman", "postman" ],
    [ "docker", "docker" ],
    [ "alacritty", "alacritty" ],
    [ "whatsapp", "whatsapp" ],
    [ "discord", "discord" ],
    [ "font-hack-nerd-font", "font-hack-nerd-font" ],
]

node_packages = [
    [ "nodemon", "nodemon" ],
    [ "yarn", "yarn" ],
    [ "typescript-language-server", "typescript-language-server" ],
    [ "typescript", "tsc" ],
    [ "lua-fmt", "luafmt" ],
    [ "vscode-html-languageserver-bin", "vscode-html-languageserver-bin" ],
    [ "css-language-server", "css-language-server" ],
    [ "svelte-language-server", "svelte-language-server" ],
    [ "bash-language-server", "bash-language-server" ],
    [ "yaml-language-server", "yaml-language-server" ],
    [ "dockerfile-language-server-nodejs", "dockerfile-language-server-nodejs" ],
    [ "dprint", "dprint" ],
    [ "pyright", "pyright" ],
    [ "@bitwarden/cli", "bw" ],
]

go_packages = [
    [ "mvdan.cc/sh/v3/cmd/shfmt", "shfmt" ]
]

rust_packages = [
    [ "blackd-client", "blackd-client" ]
]

arrow = "====>"


class Colors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


class Log(Colors):
    user = getuser()
    counter = 0

    def now(self):
        time = datetime.now()
        return time.strftime("%H:%M:%S")

    def buildLogString(self, kind: str, color: str):
        start = "{2} {0} " + color + "{1}:" + kind + " " + self.ENDC
        attach = self.HEADER + ": {3}" + self.ENDC
        return start + attach

    def buildStepString(self, kind: str, color: str):
        start = "{2} {0} " + color + "{1}:" + kind + " {4}/16" + self.ENDC
        attach = self.BOLD + ": {3}" + self.ENDC
        return start + attach

    def Success(self, string: str):
        st = self.buildLogString("SUCCESS", self.OKGREEN)
        print(st.format(self.now(), self.user, arrow, string))

    def Warning(self, string: str):
        st = self.buildLogString("WARNING", self.WARNING)
        print(st.format(self.now(), self.user, arrow, string))

    def Error(self, string: str):
        st = self.buildLogString("ERROR", self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Critical(self, string: str):
        st = self.buildLogString("CRITICAL", self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Info(self, string: str):
        st = self.buildLogString("INFO", self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string))

    def Step(self, string: str):
        st = self.buildStepString("STEP", self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string, self.counter))
        self.counter = self.counter + 1


log = Log()


def IsCI():
    result = False
    try:
        if os.environ.get("CI") == "yes":
            result = True
    except:
        return result
    return result


def Call(cmd: str):
    try:
        inPath = find_executable(cmd) is not None
        if not inPath:
            log.Warning("Not in Path {0}".format(cmd))
        return inPath
    except subprocess.CalledProcessError as e:
        log.Error(
            "Call Check {0} Failed with return code {1}".format(cmd, e.returncode)
        )


def InstallCliPackages(installCall: str, arr: list[list[str]], options: str = ""):
    for package in arr:
        log.Info("Installing CLI Package {0}".format(package))
        install = "{0} {1} {2}".format(installCall, package[0], options)
        cmdArr = install.split()
        try:
            inPath = Call(package[1])
            if not inPath:
                with open(os.devnull, "w") as f:
                    subprocess.call(cmdArr, stdout=f)
                    f.close()
                log.Success("Success Installing")
        except subprocess.CalledProcessError as e:
            log.Error(
                "Failed to install {0} with code {1}".format(package, e.returncode)
            )


def InstallPackages(installCall: str, arr: list[str], options: str = ""):
    for package in arr:
        log.Info("Installing Package {0}".format(package))
        install = "{0} {1} {2}".format(installCall, package, options)
        cmdArr = install.split()
        try:
            with open(os.devnull, "w") as f:
                subprocess.call(cmdArr, stdout=f)
                f.close()
            log.Success("Success Installing")
        except subprocess.CalledProcessError as e:
            log.Error(
                "Failed to install {0} with code {1}".format(package, e.returncode)
            )


def InstallTap(tap: str):
    try:
        log.Info("Installing tap {0}".format(tap))
        with open(os.devnull, "w") as f:
            subprocess.call(["brew", "tap", tap], stdout=f)
            f.close()
        log.Success("Success Installing tap")
    except subprocess.CalledProcessError as e:
        log.Error("Failed to install {0} with code {1}".format(tap, e.returncode))


def Install(call: str):
    try:
        log.Info("Installing {0}".format(call))
        cmdArr = call.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
    except subprocess.CalledProcessError:
        log.Error("Failed to install {0}".format(call))


def LinkFile(source: str, dest: str):
    "Creates a Symbolic Link"
    try:
        if not source or not dest:
            raise LookupError("Shit")
        log.Info("Linking File {0} to {1}".format(source, dest))
        with open(os.devnull, "w") as f:
            subprocess.call(
                ["ln", "-sfn", current_folder + "/" + source, home + dest], stdout=f
            )
            f.close()
        log.Success("Successfull linked file {0}".format(source))
    except subprocess.CalledProcessError:
        log.Error("Failed to Link {0} to {1}".format(source, dest))


def LinkFiles(files: list[dict[str, str]]):
    for dic in files:
        source = None
        dest = None
        for key in dic:
            if key == "source":
                source = dic[key]
            if key == "dest":
                dest = dic[key]
            # this loop is needed becouse chaining it into a string will result
            # in a cancelation of the installation of the packages if a brew package gets removed

        if source and dest:
            LinkFile(source, dest)


def Copy(source: str, dest: str):
    try:
        log.Info("Copy File {0}".format(source))
        system("rm {0}".format(dest))
        system("cp {0}/{1} {2}".format(current_folder, source, dest))
        log.Success("Success Copy")
    except:
        log.Error("Failed to move file")


def Help():
    for option in sys.argv:
        if option == "--help" or option == "-h":
            log.Info("./install.py [options]")
            log.Info("Options:")
            log.Info(
                "-u option, --update=option       | option = linux,darwin,sym,node,pip,cargo,go"
                "-i option, --install=option       | option = linux,darwin,sym,node,pip,cargo,go"
            )
            sys.exit(0)


def UpdateDarwin():
    for key, option in enumerate(sys.argv):
        if option == "--update=darwin" or (option == "-u" and sys.argv[key+1] == "darwin"):
            InstallCliPackages("brew upgrade", brew_dependencies)
            sys.exit(0)


def UpdateLinux():
    for key, option in enumerate(sys.argv):
        if option == "--update=linux" or (option == "-u" and sys.argv[key+1] == "linux"):
            InstallCliPackages("yay -Syu", [["",""]])
            sys.exit(0)


def InstallNode():
    for key, option in enumerate(sys.argv):
        if option == "--install=node" or (option == "-i" and sys.argv[key+1] == "node"):
            InstallCliPackages("npm install -g", node_packages)
            sys.exit(0)


def InstallPip():
    for key, option in enumerate(sys.argv):
        if option == "--install=pip" or (option == "-i" and sys.argv[key+1] == "pip"):
            InstallCliPackages("pip3.9 install", pip_packages)
            sys.exit(0)


def UpdatePip():
    for key, option in enumerate(sys.argv):
        if option == "--update=pip" or (option == "-u" and sys.argv[key+1] == "pip"):
            InstallCliPackages("pip3.9 update", pip_packages)
            sys.exit(0)


def InstallCargo():
    for key, option in enumerate(sys.argv):
        if option == "--install=cargo" or (option == "-i" and sys.argv[key+1] == "cargo"):
            InstallCliPackages("cargo install ", rust_packages)
            sys.exit(0)


def InstallGo():
    for key, option in enumerate(sys.argv):
        if option == "--install=go" or (option == "-i" and sys.argv[key+1] == "go"):
            InstallCliPackages("go get ", go_packages)
            sys.exit(0)


def UpdateNode():
    for key, option in enumerate(sys.argv):
        if option == "--update=node" or (option == "-u" and sys.argv[key+1] == "node"):
            InstallCliPackages("npm upgrade -g", node_packages)
            sys.exit(0)


def UpdateSymLinks(files_dict: list[dict[str, str]]):
    for key, option in enumerate(sys.argv):
        if option == "--update=sym" or (option == "-u" and sys.argv[key+1] == "sym"):
            LinkFiles(files_dict)
            sys.exit(0)


def Linux():
    log = Log()
    Install("mkdir -p " + home + "/Pictures/Screenshots")
    Install("mkdir -p " + home + "/.config")
    UpdateLinux()
    UpdateSymLinks(linking_files_arch)
    UpdateNode()
    UpdatePip()
    InstallPip()
    InstallCargo()
    InstallNode()
    InstallGo()
    log.Critical("Linux is WIP")

    # git submodule pull
    log.Step("Pulling submodules")
    Install("git submodule update --init --recursive")

    # cloning dependencies zsh theme and plugins
    try:
        log.Step("Install System Dependencies")
        Install(
            "sudo pacman -S base-devel nvidia zsh docker docker-compose alacritty network-manager-applet kubectl xclip go rustup clang gcc cmake lightdm lightdm-webkit2-greeter vim tmux i3-gaps xorg networkmanager pulseaudio bat fd ripgrep neofetch python2 pyhton2-pip python python-pip rust-analyzer ninja"
        )
        Install(
            "yay -S nodenv nodenv-node-build-git brave-bin python-pynvim ueberzug neovim-nightly-git dunst-git polybar-git rofi-git picom-ibhagwan-git ttf-material-design-icon-webfont ttf-nerd-fonts-hack-complete-git bitwarden-bin bitwarden-rofi-git git-delta lightdm-webkit2-theme-glorious jdtls teams-for-linux rofi-emoji gromit-mpx"
        )

        # nodenv setup
        log.Step("Install nodenv")
        Install("nodenv install 16.4.2")
        Install("nodenv install 12.8.0")
        Install("nodenv global 16.4.2")

        log.Step("Install pip dependencies")
        # python setup
        InstallCliPackages("pip3.9 install", pip_packages)

        # npm
        log.Step("Install npm dependencies")
        InstallCliPackages("npm install -g", node_packages)

        # rust setup
        log.Step("Install rustup components")
        Install("rustup install nightly")
        Install("rustup +nightly component add rust-analyzer-preview")

        # langservers
        log.Step("Install langservers")
        Install("go get github.com/mattn/efm-langserver")

        # lua lsp
        Install("git clone https://github.com/sumneko/lua-language-server")

        log.Step("Install tmux plugin manager")
        # tmux plugin manager
        Install("mkdir -p " + home + "/.tmux/plugins/tpm")
        Install(
            "git clone https://github.com/tmux-plugins/tpm "
            + home
            + "/.tmux/plugins/tpm"
        )

        # linking
        log.Step("Sym Linking Folders")
        LinkFiles(linking_files_arch)
    except OSError:
        log.Error("Error while install")

    sys.exit(0)


def Cygwin():
    log = Log()
    log.Critical("Cygwin is Not Supported")
    sys.exit(0)


def Darwin():
    log = Log()
    Install("mkdir -p " + home + "/Pictures/Screenshots")
    Install("mkdir -p " + home + "/.config/skhd")
    Install("mkdir -p " + home + "/.config/yabai")
    UpdateDarwin()
    UpdateSymLinks(linking_files_mac)
    UpdateNode()
    UpdatePip()
    InstallPip()
    InstallCargo()
    InstallGo()
    InstallNode()
    log.Info("Starting Installation")
    log.Info("Installing Dependencies")

    # check if git is installed
    try:
        log.Step("Check if git is installed")
        if not Call("git"):
            Install("xcode-select --install")
    except OSError:
        log.Error("git not found installing dev tools")
        Install("xcode-select --install")

    # check if brew is installed
    try:
        log.Step("Check if Homebrew is installed")
        if not Call("brew"):
            system(
                '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
            )
    except OSError:
        log.Error("brew not found installing brew")

    # git submodule pull
    log.Step("Pulling submodules")
    Install("git submodule update --init --recursive")

    # install brew taps
    log.Step("Installing Homebrew Taps")
    InstallTap("homebrew/cask-fonts")

    # install brew dependencies
    log.Step("Installing Homebrew CLI dependencies")
    InstallCliPackages("brew install", brew_dependencies)

    # install git lfs
    log.Step("Installing git lfs")
    Install("git lfs install")

    # install cask dependencies
    if not IsCI():
        log.Step("Installing Homebrew GUI dependencies")
        InstallCliPackages("brew install --cask", cask_dependencies)

    # install node
    log.Step("Installing Node")
    Install("nodenv install 12.8.0")
    Install("nodenv install 16.4.2")
    Install("nodenv global 16.4.2")

    # node packages
    log.Step("Installing Node Packages")
    InstallCliPackages("npm install -g", node_packages)

    # install python packages
    log.Step("Installing Python PIP Packages")
    InstallCliPackages("pip3.9 install", pip_packages)

    Install(
        "git clone https://github.com/tmux-plugins/tpm " + home + "/.tmux/plugins/tpm"
    )

    # linking files
    try:
        log.Step("Linking zsh and vim files Symbolic")
        LinkFiles(linking_files_mac)
    except OSError:
        log.Error("Error while linking files")

    # set default shell
    try:
        log.Step("Set zsh default shell")
        Install("sudo chsh -s /usr/local/bin/zsh " + user)
    except OSError:
        log.Error("Error while settings zsh shell")

    # exec zsh
    finish = datetime.now().strftime("%H:%M:%S")
    log.Success("Installation Done {0} - {1}".format(current_time, finish))
    system("zsh")
    sys.exit(0)


if __name__ == "__main__":
    Help()
    log.Info("Detected system is {0}".format(sys.platform))

    try:
        if sys.platform == "cygwin":
            Cygwin()

        if sys.platform == "darwin":
            Darwin()

        if sys.platform == "linux":
            Linux()

    except:
        # TODO: figure out why error
        log.Error("Error While Installing")
