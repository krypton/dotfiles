#!/bin/sh

battery_print() {
    PATH_AC="/sys/class/power_supply/AC"
    PATH_BATTERY_0="/sys/class/power_supply/BAT0"

    ac=0
    battery_percent=0

    if [ -f "$PATH_AC/online" ]; then
        ac=$(cat "$PATH_AC/online")
    fi

    if [ -f "$PATH_BATTERY_0/capacity" ]; then
        battery_percent=$(cat "$PATH_BATTERY_0/capacity")
    fi

    if [ "$ac" -eq 1 ]; then
        if [ "$battery_percent" -ge 97 ]; then
            icon="󰂅"
        elif [ "$battery_percent" -ge 90 ]; then
            icon="󰂋"
        elif [ "$battery_percent" -ge 80 ]; then
            icon="󰂊"
        elif [ "$battery_percent" -ge 70 ]; then
            icon="󰢞"
        elif [ "$battery_percent" -ge 60 ]; then
            icon="󰂉"
        elif [ "$battery_percent" -ge 50 ]; then
            icon="󰢝"
        elif [ "$battery_percent" -ge 40 ]; then
            icon="󰂈"
        elif [ "$battery_percent" -ge 30 ]; then
            icon="󰂇"
        elif [ "$battery_percent" -ge 20 ]; then
            icon="󰂆"
        elif [ "$battery_percent" -ge 10 ]; then
            icon="󰢜"
        else
            icon="󰢟"
        fi
    else
        if [ "$battery_percent" -ge 97 ]; then
            icon="󰁹"
        elif [ "$battery_percent" -ge 90 ]; then
            icon="󰂂"
        elif [ "$battery_percent" -ge 80 ]; then
            icon="󰂁"
        elif [ "$battery_percent" -ge 70 ]; then
            icon="󰂀"
        elif [ "$battery_percent" -ge 60 ]; then
            icon="󰁿"
        elif [ "$battery_percent" -ge 50 ]; then
            icon="󰁾"
        elif [ "$battery_percent" -ge 40 ]; then
            icon="󰁽"
        elif [ "$battery_percent" -ge 30 ]; then
            icon="󰁼"
        elif [ "$battery_percent" -ge 20 ]; then
            icon="󰁻"
        elif [ "$battery_percent" -ge 10 ]; then
            icon="󰁺"
        else
            icon="󰂎"
        fi
    fi

    echo "%{F#ea9a97}$icon%{F-} $battery_percent %"
}

path_pid="/tmp/polybar-battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
