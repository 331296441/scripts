# code-server脚本

## 拉取脚本
```shell
 docker pull linuxserver/code-server 
 ```


## 通用启动脚本
``` shell
docker run -d --name=code-server -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /mnt/projects:/projects  -v /root/.ssh:/root/.ssh -e DEFAULT_WORKSPACE=/projects --restart unless-stopped --hostname codewifi -e SUDO_PASSWORD=abc -e TZ=Asia/Shanghai linuxserver/code-server:latest
```

- 玩客云版本（最新版本已经不再支持32位）
- 目前还在更新的：`docker pull dickhub/linuxserver-codeserver:version-v4.0.2`

``` shell
docker run -d --name=code-server -e PUID=1000 -e PGID=1000 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /mnt/projects:/projects  -v /root/.ssh:/config/.ssh -e DEFAULT_WORKSPACE=/projects --restart unless-stopped --hostname codeOneCloud -e SUDO_PASSWORD=abc -e TZ=Asia/Shanghai linuxserver/code-server:arm32v7-latest
```

- 群晖的启动脚本
``` shell
docker run -d --name=code-server --hostname code-server-j3060 -e PUID=0 -e PGID=0 -e TZ=Etc/UTC -p 8443:8443 -e SUDO_PASSWORD=password `#optional` -e SUDO_PASSWORD_HASH= `#optional` -v /volume1/projects:/projects  -v /root/.ssh:/root/.ssh -v /root/.ssh:/config/.ssh -e  DEFAULT_WORKSPACE=/projects --restart unless-stopped linuxserver/code-server:latest
```