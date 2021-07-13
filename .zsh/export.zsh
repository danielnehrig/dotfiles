# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/oh-my-zsh"

# Adding Path Data Linux
if [[ `uname` == "Linux"  ]]; then
PATH+=":$HOME/.local/lib/python3.9/site-packages"
PATH+=":$HOME/.local/bin"
PATH+=":$HOME/.cargo/bin"
PATH+=":$HOME/go/bin"
PATH+=":$HOME/.gem/ruby/2.7.0/bin"
PATH+=":$HOME/.npm/bin"
fi

# User exports
if [[ `uname` == "Darwin"  ]]; then
PATH+=":/usr/local/share/dotnet"
PATH+=":/usr/local/opt/llvm/bin/"

PATH+=":$HOME/dotfiles/lua-language-server/bin/macOS"
# PATH+=":/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include"
fi

export EDITOR='nvim'
export DEFAULT_USER="$USER"
export UNCRUSTIFY_CONFIG=~/dotfiles/.uncrustify
export COMPOSE_PARALLEL_LIMIT=1000
export COMPOSE_HTTP_TIMEOUT=120
