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
from typing import TypedDict, List, Union
from os import system
from getpass import getuser
from datetime import datetime
from distutils.spawn import find_executable


class SymLink(TypedDict):
    source: str
    dest: str


# Modes available to Package managers
class Modes(TypedDict):
    # Install Packages
    install: str
    # Update Packages hint: update can also be install as a value
    # becouse some package managers don't do update commands
    # might make this optional
    update: str


class PackageManager(TypedDict):
    # cli tool name (package manager name)
    cli_tool: str
    # index[0] is the package name index[1] is the bin name in path
    packages: list[tuple[str, Union[str, None]]]
    # the mode key is the internal compression check for behaviour in doing cli commands
    # on a package manager and the value is the command passed to the package manager
    modes: Modes


steps: int = 0
now: datetime = datetime.now()
current_time: str = now.strftime("%H:%M:%S")
current_folder: str = os.path.abspath(os.getcwd())
user: str = getuser()
home: str = "{0}{1}".format(os.environ.get("HOME"), "/")

# source is context current folder + repo item
linking_files_mac: List[SymLink] = [
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
bin_files_arch: List[SymLink] = [
    {"source": "./scripts/locker.sh", "dest": "/usr/local/bin"}
]

linking_files_arch: List[SymLink] = [
    {"source": ".tmux.conf", "dest": ".tmux.conf"},
    {"source": ".zsh/zshrc", "dest": ".zshrc"},
    {"source": ".ssh/config", "dest": ".ssh/config"},
    {"source": ".dotfiles-vim", "dest": ".vim"},
    {"source": ".config/kak", "dest": ".config/kak"},
    {"source": ".dotfiles-vim/vimrc", "dest": ".vimrc"},
    {"source": ".config/nvim", "dest": ".config/nvim"},
    {"source": ".config/i3", "dest": ".config/i3"},
    {"source": ".config/sway", "dest": ".config/sway"},
    {"source": ".config/dunst", "dest": ".config/dunst"},
    {"source": "themes/rofi/oxide", "dest": ".config/rofi"},
    {"source": ".config/picom.conf", "dest": ".config/picom.conf"},
    {"source": ".config/alacritty.yml", "dest": ".config/alacritty.yml"},
    {"source": ".xinitrc", "dest": ".xinitrc"},
    {"source": ".Xresources", "dest": ".Xresources"},
    {"source": "polybar-powerline", "dest": ".config/polybar"},
]

# Python PIP Package Manager
python: PackageManager = {
    "cli_tool": "pip",
    "modes": {"install": "install", "update": "install"},
    "packages": [("psutil", None), ("neovim", None)],
}


# Node NPM Package Manager
brew: PackageManager = {
    "cli_tool": "brew",
    "modes": {"install": "install", "update": "upgrade"},
    "packages": [
        ("exa", "exa"),
        ("mono", "mono"),
        ("tree", "tree"),
        ("gdb", "gdb"),
        ("fzf", "fzf"),
        ("bat", "bat"),
        ("unrar", "unrar"),
        ("cmake", "cmake"),
        ("kubectl", "kubectl"),
        ("neofetch", "neofetch"),
        ("git-lfs", "git-lfs"),
        ("neofetch", "neofetch"),
        ("radare2", "radare2"),
        ("gcc", "gcc"),
        ("htop", "htop"),
        ("bashtop", "bashtop"),
        ("make", "make"),
        ("python", "python"),
        ("tmux", "tmux"),
        ("ruby", "ruby"),
        ("go", "go"),
        ("perl", "perl"),
        ("github/gh/gh", "gh"),
        ("hub", "hub"),
        ("lua", "lua"),
        ("--HEAD neovim", "nvim"),
        ("zsh", "zsh"),
        ("nodenv", "nodenv"),
        ("onefetch", "onefetch"),
        ("koekeishiya/formulae/skhd", "skhd"),
        ("koekeishiya/formulae/yabai", "yabai"),
        ("docker-compose", "docker-compose"),
    ],
}

# Node NPM Package Manager
node: PackageManager = {
    "cli_tool": "npm",
    "modes": {"install": "install -g", "update": "upgrade -g"},
    "packages": [
        ("nodemon", "nodemon"),
        ("yarn", "yarn"),
        ("typescript", "tsc"),
        ("@bitwarden/cli", "bw"),
    ],
}

# Node NPM Package Manager
brew_cask: PackageManager = {
    "cli_tool": "brew",
    "modes": {"install": "install --cask", "update": "upgrade --cask"},
    "packages": [
        ("virtualbox", None),
        ("google-chrome", None),
        ("brave-browser", None),
        ("google-cloud-sdk", None),
        ("firefox", None),
        ("ghidra", None),
        ("visual-studio-code", None),
        ("microsoft-office", None),
        ("postman", None),
        ("docker", "docker"),
        ("kitty", None),
        ("whatsapp", None),
        ("discord", None),
        ("font-hack-nerd-font", None),
    ],
}


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
    user: str = getuser()
    counter: int = 0
    # TODO
    loglevel: str = "info"

    def now(self) -> str:
        time: datetime = datetime.now()
        return time.strftime("%H:%M:%S")

    def buildLogString(self, kind: str, color: str) -> str:
        start: str = "{2} {0} " + color + "{1}:" + kind + "\t" + self.ENDC
        attach: str = self.BOLD + "\t--> {3}" + self.ENDC
        return start + attach

    def buildStepString(self, kind: str, color: str) -> str:
        start: str = "{2} {0} " + color + "{1}:" + kind + "\t{4}/" + "{5}" + self.ENDC
        attach: str = self.BOLD + "\t--> {3}" + self.ENDC
        return start + attach

    def Success(self, string: str) -> None:
        st: str = self.buildStepString("SUCCESS", self.OKGREEN)
        print(st.format(self.now(), self.user, arrow, string, self.counter, steps))
        self.counter = self.counter + 1

    def Warning(self, string: str) -> None:
        st: str = self.buildLogString("WARNING", self.WARNING)
        print(st.format(self.now(), self.user, arrow, string))

    def Error(self, string: str) -> None:
        st: str = self.buildLogString("ERROR", self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Critical(self, string: str) -> None:
        st: str = self.buildLogString("CRITICAL", self.FAIL)
        print(st.format(self.now(), self.user, arrow, string))

    def Info(self, string: str) -> None:
        st: str = self.buildLogString("INFO", self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string))

    def Skip(self, string: str) -> None:
        st: str = self.buildStepString("SKIP", self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string, self.counter, steps))
        self.counter = self.counter + 1

    def Step(self, string: str) -> None:
        st: str = self.buildStepString("STEP", self.OKBLUE)
        print(st.format(self.now(), self.user, arrow, string, self.counter, steps))


log: Log = Log()


def cmd(call: str) -> None:
    try:
        log.Info("Executing {0}{1}{2}".format(Colors.WARNING, call, Colors.ENDC))
        cmdArr = call.split()
        with open(os.devnull, "w") as f:
            subprocess.call(cmdArr, stdout=f)
            f.close()
    except subprocess.CalledProcessError as err:
        log.Error("Failed to execute {0}".format(call))
        log.Error("Trace {0}".format(err))


def in_path(cmd: str) -> bool:
    inPath = False
    try:
        inPath = find_executable(cmd) is not None
    except subprocess.CalledProcessError as e:
        log.Error(
            "Call Check {0} Failed with return code {1}".format(cmd, e.returncode)
        )

    return inPath


def install_cli_packages(package_manager: PackageManager):
    if not in_path(package_manager["cli_tool"]):
        log.Error(
            "{0}{1}{2} not in path skipping installing".format(
                Colors.FAIL, package_manager["cli_tool"]
            )
        )
        return
    mode = get_package_mode()
    for package in package_manager["packages"]:
        install = "{0} {1} {2}".format(
            package_manager["cli_tool"], package_manager["modes"][mode], package[0]
        )
        try:
            if package[1]:
                inPath = in_path(package[1])
            else:
                inPath = False
            isForce = mode == "update" and True or False
            for _, option in enumerate(sys.argv):
                if option == "--force":
                    isForce = True

            if not inPath or isForce:
                log.Info(
                    "Installing CLI Package {0}{1}".format(Colors.OKGREEN, package[0])
                )
                cmd(install)
                log.Success(
                    "Success Installing package {0}{1}".format(
                        Colors.OKGREEN, package[0]
                    )
                )
            else:
                log.Skip(
                    "CLI Package {0}{1}{2} in path".format(
                        Colors.OKBLUE, package[0], Colors.ENDC
                    )
                )
        except subprocess.CalledProcessError as e:
            log.Error(
                "Failed to install {0}{1}{2} with code {3}".format(
                    Colors.FAIL, package, Colors.ENDC, e.returncode
                )
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


def link_files(files: List[SymLink]):
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


def get_package_mode() -> str:
    mode = "install"
    for option in sys.argv:
        if option == "--update" or option == "-u":
            mode = "update"

    return mode


def Linux():
    cmd("mkdir -p " + home + "/Pictures/Screenshots")
    cmd("mkdir -p " + home + "/.config")
    cmd("mkdir -p " + home + "/code/work")
    cmd("mkdir -p " + home + "/Video/screencast")

    # cloning dependencies zsh theme and plugins
    try:
        log.Step("Install pip dependencies")
        # python setup
        install_cli_packages(python)

        # npm
        log.Step("Install npm dependencies")
        install_cli_packages(node)

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
    install_cli_packages(brew)

    # install git lfs
    log.Step("Installing git lfs")
    cmd("git lfs install")

    # install cask dependencies
    log.Step("Installing Homebrew GUI dependencies")
    install_cli_packages(brew_cask)

    # install node
    log.Step("Installing Node")
    cmd("nodenv install 12.8.0")
    cmd("nodenv install 16.4.2")
    cmd("nodenv global 16.4.2")

    # node packages
    log.Step("Installing Node Packages")
    install_cli_packages(node)

    # install python packages
    log.Step("Installing Python PIP Packages")
    install_cli_packages(python)

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
