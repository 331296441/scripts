#!/bin/bash

if [[ ! -d "/mnt/projects/" ]]; then
  echo "目录不存在，正在重启..."
  logger -p error -t 磁盘异常 "磁盘找不到嘞:`uptime`"
  sudo shutdown -r now
else
  echo "目录存在"
  # logger -p info -t 磁盘正常 "磁盘正常:`df -h| grep sd | grep -v grep`"
fi
