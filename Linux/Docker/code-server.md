# code-server脚本

## 拉取脚本
```shell
 docker pull linuxserver/code-server 
 ```


## 启动脚本
``` shell
docker run -d --name=code-server -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /mnt/projects:/projects  -v /root/.ssh:/root/.ssh -e DEFAULT_WORKSPACE=/projects --restart unless-stopped --hostname code-server-103s linuxserver/code-server:latest
```

- 群晖的启动脚本
``` shell
docker run -d --name=code-server --hostname code-server-j3060 -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /volume1/projects:/projects  -v /root/.ssh:/root/.ssh -e DEFAULT_WORKSPACE=/projects --restart unless-stopped linuxserver/code-server:latest
```