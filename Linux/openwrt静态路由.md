在OpenWrt上通过命令行配置静态路由可以使用`route`命令。以下是在OpenWrt上配置静态路由的示例命令：

```bash
route add -net 11.11.11.0 netmask 255.255.255.0 gw 192.168.124.14
```

这个命令将添加一个静态路由，将目标网络11.11.11.0/24的流量指向网关192.168.124.14。

请注意，这个命令只会在当前会话中生效，如果你希望在系统重启后仍然保留这个静态路由，你需要将这个命令添加到OpenWrt的启动脚本中，比如`/etc/rc.local`文件。

如果你使用的是OpenWrt的LuCI Web界面，你也可以通过登录到路由器的Web界面来配置静态路由。

``` shell
#!/bin/bash

# 定义telnet连接参数
HOST="192.168.124.1"
PORT="99"
USERNAME="H3C"
PASSWORD="12062603binbin"

# 定义要执行的命令
COMMAND="route add -net 11.11.11.0 netmask 255.255.255.0 gw 192.168.124.14"

# 执行telnet连接并执行命令
expect << EOF
spawn telnet $HOST $PORT
expect "Username:"
send "$USERNAME\r"
expect "Password:"
send "$PASSWORD\r"
expect "#"
send "$COMMAND\r"
expect "#"
send "exit\r"
EOF
```

``` shell
#!/bin/zsh

# 定义telnet连接参数
HOST="192.168.124.1"
PORT="99"
USERNAME="H3C"
PASSWORD="password"

# 定义要执行的命令
COMMAND="route add -net 11.11.11.0 netmask 255.255.255.0 gw 192.168.124.14"

# 执行telnet连接并执行命令
expect << EOF
spawn telnet $HOST $PORT
expect "Username:"
send "$USERNAME\r"
expect "Password:"
send "$PASSWORD\r"
expect "#"
send "$COMMAND\r"
expect "#"
send "exit\r"
EOF
```