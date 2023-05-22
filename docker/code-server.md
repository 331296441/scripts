# code-server脚本

## 拉取脚本
```shell
 docker pull linuxserver/code-server 
 ```


## 启动脚本
``` shell
docker run -d --name=code-server -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /DATA/projects:/projects  -v /root/.ssh:/config/.ssh -v /root/.ssh:/root/.ssh -e DEFAULT_WORKSPACE=/projects --restart unless-stopped linuxserver/code-server:latest
```