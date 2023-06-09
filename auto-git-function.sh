#!/bin/bash

# 拉取git更新
function git_pull() {
    cd "$(dirname "$0")"
    if [ -n "$(git status -uno | grep 'Your branch is behind')" ]; then
      echo "远程有更新，正在拉取代码..."
      git pull
    else
      echo "远程无更新，跳过"
    fi
}

# 提交并推送git变更
function git_push() {
    cd "$(dirname "$0")"
    HOST_NAME=$(hostname)
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "当前时间为：$current_time"
    
    echo "先修改文件，再检查提交，确保修改后实时提交"
    chmod -R 777 ./
    
    echo "检查本地是否有更新"
    if [ -n "$(git status -s)" ]; then
      echo "本地有更新，正在提交并推送代码..."
      git config --global add.all true
      git add .
      git add --all .
      git commit -m "自动提交 by $HOST_NAME $current_time"
      git push
    else
      echo "本地没有更新，跳过"
    fi
}


function system_info(){
    date=`date "+%F %T"`
head="System information as of: $date"
  
kernel=`uname -r`
hostname=`hostname`
  
#Cpu load
load1=`cat /proc/loadavg | awk '{print $1}'`
load5=`cat /proc/loadavg | awk '{print $2}'`
load15=`cat /proc/loadavg | awk '{print $3}'`
  
#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))
up_lastime=`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
  
#Memory Usage
mem_usage=`free -m |grep -E 'Mem|内存' | awk '{printf("%3.2f%%",$3/$2*100)}'`
swap_usage=`free -m |grep -E 'Swap|交换' | awk '{printf "%.2f%%",$3/$2*100}'`

#Processes
processes=`ps aux | wc -l`
  
#User
users=`users | wc -w`
USER=`whoami`
  
#System fs usage
Filesystem=$(df -h | awk '/^\/dev/{print $6}')
  
#Interfaces
INTERFACES=$(ip -4 ad | grep 'state ' | awk -F":" '!/^[0-9]*: ?lo/ {print $2}')
  
echo
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "$head"
echo "----------------------------------------------"
printf "Kernel Version:\t%s\n" $kernel
printf "HostName:\t%s\n" $hostname
printf "System Load:\t%s %s %s\n" $load1, $load5, $load15
printf "System Uptime:\t%s "days" %s "hours" %s "min" %s "sec"\n" $upDays $upHours $upMins $upSecs
printf "Memory Usage:\t%s\t\t\tSwap Usage:\t%s\n" $mem_usage $swap_usage
printf "Login Users:\t%s\t\t\tWhoami:\t\t%s\n" $users $USER
printf "Processes:\t%s\n" $processes
printf "\n"
printf "Filesystem\tUsage\n"
for f in $Filesystem
do
    Usage=$(df -h | awk '{if($NF=="'''$f'''") print $5}')
    echo -e "$f\t\t$Usage"
done
printf "\n"
printf "Interface\tMAC Address\t\tIP Address\n"
for i in $INTERFACES
do
    MAC=$(ip ad show dev $i | grep "link/ether" | awk '{print $2}')
    IP=$(ip ad show dev $i | awk '/inet / {print $2}')
    printf $i"\t\t"$MAC"\t$IP\n"
done
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
}

# 判断是否有参数
if [ $# -eq 0 ]; then
  git_pull
elif [ $1 = "push" ]; then
  git_push
elif [ $1 = "all" ]; then
  git_pull
  git_push
else
  # 参数错误
  echo "Invalid argument"
fi



system_info
commit_id=$(git rev-parse HEAD)
commit_time=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo "当前 Git commit 编号：$commit_id" > Update.md
echo "提交时间：$commit_time" >> Update.md
echo "检查时间：$current_time"  >> Update.md

echo "scripts自动git处理-done"