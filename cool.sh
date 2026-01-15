#!/bin/bash

# ASUS Fan Control Script
# Requires root privileges

MODE=$1

case $MODE in
    on)
        # Enable performance/full fan mode
        # Method 1: Try asusctl if available
        if command -v asusctl &> /dev/null; then
            asusctl profile -P Performance
            echo "Fans set to Performance mode"
        # Method 2: Direct ASUS WMI control
        elif [ -f /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy ]; then
            echo 0 > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
            echo "Fans enabled (performance mode)"
        else
            echo "Could not find fan control method"
            exit 1
        fi
        ;;
    off)
        # Enable silent/quiet fan mode
        # Method 1: Try asusctl if available
        if command -v asusctl &> /dev/null; then
            asusctl profile -P Quiet
            echo "Fans set to Quiet mode"
        # Method 2: Direct ASUS WMI control
        elif [ -f /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy ]; then
            echo 2 > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
            echo "Fans set to quiet mode"
        else
            echo "Could not find fan control method"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {on|off}"
        exit 1
        ;;
esac

exit 0
