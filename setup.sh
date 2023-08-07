#!/usr/bin/env bash

function mln () {
    if [ -L $2 ]
    then
        ln -sfr $1 $2
    else
        ln -sbir $1 $2
    fi
}

echo "Adding alacritty"
mkdir -p ~/.config/alacritty/
mln ./alacritty.yml ~/.config/alacritty/alacritty.yml

echo "Adding nvim"
# mln ./nvim.vim ~/.config/nvim/init.vim 
mkdir -p ~/.config/nvim/
mln ./nvim.lua ~/.config/nvim/init.lua

echo "Adding starship"
mln ./starship.toml ~/.config/starship.toml

echo "Adding tmux"
mln ./tmux.conf ~/.tmux.conf

echo "Adding gitconfig"
mln ./gitconfig ~/.gitconfig

echo "Adding global gitignore"
mln ./gitignore ~/.gitignore

echo "Adding bashrc"
mln ./bashrc ~/.bashrc

echo "Adding nushell"
mkdir -p ~/.config/nushell/
mln ./nushell/env.nu ~/.config/nushell/env.nu
mln ./nushell/config.nu ~/.config/nushell/config.nu

echo "Adding VSCode"
mkdir -p ~/.config/Code/User/
mln ./VSCode/settings.json ~/.config/Code/User/settings.json
mln ./VSCode/keybindings.json ~/.config/Code/User/keybindings.json

echo "Adding fish"
mkdir -p ~/.config/fish/
mln ./config.fish ~/.config/fish/config.fish

echo "Adding hyprland"
mkdir -p ~/.config/hypr/
mln ./hyprland.conf ~/.config/hypr/hyprland.conf
mln ./hyprpaper.conf ~/.config/hypr/hyprpaper.conf

echo "Adding eww"
ln -sfr ./eww/ ~/.config/eww

echo "Adding helix"
mln ./helix.toml ~/.config/helix/config.toml
