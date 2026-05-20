#!/bin/bash

D=$HOME/.config/hypr/wallpapers/
L=$(ls -1 $D | wc -l)
I=$(((RANDOM % $L) + 1))
R=("$HOME/.config/hypr/wallpapers/$I.jpeg")
hyprctl hyprpaper wallpaper ,$R
