#!/usr/bin/env bash

mkdir -p ~/.config

echo "Adding .config/*"
cp -r config/* ~/.config/

echo "Adding ~/*"
cp -r home/.* ~/
