#!/bin/bash

function mln () {
    if [ -L $2 ]
    then
        ln -sfr $1 $2
    else
        ln -sbir $1 $2
    fi
}

echo "Adding alacritty"
mln ./alacritty.yml ~/.config/alacritty/alacritty.yml

echo "Adding nvim"
mln ./nvim.vim ~/.config/nvim/init.vim 

echo "Adding tmux"
mln ./tmux.conf ~/.tmux.conf

echo "Adding gitconfig"
mln ./gitconfig ~/.gitconfig

echo "Adding global gitignore"
mln ./gitignore ~/.gitignore


echo "Adding VSCode"
mln ./VSCode/settings.json ~/.config/Code/User/settings.json
mln ./VSCode/keybindings.json ~/.config/Code/User/keybindings.json
