以下是在Debian中配置发送RFC3164格式syslog到指定UDP服务器的步骤：

1. 编辑rsyslog配置文件

使用root用户编辑rsyslog配置文件`/etc/rsyslog.conf`，找到以下行：

```
#module(load="imklog" permitnonkernelfacility="on")
```

将其注释掉，然后在文件末尾添加以下内容：

```
$template RFC3164fmt,"<%PRI%>%TIMESTAMP% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% %STRUCTURED-DATA% %msg%\n"
*.* @11.11.11.5:514;RFC3164fmt
```

其中，`11.11.11.5`是远程服务器的IP地址，`514`是远程服务器接收syslog的端口号。`*.*`表示将所有级别的syslog都发送到远程服务器。`$template`定义了一个名为RFC3164fmt的模板，用于格式化syslog消息为RFC3164格式。

2. 重启rsyslog服务

使用以下命令重启rsyslog服务：

```
sudo systemctl restart rsyslog
```

3. 测试发送syslog

使用以下命令在本地生成一条syslog：

```
logger -t myapp "[error] Test syslog message"
```

其中，`-t myapp`指定syslog的应用程序名称为myapp。

然后在远程服务器上查看是否收到了该syslog，并且是否为RFC3164格式。

注意：RFC3164格式的syslog消息包含了PRI、TIMESTAMP、HOSTNAME、APP-NAME等字段，如果这些字段在本地系统中没有正确配置，可能会导致syslog发送失败或格式不正确。