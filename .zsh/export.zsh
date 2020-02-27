# Path to your oh-my-zsh installation.
export ZSH="/Users/$(id -un)/.dotfiles-darwin/oh-my-zsh/"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

# User exports
export PATH="/usr/local/sbin:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include:/usr/local/sbin:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr:/usr/local/bin:/usr/local/Cellar:/usr/bin:/bin:/usr/sbin:/sbin:/usr/include/libxml2:/Users/$(id -un)/Library/Python/2.7/bin:/usr/local/opt/llvm/bin:/usr/local/include:/$(id -un)/dnehrig/Library/Python/3.7/bin:/usr/local/share/dotnet"
export EDITOR='vim'
export DEFAULT_USER="$USER"
export TERM=xterm-256color
export UNCRUSTIFY_CONFIG=~/.dotfiles-darwin/.uncrustify
