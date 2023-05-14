#!/bin/sh

echo "每日工作自动提交 开始"
# 如果传入了目录参数，则使用该目录，否则使用当前目录
if [[ -n "${1}" ]]; then
  cd "${1}"
else
  # 获取当前脚本所在目录的绝对路径
  SCRIPT=$(readlink -f "$0")
  SCRIPT_DIR=$(dirname "$SCRIPT")
  # SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"  # 使用了bash语法，在docker中不可用
  echo "当前目录为："${SCRIPT_DIR}
  # 进入脚本所在目录
  cd "$SCRIPT_DIR"
fi

echo "检查远程是否有更新"
# 检查远程是否有更新
git remote update &> /dev/null
if [[ -n "$(git status -uno | grep 'Your branch is behind')" ]]; then
  echo "远程有更新，正在拉取代码..."
  git pull
else
  echo "远程无更新，跳过"
fi
HOST_NAME=$(hostname)
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "当前时间为：$current_time"

echo "先修改文件，再检查提交，确保修改后实时提交"
chmod -R 777 ./


cd "$SCRIPT_DIR"
echo "检查本地是否有更新"
if [[ -n "$(git status -s)" ]]; then
  echo "本地有更新，正在提交并推送代码..."
  git config --global add.all true
  git add .
  git add --all .
  git commit -m "自动提交 by $HOST_NAME $current_time"
  git push
else
  echo "本地没有更新，跳过"
fi
commit_id=$(git rev-parse HEAD)
commit_time=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo "当前 Git commit 编号：$commit_id" > Update.md
echo "提交时间：$commit_time" >> Update.md

echo "每日工作自动提交-done"



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

commit_id=$(git rev-parse HEAD)
commit_time=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo "当前 Git commit 编号：$commit_id" > Update.md
echo "提交时间：$commit_time" >> Update.md

echo "脚本自动提交结束"
  
  
