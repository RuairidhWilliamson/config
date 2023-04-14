set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
alias pn=pnpm
# pnpm end

rtx activate fish | source
starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    # use the coolbeans theme
    # fish_config theme choose coolbeans
end
