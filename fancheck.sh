#!/bin/bash

# Check ASUS fan mode or fan speed
# Try multiple methods to detect fan status

# Method 1: Check fan speed from hwmon
FAN_SPEED=$(cat /sys/class/hwmon/hwmon*/fan1_input 2>/dev/null | head -n 1)

if [ -n "$FAN_SPEED" ] && [ "$FAN_SPEED" -gt 0 ]; then
    echo '{"text":"on","tooltip":"Fan Speed: '"$FAN_SPEED"' RPM","class":"on"}'
    exit 0
fi

# Method 2: Check if asusctl thermal profile is set
if command -v asusctl &> /dev/null; then
    PROFILE=$(asusctl profile -p 2>/dev/null | grep -oP '(?<=Active profile is )\w+')
    if [ "$PROFILE" = "Performance" ] || [ "$PROFILE" = "Balanced" ]; then
        echo '{"text":"on","tooltip":"Profile: '"$PROFILE"'","class":"on"}'
        exit 0
    fi
fi

# Default: fans off
echo '{"text":"off","tooltip":"Fans are off or in silent mode","class":"off"}'