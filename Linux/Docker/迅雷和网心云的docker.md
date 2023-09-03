# 迅雷
https://zhuanlan.zhihu.com/p/627497081

```xml
version: "2.1"
services:
xunlei:
image: cnk3x/xunlei:latest
privileged: true
container_name: xunlei
hostname: mynas
network_mode: bridge
ports:
- 2345:2345
volumes:
- /mnt/sdb1/xunlei:/xunlei/data #data目录
- /mnt/sdb1/downloads:/xunlei/downloads #下载目录
restart: unless-stopped
```


# 网心云
网心云跑网心云：

``` shell
docker run -d --name OneCloud -p 18888:18888 -v /mnt/software/wxedge:/storage  onething1/wxedge
```

J3060跑网心云：

``` shell
docker run -d --name OneCloud -p 18888:18888 -v /volume1/Download/wxedge_storage:/storage  onething1/wxedge
```

