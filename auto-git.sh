#!/bin/bash

# 如果传入了目录参数，则使用该目录，否则使用当前目录
if [[ -n "${1}" ]]; then
  cd "${1}"
fi

# 检查远程是否有更新
git remote update &> /dev/null
if [[ $(git status -uno | grep 'Your branch is behind') ]]; then
  echo "远程有更新，正在拉取代码..."
  git pull
fi

# 检查本地是否有更新
if [[ $(git status -s) ]]; then
  echo "本地有更新，正在提交并推送代码..."
  git add .
  git commit -m "自动提交"
  git push
fi

