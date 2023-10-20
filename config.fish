set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH /usr/local/go/bin $PATH

# pnpm
# set PNPM_HOME $HOME/.local/share/pnpm
# set PATH $PNPM_HOME $PATH
# pnpm end

# bob nvim
# set PATH $HOME/.local/share/bob/nvim-bin $PATH

# rtx activate fish | source
starship init fish | source

# direnv
# direnv hook fish | source

alias ls="eza --icons"

set -e SSH_AGENT_PID
set SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"
set GPG_TTY $(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
