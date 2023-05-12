以下是一个示例脚本，可以实现将以 `yyyy年mm月dd日.md` 命名的文件移动到对应的月份文件夹中，如果文件夹不存在则新建。

```bash
#!/bin/bash

# 获取上一个月的年份和月份
last_month_year=$(date -d "1 month ago" +%Y)
last_month=$(date -d "1 month ago" +%m)

# 创建上一个月份的文件夹
mkdir -p "${last_month_year}/${last_month}"

# 将上一个月份的文件移动到对应的文件夹中
mv "${last_month_year}年${last_month}月*.md" "${last_month_year}/${last_month}"
```

在上面的脚本中，我们使用了 `date` 命令来获取上一个月的年份和月份。然后，我们使用 `mkdir -p` 命令来创建上一个月份的文件夹，如果该文件夹已经存在，则不会进行任何操作。最后，我们使用 `mv` 命令将以 `yyyy年mm月dd日.md` 命名的文件移动到对应的文件夹中。请注意，我们使用了通配符 `*` 来匹配所有以 `yyyy年mm月` 开头的文件名。