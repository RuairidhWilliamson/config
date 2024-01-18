set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH /usr/local/go/bin $PATH

starship init fish | source

alias ls="eza --icons"
set SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
