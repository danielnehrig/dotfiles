# Adding Path Data Linux
if [[ `uname` == "Linux"  ]]; then
NEW_PATH+=":$HOME/.local/lib/python3.9/site-packages"
NEW_PATH+=":$HOME/.local/bin"
NEW_PATH+=":$HOME/.luarocks/bin"
NEW_PATH+=":$HOME/.cargo/bin"
NEW_PATH+=":$HOME/go/bin"
NEW_PATH+=":$HOME/.gem/ruby/2.7.0/bin"
PATH=$NEW_PATH$PATH
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# User exports
if [[ `uname` == "Darwin"  ]]; then
ulimit -n 4096
PATH+=":/usr/local/share/dotnet"
PATH+=":/usr/local/opt/llvm/bin/"
PATH+=":/usr/local/sbin"
PATH+=":$HOME/go/bin"
PATH+=":$HOME/.luarocks/bin"
PATH+=":$HOME/.dotnet/tools"
fi

export EDITOR='nvim'
export DEFAULT_USER="$USER"
export UNCRUSTIFY_CONFIG=$HOME/dotfiles/.uncrustify
export COMPOSE_PARALLEL_LIMIT=1000
export COMPOSE_HTTP_TIMEOUT=120
export COLORTERM=truecolor
