#!/bin/bash
wall=$(ls "$HOME/Pictures/Wallpapers/"*.png 2>/dev/null | shuf -n 1)
ln -sf "$wall" /tmp/hyprlock-wallpaper
pidof hyprlock || hyprlock
