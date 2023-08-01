Debian登录时的欢迎页通常包含以下信息：

1. 系统版本和发行版信息
2. 登录用户和主机名
3. 系统公告或重要通知
4. 系统状态和资源使用情况
5. 最后一次登录的时间和IP地址

要生成动态的欢迎页，可以使用以下步骤：

1. 创建一个欢迎页的模板文件，例如`welcome.txt`，其中包含需要显示的动态信息的占位符。例如：

```
Welcome to Debian {{VERSION}}
Logged in as {{USER}} on {{HOSTNAME}}
System notice: {{NOTICE}}
System status:
- CPU usage: {{CPU_USAGE}}
- Memory usage: {{MEMORY_USAGE}}
Last login: {{LAST_LOGIN}} from {{LAST_IP}}
```

2. 创建一个脚本文件，例如`welcome.sh`，用于替换模板文件中的占位符并输出生成的欢迎页。例如：

```bash
#!/bin/bash

# 获取系统信息
VERSION=$(lsb_release -ds)
USER=$(whoami)
HOSTNAME=$(hostname)
NOTICE="System maintenance in progress"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY_USAGE=$(free -m | awk '/Mem:/ { printf("%.2f%%", $3/$2*100) }')
LAST_LOGIN=$(last -n 1 $USER | awk '{print $4" "$5" "$6}')
LAST_IP=$(last -n 1 $USER | awk '{print $3}')

# 替换模板文件中的占位符
sed -e "s/{{VERSION}}/$VERSION/" \
    -e "s/{{USER}}/$USER/" \
    -e "s/{{HOSTNAME}}/$HOSTNAME/" \
    -e "s/{{NOTICE}}/$NOTICE/" \
    -e "s/{{CPU_USAGE}}/$CPU_USAGE/" \
    -e "s/{{MEMORY_USAGE}}/$MEMORY_USAGE/" \
    -e "s/{{LAST_LOGIN}}/$LAST_LOGIN/" \
    -e "s/{{LAST_IP}}/$LAST_IP/" welcome.txt
```

3. 为脚本文件添加执行权限：

```bash
chmod +x welcome.sh
```

4. 当用户登录时，在`.bashrc`或`.bash_profile`文件中添加以下行，以在每次登录时生成欢迎页：

```bash
/path/to/welcome.sh
```

确保将`/path/to/welcome.sh`替换为实际的脚本文件路径。

这样，每次用户登录时，都会生成一个动态的欢迎页，显示当前系统信息和用户状态。



# motd
要生成动态的`motd`（Message of the Day）或者`banner`，可以按照以下步骤进行操作：

1. 创建一个脚本文件，例如`dynamic_motd.sh`，用于生成动态的`motd`或者`banner`。在脚本中，你可以使用各种命令和变量来获取系统信息和其他动态内容。

```bash
#!/bin/bash

# 获取系统信息
VERSION=$(lsb_release -ds)
UPTIME=$(uptime -p)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY_USAGE=$(free -m | awk '/Mem:/ { printf("%.2f%%", $3/$2*100) }')

# 生成动态内容
echo "Welcome to My Server!"
echo "======================"
echo "System: $VERSION"
echo "Uptime: $UPTIME"
echo "CPU Usage: $CPU_USAGE"
echo "Memory Usage: $MEMORY_USAGE"
echo "======================"
```

2. 为脚本文件添加执行权限：

```bash
chmod +x dynamic_motd.sh
```

3. 将脚本文件移动到`/etc/update-motd.d/`目录下，并重命名为一个唯一的名称，例如`99-dynamic-motd`：

```bash
sudo mv dynamic_motd.sh /etc/update-motd.d/99-dynamic-motd
```

4. 确保`/etc/update-motd.d/`目录下的所有脚本文件都具有执行权限：

```bash
sudo chmod +x /etc/update-motd.d/*
```

5. 重新登录到服务器，你将看到生成的动态`motd`或者`banner`。

这样，每次登录到服务器时，`motd`或者`banner`都会根据脚本中的逻辑和系统信息进行动态生成。你可以根据需要自定义脚本中的内容和格式。