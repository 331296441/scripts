在Debian中，可以使用以下命令切换iptables为传统模式：

1. 首先，安装iptables-persistent：

```
sudo apt-get update
sudo apt-get install iptables-persistent
```

2. 然后，使用以下命令切换为传统模式：

```
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```

这将把iptables和ip6tables切换到传统模式。