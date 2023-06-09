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
  git add .
  git commit -m "Update"
  git push
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