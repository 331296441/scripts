#!/bin/bash

# 获取 CPU 使用率
cpu=$(top -bn1 | grep load | awk '{printf "%.2f%%\n", $(NF-2)*100}')

# 获取内存使用情况
mem=$(free | awk '/Mem/{printf "%.2f%%", $3/$2*100}')

# 获取磁盘使用情况
disk=$(df -h / | awk '/\//{printf "%s", $5}')

# 输出监控信息
echo "CPU使用率: $cpu"
echo "内存使用情况: $mem"
echo "磁盘使用情况: $disk"
