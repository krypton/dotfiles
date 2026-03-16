#!/bin/bash

# Wofi launcher script
# Usage: wofi-launcher.sh [mode]
# Modes: drun, window, run, ssh

MODE=${1:-drun}

case $MODE in
    drun)
        wofi --show drun \
             --prompt "Apps " \
             --cache-file ~/.cache/wofi-drun
        ;;
    window)
        # Window switcher using hyprctl
        WINDOW=$(hyprctl clients -j | \
            jq -r '.[] | "\(.title) (\(.class))"' | \
            wofi --show dmenu \
                 --prompt "Windows " \
                 --cache-file /dev/null)

        if [ -n "$WINDOW" ]; then
            CLASS=$(echo "$WINDOW" | grep -oP '\(\K[^)]+')
            hyprctl dispatch focuswindow "class:$CLASS"
        fi
        ;;
    run)
        wofi --show run \
             --prompt "Run " \
             --cache-file ~/.cache/wofi-run
        ;;
    ssh)
        # SSH launcher from ~/.ssh/config
        HOST=$(grep "^Host " ~/.ssh/config 2>/dev/null | \
            grep -v "\*" | \
            awk '{print $2}' | \
            wofi --show dmenu \
                 --prompt "SSH " \
                 --cache-file /dev/null)

        if [ -n "$HOST" ]; then
            ghostty -e ssh "$HOST"
        fi
        ;;
esac
