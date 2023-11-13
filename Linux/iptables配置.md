在 Debian 11 中，您可以使用 `iptables-persistent` 包来永久保存防火墙规则。以下是一个示例，演示如何允许访问端口 8080：

1. 安装 `iptables-persistent` 包：

   ```
   sudo apt-get update
   sudo apt-get install iptables-persistent
   ```

2. 使用以下命令添加规则：

   ```
   sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
   ```

   这将允许TCP流量通过8080端口。

3. 保存您的规则：

   ```
   sudo netfilter-persistent save
   ```

   这将保存您的规则并将其写入 `/etc/iptables/rules.v4` 文件中。

4. 重启防火墙服务：

   ```
   sudo systemctl restart netfilter-persistent
   ```

现在，您的防火墙规则已经永久保存，并且将在系统启动时自动加载。如果您需要添加更多规则，请使用 `iptables` 命令添加它们，然后使用 `netfilter-persistent save` 命令保存它们。




要在Debian上配置防火墙以支持转发，您可以使用`iptables`命令。以下是一个示例配置：

```bash
# 清除所有规则和链
iptables -F
iptables -X

# 默认策略设置为允许所有流量通过
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 启用转发
iptables -A FORWARD -i eth0 -o zteb4ofk7u -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

# 配置NAT转发
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# 保存配置
iptables-save > /etc/iptables/rules.v4
```

请注意，上述配置假设您的网络接口为`eth0`和`eth1`，您可以根据实际情况进行调整。此外，如果您使用IPv6，请确保相应地配置IPv6防火墙规则。

要在系统启动时加载防火墙规则，您可以将上述配置保存到`/etc/iptables/rules.v4`文件中，并在`/etc/network/interfaces`文件中添加以下行：

```
pre-up iptables-restore < /etc/iptables/rules.v4
```

这样，防火墙规则将在每次系统启动时自动加载。