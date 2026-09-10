#!/bin/bash

# `hyprctl keyword`/`hyprctl dispatch <string args>` only work under the
# legacy .conf parser - under the Lua config they're rejected outright
# ("Use eval"). Since hyprland.conf is kept as a fallback (renaming/removing
# hyprland.lua reverts to it), detect which is active and use the matching
# hyprctl form so this script works either way.
LUA_CONFIG="$HOME/.config/hypr/hyprland.lua"

# args: output mode position scale  (pass mode=disable to turn the output off)
set_monitor() {
    if [ -f "$LUA_CONFIG" ]; then
        if [ "$2" = "disable" ]; then
            hyprctl eval "hl.monitor({output='$1', disabled=true})"
        else
            # disabled=false must be explicit - hl.monitor() only sets the
            # fields it's given, so omitting it leaves a monitor previously
            # disabled (e.g. by the lid-closed branch above) disabled forever.
            hyprctl eval "hl.monitor({output='$1', mode='$2', position='$3', scale=$4, disabled=false})"
        fi
    else
        if [ "$2" = "disable" ]; then
            hyprctl keyword monitor "$1,disable"
        else
            hyprctl keyword monitor "$1,$2,$3,$4"
        fi
    fi
}

# args: workspace monitor
move_workspace_to_monitor() {
    if [ -f "$LUA_CONFIG" ]; then
        hyprctl eval "hl.dispatch(hl.dsp.workspace.move({monitor='$2', workspace=$1}))"
    else
        hyprctl dispatch moveworkspacetomonitor "$1 $2"
    fi
}

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
    set_monitor "DP-1" "$(preferred_mode DP-1)" "0x0" "1.666667"

    if [ "$LID" = "closed" ]; then
        # Lid closed - only BenQ
        set_monitor "eDP-1" "disable"
    else
        # Both monitors active
        set_monitor "eDP-1" "$(preferred_mode eDP-1)" "2304x677" "1"
    fi

    # Move workspaces 1-5 back to BenQ
    for i in 1 2 3 4 5; do
        move_workspace_to_monitor "$i" "DP-1"
    done
else
    # BenQ disconnected - everything on laptop
    set_monitor "eDP-1" "$(preferred_mode eDP-1)" "0x0" "1"
fi
