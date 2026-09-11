#!/bin/bash

# Wofi launcher script
# Usage: wofi-launcher.sh [mode]
# Modes: drun, window, run, ssh

MODE=${1:-drun}

# wofi has no built-in single-instance/toggle support, so each keypress
# would otherwise stack a new window on top of one already open. Treat any
# running instance as "close it" instead of launching another.
if pgrep -x wofi >/dev/null; then
    pkill -x wofi
    exit 0
fi

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
            # Titles can contain their own "(...)" (unread counts, "(feat. X)",
            # etc.), so grab only the trailing "(class)" group we appended,
            # not the first parenthesized match in the line.
            CLASS=$(echo "$WINDOW" | grep -oP '\(\K[^()]+(?=\)$)')
            # hyprctl dispatch <string args> is rejected under the Lua config
            # ("Use eval") - fall back to hyprctl eval + hl.dsp.focus when active.
            if [ -f "$HOME/.config/hypr/hyprland.lua" ]; then
                hyprctl eval "hl.dispatch(hl.dsp.focus({window='class:$CLASS'}))"
            else
                hyprctl dispatch focuswindow "class:$CLASS"
            fi
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
