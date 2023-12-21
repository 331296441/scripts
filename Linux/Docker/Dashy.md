# Dashy是一款面板


## 官方教程
https://dashy.to/docs/quick-start


## 玩客云

``` shell
docker run -d \
  -p 8080:80 \
  -v /mnt/projects:/scripts/Linux/Docker/conf/Dashy:/app/public/ \
  --name my-dashy-dashboard \
  --restart=always \
  lissy93/dashy:latest
 ```