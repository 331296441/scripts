以下是一个简化后的脚本，可以实现相同的功能：

```bash
#!/bin/bash

# 获取上一个月份的年份和月份
previous_month_year=$(date -d "1 month ago" +%Y)
previous_month=$(date -d "1 month ago" +%m)
previous_month_name=$(date -d "1 month ago" "+%B")

# 创建上一个月份的文件夹
folder_path="$(dirname "$0")/$previous_month_year-$previous_month_name"
mkdir -p "$folder_path"

# 将上一个月份的文件移动到对应的文件夹中
for file_path in "$(dirname "$0")/${previous_month_year}年${previous_month_name}月"*; do
  if [ -f "$file_path" ]; then
    mv "$file_path" "$folder_path"
  fi
done
```

在上面的脚本中，我们使用了 `dirname` 命令来获取脚本所在目录的路径，并使用 `mkdir -p` 命令来创建上一个月份的文件夹。然后，我们使用 `for` 循环遍历以 `yyyy年mm月` 开头的文件，并使用 `mv` 命令将符合条件的文件移动到上一个月份的文件夹中。请注意，我们使用了通配符 `*` 来匹配所有以 `yyyy年mm月` 开头的文件名，并使用 `[ -f "$file_path" ]` 来判断文件是否存在。