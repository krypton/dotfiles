#!/bin/bash

# Screenshot script for Hyprland
# Saves to ~/Pictures/Screenshots and copies to clipboard
# Usage: screenshot.sh [mode]
# Modes: full, region, window

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$SAVE_DIR/screenshot_$TIMESTAMP.png"

case $1 in
    full)
        grim "$FILE"
        wl-copy < "$FILE"
        notify-send "Screenshot" "Full screen saved and copied" -i "$FILE"
        ;;
    region)
        grim -g "$(slurp)" "$FILE"
        wl-copy < "$FILE"
        notify-send "Screenshot" "Region saved and copied" -i "$FILE"
        ;;
    window)
        # Get active window geometry
        GEOMETRY=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOMETRY" "$FILE"
        wl-copy < "$FILE"
        notify-send "Screenshot" "Window saved and copied" -i "$FILE"
        ;;
    *)
        echo "Usage: screenshot.sh [full|region|window]"
        exit 1
        ;;
esac
