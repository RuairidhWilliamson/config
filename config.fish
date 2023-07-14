set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH /usr/local/go/bin $PATH

# pnpm
set PNPM_HOME $HOME/.local/share/pnpm
set PATH $PNPM_HOME $PATH
# pnpm end

# bob nvim
set PATH $HOME/.local/share/bob/nvim-bin $PATH

rtx activate fish | source
starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    # use the coolbeans theme
    # fish_config theme choose coolbeans
end
