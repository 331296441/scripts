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