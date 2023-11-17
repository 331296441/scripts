1.拉取aria2-pro镜像

aria2是下载用主程序

拉取镜像命令

docker pull p3terx/aria2-pro
2.拉取AriaNg镜像

AriaNg是Aria2的UI操作界面，提供web端的在线操作

docker pull p3terx/ariang
 3.创建并启动ari2-pro容器

命令如下：
```
docker run -d --name aria2 \
--restart unless-stopped \
--log-opt max-size=1m \
-e PUID=$UID \
-e PGID=$GID \
-e UMASK_SET=022 \
-e RPC_SECRET=12345678 \
-e RPC_PORT=6800 \
-e LISTEN_PORT=6888 \
-p 16800:6800 \
-p 16888:6888 \
-p 16888:6888/udp \
-v /mnt/aria2/config:/config \
-v /media/Downloads:/downloads p3terx/aria2-pro
```


`-e RPC_SECRET=12345678`（这是一个Aria2 RPC秘钥，可以自己任意设置，但要记住，后面会用到）

其他的没有必要修改了。

4.创建并启动AriaNg容器

命令如下：
```
docker run -d --name ariang \
--restart unless-stopped \
--log-opt max-size=1m \
-p 46880:6880 p3terx/ariang
```

映射端口号46880，访问时要用到