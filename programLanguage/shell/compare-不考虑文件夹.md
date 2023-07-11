以下是一个满足您要求的shell脚本：

```bash
#!/bin/bash

# 获取传入的参数
git_url=$1
branch_name=$2

# 克隆分支名为{{branch_name}}的文件到/home/xiaoju/tmp/project/new目录
git clone --branch $branch_name $git_url /home/xiaoju/tmp/project/new

# 克隆master分支的文件到/home/xiaoju/tmp/project/old目录
git clone --branch master $git_url /home/xiaoju/tmp/project/old
```

您可以将以上代码保存为一个脚本文件（例如`clone.sh`），然后在终端中运行以下命令来执行脚本：

```bash
chmod +x clone.sh  # 添加执行权限
./clone.sh {{git地址}} {{分支名}}
```

请将`{{git地址}}`替换为您的实际git仓库地址，将`{{分支名}}`替换为您想要克隆的分支名。



