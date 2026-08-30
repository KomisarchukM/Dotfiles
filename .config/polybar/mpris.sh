#!/bin/sh
# pick the first player that is actually Playing or Paused
player=$(playerctl -l 2>/dev/null | while read -r p; do
    s=$(playerctl -p "$p" status 2>/dev/null)
    case "$s" in Playing|Paused) echo "$p"; break;; esac
done)

[ -z "$player" ] && exit 0

status=$(playerctl -p "$player" status 2>/dev/null)
case "$status" in
    Playing) icon="󰝚" ;;
    Paused)  icon="󰏤" ;;
    *)       exit 0   ;;
esac

artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
title=$(playerctl -p "$player" metadata title  2>/dev/null)

[ -z "$title" ] && exit 0

if [ -n "$artist" ]; then
    printf '%s  %s – %s\n' "$icon" "$artist" "$title"
else
    printf '%s  %s\n' "$icon" "$title"
fi
