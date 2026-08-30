#!/bin/sh
# ~/.config/polybar/launch.sh
# Called from ~/.config/bspwm/bspwmrc:
#   $HOME/.config/polybar/launch.sh &

# Kill any running instance cleanly
killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.1; done

# Wait for bspwm socket to be ready
sleep 0.2

# Launch on every connected monitor
if command -v xrandr >/dev/null 2>&1; then
    for monitor in $(xrandr --query | awk '/ connected/{print $1}'); do
        MONITOR="$monitor" polybar main 2>&1 | tee -a /tmp/polybar-"$monitor".log &
        disown
    done
else
    polybar main 2>&1 | tee -a /tmp/polybar.log &
    disown
fi
