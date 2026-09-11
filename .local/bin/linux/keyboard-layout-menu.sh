#!/bin/bash

# Wofi menu to jump straight to a specific keyboard layout, driven by
# whatever's actually configured in input:kb_layout (rather than hardcoding
# the list here so it stays in sync if layouts are added/removed).

if pgrep -x wofi >/dev/null; then
    pkill -x wofi
    exit 0
fi

# Friendly labels matching hyprland/language's format-<code> entries in
# waybar's config.jsonc - falls back to the raw layout code if not listed.
label_for() {
    case "$1" in
        us) echo "US" ;;
        pt) echo "PT" ;;
        *) echo "${1^^}" ;;
    esac
}

LAYOUTS_CSV=$(hyprctl getoption input:kb_layout -j | jq -r '.str')
IFS=',' read -ra LAYOUTS <<< "$LAYOUTS_CSV"

MENU=""
for i in "${!LAYOUTS[@]}"; do
    MENU+="$(label_for "${LAYOUTS[$i]}")\n"
done

CHOICE=$(echo -e "$MENU" | wofi --show dmenu --prompt "Keyboard Layout " --cache-file /dev/null)
[ -z "$CHOICE" ] && exit 0

for i in "${!LAYOUTS[@]}"; do
    if [ "$(label_for "${LAYOUTS[$i]}")" = "$CHOICE" ]; then
        hyprctl switchxkblayout all "$i"
        break
    fi
done
