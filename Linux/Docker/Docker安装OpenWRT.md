# 安装网络

```shell
docker network create -d macvlan --subnet=192.168.124.0/24 --gateway=192.168.124.1 -o parent=eth0 macnet
```

创建openwrt目录
`mkdir -p /volume2/docker/openwrt`

创建network文件
`vim network`
内容：
```
config interface 'loopback'
        option ifname 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config globals 'globals'
        option packet_steering '1'

config interface 'lan'
        option type 'bridge'
        option ifname 'eth0'
        option proto 'static'
        option netmask '255.255.255.0'
        option ip6assign '60'
        option ipaddr '192.168.124.101'
        option gateway '192.168.124.1'
        option dns '192.168.124.1'

config interface 'vpn0'
        option ifname 'tun0'
        option proto 'none'
```

拉取镜像并初始化
```
docker run --restart always --name openwrt -d --network macnet --privileged --ip 192.168.124.101  -v /volume2/docker/openwrt/network:/etc/config/network registry.cn-shanghai.aliyuncs.com/suling/openwrt:x86_64 /sbin/init
```

每日编译的
```
docker run --restart always --name openwrt -d --network macnet --privileged --ip 192.168.124.101 openwrt:latest /sbin/init
```