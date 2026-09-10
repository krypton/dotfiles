#!/bin/bash

MONITORS_JSON=$(hyprctl monitors all -j)

# Native/preferred mode as reported by the panel's EDID, e.g. "1920x1200@60"
preferred_mode() {
    echo "$MONITORS_JSON" | jq -r --arg name "$1" \
        '.[] | select(.name == $name) | .availableModes[0]' | awk -F@ '{printf "%s@%.0f\n", $1, $2}'
}

DP1_CONNECTED=$(echo "$MONITORS_JSON" | jq '[.[] | select(.name == "DP-1")] | length')
LID=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')

if [ "$DP1_CONNECTED" -gt 0 ]; then
    # BenQ connected - set it as main
    hyprctl keyword monitor "DP-1,$(preferred_mode DP-1),0x0,1.666667"

    if [ "$LID" = "closed" ]; then
        # Lid closed - only BenQ
        hyprctl keyword monitor "eDP-1,disable"
    else
        # Both monitors active
        hyprctl keyword monitor "eDP-1,$(preferred_mode eDP-1),2304x677,1"
    fi

    # Move workspaces 1-5 back to BenQ
    for i in 1 2 3 4 5; do
        hyprctl dispatch moveworkspacetomonitor "$i DP-1"
    done
else
    # BenQ disconnected - everything on laptop
    hyprctl keyword monitor "eDP-1,$(preferred_mode eDP-1),0x0,1"
fi
