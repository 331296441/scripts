#!/bin/sh
uptime | awk '{printf("\nCPU Load: %.2f\t", $(NF-2))}'
free -m | awk 'NR==2{printf("Mem: %s/%sMB %.2f%%\n", $3,$2,$3*100/$2)}'
cat /sys/class/thermal/thermal_zone0/temp|awk '{printf("CPU Temp: %.2f\t",$1/1000)}'
df -h | awk '$NF=="/"{printf "Disk: %.1f/%.1fGB %s\n\n", $3,$2,$5}'