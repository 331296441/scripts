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
expect "NX30Pro login:"
send "$USERNAME\r"
expect "Password:"
send "$PASSWORD\r"
expect "#"
send "$COMMAND\r"
expect "#"
send "exit\r"
EOF