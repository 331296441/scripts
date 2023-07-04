以下是生成Markdown文件的Shell脚本：

```bash
#!/bin/bash

# 获取当前日期
today=$(date +"%Y年%m月%d日")

# 检查文件是否已存在
if [ -f "$today.md" ]; then
  echo "文件已存在"
  exit 1
fi

# 创建Markdown文件
touch "$today.md"

# 添加一级标题
echo "# $today" >> "$today.md"

# 添加二级标题
echo "## 今日计划" >> "$today.md"
echo "## 今日计划-其他" >> "$today.md"
echo "## 日常工作" >> "$today.md"
```

这段脚本将在当前目录下生成一个Markdown文件，文件名和一级标题都是当前日期。如果已存在同名文件，则会提示文件已存在并退出脚本。如果文件不存在，则会创建文件，并添加三个二级标题。