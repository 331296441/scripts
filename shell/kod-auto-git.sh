#!/bin/bash

# 进入本地仓库目录
cd /DATA/projects/www/kodexplorer/data/User/admin/home/我的文档/kodexplorer

current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "当前时间为：$current_time"
# 检查远端是否有更新
git remote update > /dev/null
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    # 远端有更新，执行 pull 操作
    git pull
else
    # 远端没有更新，检查本地是否有修改
    if [ -n "$(git status --porcelain)" ]; then
        # 本地有修改，执行 push 操作
        git add .
        git commit -m "Auto commit $current_time"
        git push
    fi
fi
