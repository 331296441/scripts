# 在Docker中运行kodbox

``` shell
docker run -d --name kodbox -p 80:80 -v /opt/projects:/projects -v /opt/www/html/kodbox:/var/www/html kodcloud/kodbox
```
解释：
- projects是用于存放文件，从外部引入是为了可以使用宿主机的定时任务
- /opt/www/html/kodbox文件夹需要为空，否则不会生成kodbox的文件
- 使用文件缓存方式可能可以使kodbox在外部可用