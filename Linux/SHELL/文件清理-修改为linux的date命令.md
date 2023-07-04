以下是修改后的脚本，可以在Linux上使用GNU coreutils版本的`date`命令，并添加了注释：

```bash
#!/bin/bash

# 获取当前日期的年份、月份和日期
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)

# 获取当前月份的第一天的时间戳
first_day=$(date -d "${year}-${month}-01" "+%s")

# 获取脚本所在目录的路径
script_path=$(dirname "$0")

# 获取上一个月份的年份和月份
previous_month_year=$(date -d "1 month ago" +%Y)
previous_month=$(date -d "1 month ago" +%m)

# 获取上一个月份的名称
previous_month_name=$(date -d "1 month ago" "+%B")

# 创建上一个月份的文件夹
folder_path="$script_path/$previous_month_year-$previous_month_name"
if [ ! -d "$folder_path" ]; then
  mkdir "$folder_path"
fi

# 遍历当前月份中以 "yyyy年mm月" 开头的文件
for file_path in "$script_path/${year}年${previous_month_name}月"*; do
  # 获取文件名
  file_name=$(basename "$file_path")
  # 获取文件名中的日期
  date=$(echo "$file_name" | sed -E "s/${year}年${previous_month_name}月([0-9]+)日/\1/")
  # 将日期格式化为两位数
  date=$(printf "%02d" "$date")
  # 如果该日期在上一个月份，并且该文件存在，则移动文件到上一个月份的文件夹中
  if (( $date <= 31 )) && (( $(date -d "${year}-${previous_month}-${date}" "+%s") < $first_day )) && [ -f "$file_path" ]; then
    mv "$file_path" "$folder_path"
  fi
done
```

在上面的脚本中，我们使用了 `date` 命令来获取当前日期的年份、月份和日期，以及上一个月份的年份和月份。然后，我们使用 `sed` 命令来提取文件名中的日期，并使用 `printf` 命令将日期格式化为两位数。最后，我们使用 `mv` 命令将符合条件的文件移动到上一个月份的文件夹中。