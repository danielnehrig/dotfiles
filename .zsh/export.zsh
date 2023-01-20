# Adding Path Data Linux
if [[ `uname` == "Linux"  ]]; then
PATH+=":$HOME/.local/lib/python3.9/site-packages"
PATH+=":$HOME/.local/bin"
PATH+=":$HOME/.luarocks/bin"
PATH+=":$HOME/.cargo/bin"
PATH+=":$HOME/go/bin"
PATH+=":$HOME/.gem/ruby/2.7.0/bin"
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
