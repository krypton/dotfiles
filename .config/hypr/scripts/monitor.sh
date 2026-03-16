#!/bin/bash

DP1_CONNECTED=$(hyprctl monitors | grep -c "DP-1")
LID=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')

if [ "$DP1_CONNECTED" -gt 0 ]; then
    # BenQ connected - set it as main
    hyprctl keyword monitor "DP-1,3840x2560@60,0x0,1.666667"

    if [ "$LID" = "closed" ]; then
        # Lid closed - only BenQ
        hyprctl keyword monitor "eDP-1,disable"
    else
        # Both monitors active
        hyprctl keyword monitor "eDP-1,1920x1080@60,2304x677,1"
    fi

    # Move workspaces 1-5 back to BenQ
    for i in 1 2 3 4 5; do
        hyprctl dispatch moveworkspacetomonitor "$i DP-1"
    done
else
    # BenQ disconnected - everything on laptop
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
fi
