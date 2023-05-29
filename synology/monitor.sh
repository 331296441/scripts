#!/bin/bash

while true; do
  # 获取 CPU 使用情况
  cpu_usage=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')

  # 获取内存使用情况
  mem_usage=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')

  # 获取磁盘空间使用情况
  disk_usage=$(df -h | awk '$NF=="/"{printf "%s", $5}')

  # 获取系统负载情况
  load_avg=$(uptime | awk '{print $10 $11 $12}')

  # 检查是否有恶意进程运行
  suspicious_procs=$(ps aux | awk '{if($3 >= 50.0 || $4 >= 50.0) print}')

  # 输出监控数据和恶意进程信息
  echo "$(date) CPU使用率: $cpu_usage - 内存使用率: $mem_usage - 磁盘使用率: $disk_usage - 系统负载: $load_avg"
  echo "恶意进程: $suspicious_procs"

  # 等待一段时间再重新获取监控数据
  sleep 10
done
