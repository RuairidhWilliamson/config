#!/usr/bin/env bash

set -e

ffmpeg -y -i ~/desktop.jpg -vf "[in] gblur=sigma=100 [out]" ~/desktop-blur.jpg

swaylock -rFc 000000 --font "RobotoMono Nerd Font Mono" --line-color 00000000 --separator-color 00000000 --text-color ffffff --image ~/desktop-blur.jpg'