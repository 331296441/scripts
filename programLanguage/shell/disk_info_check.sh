#!/bin/bash

mount_point="/mnt/projects"  # 替换为你要检查的挂载点路径

# 检查挂载点是否存在
if [ ! -d "$mount_point" ]; then
  echo "挂载点不存在"
  logger -p error -t 磁盘异常 "挂载点不存在嘞:`uptime`"
  shutdown -r now
  exit 1
fi

# 检查挂载点是否可访问
if ! ls "$mount_point" >/dev/null 2>&1; then
  echo "无法访问挂载点"
  logger -p error -t 磁盘异常 "无法访问挂载点嘞:`uptime`"
  shutdown -r now
  exit 1
fi

echo "挂载点可正常访问"
