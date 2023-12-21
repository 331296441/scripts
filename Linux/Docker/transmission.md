# transmission
是一个BT客户端，被大多数PT网站兼容
来源：https://cloud.tencent.com/developer/article/2072005

安装
```shell
docker run -d --name="transmission" \
  -e USERNAME=wood \
  -e PASSWORD=1QAZ2wsx. \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /mnt/PT/downloads:/root/Downloads \
  -v /mnt/PT/data/transmission:/root/.config/transmission-daemon \
  --restart=always \
  helloz/transmission
  ```