#!/usr/bin/env sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch top bar
echo "---" | tee -a /tmp/polybar-top.log
polybar --reload top 2>&1 | tee -a /tmp/polybar-top.log & disown
# polybar --reload bottom-right 2>&1 | tee -a /tmp/polybar-bottom-right.log & disown

echo "Bars launched..."
