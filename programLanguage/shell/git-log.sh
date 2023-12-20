#!/bin/bash

# 设置Git项目路径
PROJECT_PATH="/mnt/projects/scripts"

# 切换到项目路径
cd "$PROJECT_PATH"

# 获取所有分支列表
branches=$(git branch -a | grep -v "remotes" | sed 's/^\* //')

# 遍历每个分支并统计代码量
for branch in $branches; do
  # 切换到分支
  git checkout "$branch" >/dev/null 2>&1

  # 统计代码量
  lines=$(git log --shortstat | grep "files changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print files, inserted, deleted}')

  # 输出统计结果
  echo "Branch: $branch"
  echo "Files changed, Lines inserted, Lines deleted: $lines"
  echo "------------------------"
done
