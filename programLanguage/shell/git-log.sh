#!/bin/bash

# 设置Git项目路径
PROJECT_PATH="$1"

# 设置Git用户名列表
GIT_USERNAMES=("User1" "User2" "User3")

# 检查参数是否为空
if [ -z "$PROJECT_PATH" ]; then
  echo "请提供Git项目路径作为参数"
  exit 1
fi

# 切换到项目路径
cd "$PROJECT_PATH" || exit 1

# 获取所有分支列表
branches=$(git branch -a | grep -v "remotes" | sed 's/^\* //')

# 输出表头
printf "%-20s | %-15s | %-15s | %-15s\n" "分支" "用户名" "修改文件数" "插入行数"

# 遍历每个分支并统计代码量
for branch in $branches; do
  # 切换到分支
  git checkout "$branch" >/dev/null 2>&1

  # 输出分支名称
  printf "%-20s\n" "$branch"

  # 遍历每个用户名并统计代码量
  for username in "${GIT_USERNAMES[@]}"; do
    # 统计代码量
    stats=$(git log --author="$username" --shortstat --pretty=format:"" | awk '/files? changed/ {files+=$1; inserted+=$4} END {print files, inserted}')

    # 输出统计结果
    printf "%-20s | %-15s | %-15s | %-15s\n" "" "$username" "$stats"
  done

  # 输出分隔线
  printf "------------------------\n"
done
