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

commit_id=$(git rev-parse HEAD)
commit_time=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo "当前 Git commit 编号：$commit_id" > Update.md
echo "提交时间：$commit_time" >> Update.md

echo "scripts自动提交-done"