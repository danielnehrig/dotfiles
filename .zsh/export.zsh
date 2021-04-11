# Path to your oh-my-zsh installation.
export ZSH="$HOME/.dotfiles-darwin/oh-my-zsh"

# Adding Path Data Linux
if [[ `uname` == "Linux"  ]]; then
PATH+=":$HOME/.local/lib/python3.8/site-packages"
PATH+=":$HOME/.local/bin"
PATH+=":$HOME/.cargo/bin"
PATH+=":$HOME/go/bin"
PATH+=":$HOME/.gem/ruby/2.7.0/bin"
PATH+=":$HOME/.npm/bin"
fi

# LDFLAGS Mac

# User exports
if [[ `uname` == "Darwin"  ]]; then
# export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export PATH="/usr/local/sbin:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include:/usr/local/sbin:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr:/usr/local/bin:/usr/local/Cellar:/usr/bin:/bin:/usr/sbin:/sbin:/usr/include/libxml2:/Users/$(id -un)/Library/Python/2.7/bin:/usr/local/opt/llvm/bin:/usr/local/include:/$(id -un)/dnehrig/Library/Python/3.7/bin:/usr/local/share/dotnet:/Library/TeX/texbin"
PATH+=":$HOME/.cargo/bin"
fi
export EDITOR='vim'
export DEFAULT_USER="$USER"
# export TERM=xterm-256color
export UNCRUSTIFY_CONFIG=~/.dotfiles-darwin/.uncrustify
export COMPOSE_PARALLEL_LIMIT=1000
export COMPOSE_HTTP_TIMEOUT=120
