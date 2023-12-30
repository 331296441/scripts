# 在Docker中运行kodbox

``` shell
docker run -d --name kodbox -p 8098:80 --restart unless-stopped -v /mnt/temp/projects:/projects kodcloud/kodbox:1.45.4
```
解释：
- projects是用于存放文件，从外部引入是为了可以使用宿主机的定时任务
- /opt/www/html/kodbox文件夹需要为空，否则不会生成kodbox的文件
- 使用文件缓存方式可能可以使kodbox在外部可用
- 


``` shell
docker run -d --name kodexplorer -p 8081:80 --restart unless-stopped -v /mnt/sda1/projects:/projects -v /overlay/Configs/kodbox:/var/www/html kodcloud/kodbox:1.49
```


iStoreOS启动命令
```shell
docker run --restart=unless-stopped -d     -v "/overlay/Configs/KodExplorer:/var/www/html"     --dns=172.17.0.1     -p 8081:80  -v /mnt:/mnt:rslave -e TZ=Asia/Shanghai --name kodexplorer "kodcloud/kodbox:1.49"
```