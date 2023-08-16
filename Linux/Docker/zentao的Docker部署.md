# 禅道部署

[Docker方式部署禅道](https://www.zentao.net/book/zentaopmshelp/405.html)


启动脚本，使用内置mysql

MYSQL_INTERNAL=true：启用容器内置MySQL，默认用户名为 `root`,密码是 `123456`

`docker run --name zentao -p 8088:80 -v /volume1/web/zentao:/data -e MYSQL_INTERNAL=true -d easysoft/zentao:18.5`





`docker run --name zentao -p 8088:80 --privileged --network=macnet --ip 192.168.124.102 -v /volume1/web/zentao:/data -e MYSQL_INTERNAL=true -d easysoft/zentao:18.5`



