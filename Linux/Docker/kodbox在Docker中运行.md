# 在Docker中运行kodbox

``` shell
docker run -d --name kodbox -p 80:80 -v /opt/projects:/projects -v /opt/www/html/kodbox:/var/www/html kodcloud/kodbox
```
解释：
- projects是用于存放文件，从外部引入是为了可以使用宿主机的定时任务
- 