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

# python packages
pip_packages = [["psutil", "psutil"], ["neovim", "nvim"]]

# mac osx packages
brew_dependencies = [
    ["exa", "exa"],
    ["mono", "mono"],
    ["tree", "tree"],
    ["gdb", "gdb"],
    ["fzf", "fzf"],
    ["bat", "bat"],
    ["unrar", "unrar"],
    ["cmake", "cmake"],
    ["kubectl", "kubectl"],
    ["neofetch", "neofetch"],
    ["git-lfs", "git-lfs"],
    ["neofetch", "neofetch"],
    ["radare2", "radare2"],
    ["gcc", "gcc"],
    ["htop", "htop"],
    ["bashtop", "bashtop"],
    ["make", "make"],
    ["python", "python"],
    ["tmux", "tmux"],
    ["ruby", "ruby"],
    ["go", "go"],
    ["perl", "perl"],
    ["github/gh/gh", "gh"],
    ["hub", "hub"],
    ["lua", "lua"],
    ["--HEAD neovim", "nvim"],
    ["zsh", "zsh"],
    ["nodenv", "nodenv"],
    ["docker", "docker"],
    ["koekeishiya/formulae/skhd", "skhd"],
    ["koekeishiya/formulae/yabai", "yabai"],
    ["docker-compose", "docker-compose"],
]

# mac desktop apps
cask_dependencies = [
    ["virtualbox", "virtualbox"],
    ["google-chrome", "google-chrome"],
    ["brave-browser", "brave-browser"],
    ["google-cloud-sdk", "google-cloud-sdk"],
    ["firefox", "firefox"],
    ["ghidra", "ghidra"],
    ["abstract", "abstract"],
    ["visual-studio-code", "visual-studio-code"],
    ["microsoft-office", "microsoft-office"],
    ["postman", "postman"],
    ["docker", "docker"],
    ["alacritty", "alacritty"],
    ["whatsapp", "whatsapp"],
    ["discord", "discord"],
    ["font-hack-nerd-font", "font-hack-nerd-font"],
]

# nodejs global bins
node_packages = [
    ["nodemon", "nodemon"],
    ["yarn", "yarn"],
    ["typescript", "tsc"],
    ["@bitwarden/cli", "bw"],
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


def cmd(call: str):
    try:
        log.Info("Executing {0}".format(call))
        cmdArr = call.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
    except subprocess.CalledProcessError as err:
        log.Error("Failed to execute {0}".format(call))
        log.Error("Trace {0}".format(err))


def in_path(cmd: str):
    try:
        inPath = find_executable(cmd) is not None
        return inPath
    except subprocess.CalledProcessError as e:
        log.Error(
            "Call Check {0} Failed with return code {1}".format(cmd, e.returncode)
        )


def install_cli_packages(
    cli_tool: str, cli_options: str, arr: list[list[str]], options: str = ""
):
    if not in_path(cli_tool):
        log.Warning("{0} not in path skipping installing".format(cli_tool))
        return
    for package in arr:
        log.Info("Installing CLI Package {0}".format(package[0]))
        install = "{0} {1} {2} {3}".format(cli_tool, cli_options, package[0], options)
        try:
            inPath = in_path(package[1])
            if not inPath:
                cmd(install)
                log.Success("Success Installing package {0}".format(package[0]))
        except subprocess.CalledProcessError as e:
            log.Error(
                "Failed to install {0} with code {1}".format(package, e.returncode)
            )


def install_tap(tap: str):
    try:
        log.Info("Installing tap {0}".format(tap))
        with open(os.devnull, "w") as f:
            subprocess.call(["brew", "tap", tap], stdout=f)
            f.close()
        log.Success("Success Installing tap")
    except subprocess.CalledProcessError as e:
        log.Error("Failed to install {0} with code {1}".format(tap, e.returncode))


def link_file(source: str, dest: str):
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
    except subprocess.CalledProcessError as er:
        log.Error("Failed to Link {0} to {1}".format(source, dest))
        log.Error("Trace {0}".format(er))


def link_files(files: list[dict[str, str]]):
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
            link_file(source, dest)


def copy(source: str, dest: str):
    try:
        log.Info("Copy File {0}".format(source))
        system("rm {0}".format(dest))
        system("cp {0}/{1} {2}".format(current_folder, source, dest))
        log.Success("Success Copy")
    except:
        log.Error("Failed to move file")


def help():
    for option in sys.argv:
        if option == "--help" or option == "-h":
            log.Info("./install.py [options]")
            log.Info("Options:")
            log.Info(
                "-u option, --update=option       | option = linux,darwin,sym,node,pip,cargo,go"
                "-i option, --install=option       | option = linux,darwin,sym,node,pip,cargo,go"
            )
            sys.exit(0)


def update_darwin():
    for key, option in enumerate(sys.argv):
        if option == "--update=darwin" or (
            option == "-u" and sys.argv[key + 1] == "darwin"
        ):
            install_cli_packages("brew", "upgrade", brew_dependencies)
            sys.exit(0)


def update_linux():
    for key, option in enumerate(sys.argv):
        if option == "--update=linux" or (
            option == "-u" and sys.argv[key + 1] == "linux"
        ):
            install_cli_packages("yay", "-Syu", [["", ""]])
            sys.exit(0)


def install_node():
    for key, option in enumerate(sys.argv):
        if option == "--install=node" or (
            option == "-i" and sys.argv[key + 1] == "node"
        ):
            install_cli_packages("npm", "install -g", node_packages)
            sys.exit(0)


def install_pip():
    for key, option in enumerate(sys.argv):
        if option == "--install=pip" or (option == "-i" and sys.argv[key + 1] == "pip"):
            install_cli_packages("pip3.9", "install", pip_packages)
            sys.exit(0)


def update_pip():
    for key, option in enumerate(sys.argv):
        if option == "--update=pip" or (option == "-u" and sys.argv[key + 1] == "pip"):
            install_cli_packages("pip3.9", "update", pip_packages)
            sys.exit(0)


def update_node():
    for key, option in enumerate(sys.argv):
        if option == "--update=node" or (
            option == "-u" and sys.argv[key + 1] == "node"
        ):
            install_cli_packages("npm", "upgrade -g", node_packages)
            sys.exit(0)


def update_sym_links(files_dict: list[dict[str, str]]):
    for key, option in enumerate(sys.argv):
        if option == "--update=sym" or (option == "-u" and sys.argv[key + 1] == "sym"):
            link_files(files_dict)
            sys.exit(0)


def Linux():
    cmd("mkdir -p " + home + "/Pictures/Screenshots")
    cmd("mkdir -p " + home + "/.config")
    cmd("mkdir -p " + home + "/code/work")
    update_linux()
    update_sym_links(linking_files_arch)
    update_node()
    update_pip()
    install_pip()
    install_node()
    log.Critical("Linux is WIP")

    # git submodule pull
    log.Step("Pulling submodules")
    cmd("git submodule update --init --recursive")

    # cloning dependencies zsh theme and plugins
    try:
        log.Step("Install System Dependencies")
        cmd(
            "sudo pacman -S base-devel nvidia zsh docker docker-compose alacritty tree maim exa network-manager-applet kubectl xclip go rustup clang gcc cmake lightdm lightdm-webkit2-greeter vim tmux i3-gaps xorg networkmanager pulseaudio bat fd ripgrep neofetch python2 pyhton2-pip python python-pip rust-analyzer ninja"
        )
        cmd(
            "yay -S nodenv nodenv-node-build-git brave-bin python-pynvim ueberzug neovim-git dunst-git polybar-git rofi-git picom-ibhagwan-git ttf-material-design-icon-webfont nerd-fonts-fira-mono nerd-fonts-noto-sans-mono nerd-fonts-complete bitwarden-bin bitwarden-rofi-git git-delta lightdm-webkit2-theme-glorious jdtls teams-for-linux rofi-emoji gromit-mpx"
        )

        # nodenv setup
        log.Step("Install nodenv")
        cmd("nodenv install 16.4.2")
        cmd("nodenv global 16.4.2")

        log.Step("Install pip dependencies")
        # python setup
        install_cli_packages("pip3.9", "install", pip_packages)

        # npm
        log.Step("Install npm dependencies")
        install_cli_packages("npm", "install -g", node_packages)

        # rust setup
        log.Step("Install rustup components")
        cmd("rustup install nightly")
        cmd("rustup +nightly component add rust-analyzer-preview")

        log.Step("Install tmux plugin manager")
        # tmux plugin manager
        cmd("mkdir -p " + home + "/.tmux/plugins/tpm")
        cmd(
            "git clone https://github.com/tmux-plugins/tpm "
            + home
            + "/.tmux/plugins/tpm"
        )

        # linking
        log.Step("Sym Linking Folders")
        link_files(linking_files_arch)
    except OSError:
        log.Error("Error while install")


def Cygwin():
    log.Critical("Cygwin is Not Supported")
    sys.exit(0)


def Darwin():
    cmd("mkdir -p " + home + "/Pictures/Screenshots")
    cmd("mkdir -p " + home + "/.config/skhd")
    cmd("mkdir -p " + home + "/.config/yabai")
    update_darwin()
    update_sym_links(linking_files_mac)
    update_node()
    update_pip()
    install_pip()
    install_node()
    log.Info("Starting Installation")
    log.Info("Installing Dependencies")

    # check if git is installed
    try:
        log.Step("Check if git is installed")
        if not in_path("git"):
            cmd("xcode-select --install")
    except OSError:
        log.Error("git not found installing dev tools")
        cmd("xcode-select --install")

    # check if brew is installed
    try:
        log.Step("Check if Homebrew is installed")
        if not in_path("brew"):
            system(
                '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
            )
    except OSError:
        log.Error("brew not found installing brew")

    # git submodule pull
    log.Step("Pulling submodules")
    cmd("git submodule update --init --recursive")

    # install brew taps
    log.Step("Installing Homebrew Taps")
    install_tap("homebrew/cask-fonts")

    # install brew dependencies
    log.Step("Installing Homebrew CLI dependencies")
    install_cli_packages("brew", "install", brew_dependencies)

    # install git lfs
    log.Step("Installing git lfs")
    cmd("git lfs install")

    # install cask dependencies
    if not IsCI():
        log.Step("Installing Homebrew GUI dependencies")
        install_cli_packages("brew", "install --cask", cask_dependencies)

    # install node
    log.Step("Installing Node")
    cmd("nodenv install 12.8.0")
    cmd("nodenv install 16.4.2")
    cmd("nodenv global 16.4.2")

    # node packages
    log.Step("Installing Node Packages")
    install_cli_packages("npm", "install -g", node_packages)

    # install python packages
    log.Step("Installing Python PIP Packages")
    install_cli_packages("pip3.9", "install", pip_packages)

    cmd("git clone https://github.com/tmux-plugins/tpm " + home + "/.tmux/plugins/tpm")

    # linking files
    try:
        log.Step("Linking zsh and vim files Symbolic")
        link_files(linking_files_mac)
    except OSError:
        log.Error("Error while linking files")

    # set default shell
    try:
        log.Step("Set zsh default shell")
        cmd("sudo chsh -s /usr/local/bin/zsh " + user)
    except OSError:
        log.Error("Error while settings zsh shell")

    # exec zsh
    finish = datetime.now().strftime("%H:%M:%S")
    log.Success("Installation Done {0} - {1}".format(current_time, finish))
    system("zsh")


if __name__ == "__main__":
    help()
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
        # if it throws one
        log.Error("Error While Installing")
