# 一款强大的docker可视化管理工具-DockerUI

## 教程地址
[一款强大的docker可视化管理工具-DockerUI](https://juejin.cn/post/7226979399715127357)

## 群晖
``` shell
docker run --restart always --name docker.ui -d -v /home/wood/docker.ui/docker.sock:/var/run/docker.sock -p 8999:8999 joinsunsoft/docker.ui
```

## debian amd64 only
``` shell
docker run --restart always --name docker.ui -d -v /var/run/docker.sock:/var/run/docker.sock -p 8999:8999 joinsunsoft/docker.ui
```