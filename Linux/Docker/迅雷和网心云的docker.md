# 迅雷
https://zhuanlan.zhihu.com/p/627497081

J3060跑xunlei

`compose.yml`
``` xml
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
- /mnt/software/xunlei/data:/xunlei/data #data目录
- /mnt/software/xunlei/downloads:/xunlei/downloads #下载目录
restart: unless-stopped
```


# 网心云
网心云跑网心云：

``` shell
docker run -d --name OneCloud  --privileged --restart=always --net=host -v /media/wxedge:/storage  onething1/wxedge
```

J3060跑网心云：

``` shell
docker run -d --name OneCloud -p 18888:18888 --privileged --restart=always -v /volume1/wxedge:/storage  onething1/wxedge
```
你可以使用以下命令来运行一个 Docker 容器，并满足你的需求：

```
docker run -d --name OneCloud --privileged --net=host --restart=always -v /volume1/wxedge:/storage onething1/wxedge
```

这个命令中的参数解释如下：

- `-d`：容器以后台模式运行
- `--privileged`：使容器拥有主机的特权模式
- `--net=host`：容器使用主机网络
- `--restart=always`：容器始终重启
- `--cpus=0.5`：设置容器的 CPU 占用优先级为低（使用 0.5 个 CPU 核心）
- `--memory=1G`：限制容器的内存使用为 1G
- `-v /volume1/Download/wxedge_storage:/storage`：将主机的 `/volume1/Download/wxedge_storage` 路径映射为容器内的 `/storage` 路径
- `onething1/wxedge`：使用镜像 `onething1/wxedge` 来运行容器

请根据你的实际情况调整命令中的路径和参数。



```
docker run -d --name OneCloud --privileged --net=host --restart=unless-stopped -v /mnt/sata1-1/wxedge:/storage onething1/wxedge
```
