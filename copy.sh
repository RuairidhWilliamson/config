#!/usr/bin/env bash

mkdir -p ~/.config

echo "Adding .config/*"
cp -r config/* ~/.config/

echo "Adding tmux"
cp ./tmux.conf ~/.tmux.conf

echo "Adding gitconfig"
cp ./gitconfig ~/.gitconfig

echo "Adding global gitignore"
cp ./gitignore ~/.gitignore

echo "Adding bashrc"
cp ./bashrc ~/.bashrc

echo "Adding allowed signers"
cp ./allowed_signers ~/.ssh/allowed_signers
