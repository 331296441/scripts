# Dashy是一款面板


## 官方教程
https://dashy.to/docs/quick-start

``` shell
docker run -d \
  -p 8080:80 \
  -v /overlay/Configs/Dashy//app/public/ \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
 ```