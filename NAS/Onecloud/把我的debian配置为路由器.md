# debian配置路由器

## 配置过程
要将 Debian 11 配置成路由器,基本步骤如下:

1. 安装所需软件包:
```bash
sudo apt install iptables iproute2 isc-dhcp-server
```

2. 配置网络接口,选择一个接口作为 WAN 口连接 Internet,另一个作为 LAN 口连接本地网络:
3. 
```bash
sudo ip addr add 192.168.1.1/24 dev eth0  # 配置 LAN 口 IP 地址 
sudo ip route add default via 192.168.2.1  # 设置默认路由到 WAN 口
```

3. 配置 NAT 及 IP 转发,实现内网设备通过路由器上网:

```bash 
sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE   # 启用 NAT
sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT   # 允许已建立的流量返回 
sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT      # 允许从内网到外网的流量
sudo sysctl -w net.ipv4.ip_forward=1    # 启用内核 IP 转发
sudo iptables -P FORWARD ACCEPT 打开 iptables 的 FORWARD 链默认策略
sudo iptables -A FORWARD -p udp --dport 53 -j ACCEPT  # 允许 DNS 流量通过
```

4. 配置 DHCP 服务器,为内网客户端分配 IP 地址:
```bash
sudo vim /etc/dhcp/dhcpd.conf
```

在 `dhcpd.conf` 中添加:
```
subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.100 192.168.1.200;  
    option domain-name "example.com"; 
    option domain-name-servers 8.8.8.8;   
    default-lease-time 600;
    max-lease-time 7200;  
}
```
 
5. 重启所需服务:
```bash 
sudo systemctl restart networking  
sudo systemctl restart netfilter-persistent 
sudo systemctl restart isc-dhcp-server
```

6. (可选)安装并配置无线路由功能。




## 核心内容

配置转发和NAT

```shell
sysctl -w net.ipv4.ip_forward=1 # 启用IP转发
iptables -A FORWARD -p udp --dport 53 -j ACCEPT  # 允许 DNS 流量通过
iptables -P FORWARD ACCEPT # 打开 iptables 的 FORWARD 链默认策略
iptables -t nat -A POSTROUTING -o wlxec888fbd53b0 -j MASQUERADE # 启用NAT
# wlxec888fbd53b0是网络出口
```



## 检查结果
要确定 Debian 是否正确配置了 IP 转发和路由器功能,可以进行以下测试:
1. 检查 IP 转发是否启用:
```bash
sysctl net.ipv4.ip_forward
```
如果返回 `net.ipv4.ip_forward = 1` 则表示 IP 转发已启用。
2. 检查 NAT 规则是否正确:
``` bash
iptables -t nat -L -n
```
应显示有类似如下规则:
```
Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  0.0.0.0/0            0.0.0.0/0    
```
表示 NAT 已正确配置。
3. 检查 FORWARD 规则是否允许转发:
```bash 
iptables -L FORWARD -n
```
应显示有 ALLOW 规则,允许内外网流量通过:
```
Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
```
4. 测试从内网 ping 外网地址,如 `8.8.8.8`:
```bash
ping 8.8.8.8
```
 
如果可以 ping 通,则说明路由器功能正常。
5. 测试从外网 ping 内网地址,如果可以 ping 通则说明 NAT 工作正常。
以上步骤可以有效检查 Debian 是否正确配置了 IP 转发和路由器功能。所有测试通过则说明路由器功能正常;如果有任何测试不通过,请检查相应配置是否正确。如果您有任何其他问题,请在评论中提出