#!/bin/bash

# Automatically detect active network interface (e.g., wlan0, eth0, enp3s0)
INTF=$(ip route | awk '/default/ {print $5}' | head -n1)

# Initialize network counters
if [ -n "$INTF" ]; then
    RX_OLD=$(awk -v data="$INTF" '$0 ~ data {print $2}' /proc/net/dev)
    TX_OLD=$(awk -v data="$INTF" '$0 ~ data {print $10}' /proc/net/dev)
else
    RX_OLD=0
    TX_OLD=0
fi

while true; do
    # 1. Brightness
    BRIGHT=$(( ($(cat /sys/class/backlight/*/brightness) * 100) / 7500 ))
    
    # 2. Volume
    VOL=$(wpctl get-volume @DEFAULT_SINK@ 2>/dev/null | awk '{printf "%.0f\n", $2 * 100}')
    
    # 3. Battery
    BAT=$(cat /sys/class/power_supply/BAT0/capacity)
    
    # 4. RAM Usage (Human Readable, e.g., 1.4G)
    RAM=$(free -h | awk '/Mem:/ {print $3}')
    
    # 5. Network Speeds (Calculates delta over the 1-second loop sleep)
    INTF=$(ip route | awk '/default/ {print $5}' | head -n1)
    if [ -n "$INTF" ]; then
        RX_NEW=$(awk -v data="$INTF" '$0 ~ data {print $2}' /proc/net/dev)
        TX_NEW=$(awk -v data="$INTF" '$0 ~ data {print $10}' /proc/net/dev)
        
        # Total bytes transferred in the last second
        RX_BYTES=$((RX_NEW - RX_OLD))
        TX_BYTES=$((TX_NEW - TX_OLD))
        
        # Format Download Speed (Auto-scale KB/s vs MB/s)
        if [ $RX_BYTES -lt 1048576 ]; then
            DOWN="$(($RX_BYTES / 1024)) KB/s"
        else
            DOWN="$(awk "BEGIN {printf \"%.1f MB/s\", $RX_BYTES/1048576}")"
        fi
        
        # Format Upload Speed (Auto-scale KB/s vs MB/s)
        if [ $TX_BYTES -lt 1048576 ]; then
            UP="$(($TX_BYTES / 1024)) KB/s"
        else
            UP="$(awk "BEGIN {printf \"%.1f MB/s\", $TX_BYTES/1048576}")"
        fi
        
        # Save values for the next iteration loop
        RX_OLD=$RX_NEW
        TX_OLD=$TX_NEW
    else
        DOWN="0 KB/s"
        UP="0 KB/s"
    fi
    
    # 6. Time
    TIME=$(date "+%a %b %d %H:%M")
    
    # Output to dwm bar using Nerd Font Icons
    # Icons: 󰃠 (Brightness), 󰕾 (Volume), 󰍛 (RAM), 󰇚 (Down), 󰕒 (Up), 󰁹 (Battery), 󱎫 (Clock)
    xsetroot -name " [ 󰃠 $BRIGHT%  ] [  󰕾 $VOL%  ] [  󰍛 $RAM  ] [  󰇚 $DOWN  󰕒 $UP  ] [  󰁹 $BAT%  ] [  󱎫 $TIME  ] "
    
    sleep 1
done
