#!/bin/bash

RESTART_COUNT=0
MAX_RESTART_COUNT=15

# 获取本机除了属于11.11.11.0/24网段的IP之外的其他IP
LOCAL_IP=$(ip -o -4 addr list | grep 11.11.11 | awk '{print $4}' | cut -d/ -f1)

while true; do
    for i in {1..15}; do
        if ping -c 1 11.11.11.$i >/dev/null; then
            echo "Connected to 11.11.11.$i"
            RESTART_COUNT=0
            break
        fi

        if [ $i -eq 15 ]; then
            echo "Unable to connect to 11.11.11.1-11.11.11.15"
            ((RESTART_COUNT++))
        fi
    done

    if [ $RESTART_COUNT -eq $MAX_RESTART_COUNT ]; then
        echo "Restarting the system..."
        reboot
    fi

    sleep 60
done