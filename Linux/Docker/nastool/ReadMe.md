# nastool
是一个一键管理nas下载的工具


支持 amd64/arm64 架构

``` shell
docker run -d \
    --name nas-tools \
    --hostname nas-tools \
    -p 3001:3000   `# 默认的webui控制端口`  \
    -v /mnt/sda1/nastools/sys/nastool:/config/  `# 冒号左边请修改为你想在主机上保存配置文件的路径` \
    -v /mnt/sda1/nastools/downloads/:/media/  `# 媒体目录，多个目录需要分别映射进来`  \
    -e PUID=0     `# 想切换为哪个用户来运行程序，该用户的uid，详见下方说明`  \
    -e PGID=0     `# 想切换为哪个用户来运行程序，该用户的gid，详见下方说明`  \
    -e UMASK=000   `# 掩码权限，默认000，可以考虑设置为022`  \
    -e NASTOOL_AUTO_UPDATE=false `# 如需在启动容器时自动升级程程序请设置为true` \
    --restart unless-stopped \
    nastool/nas-tools
```