# IYUUPlus
是一个自动转种辅种的PT辅助工具

https://www.iyuu.cn/archives/427/

``` shell
docker run -d \
--name IYUUPlus \
-v /media/plus:/IYUU/db \
-p 8787:8787 \
--restart=always \
iyuucn/iyuuplus:latest
```