# Dashy是一款面板


## 官方教程
https://dashy.to/docs/quick-start


## 玩客云

``` shell
docker run -d \
  -p 8080:80 \
  -v /mnt/projects/scripts/Linux/Docker/conf/Dashy/example9-conf.yml:/app/public/conf.yml \
  --name my-dashy-dashboard \
  --restart=always \
  lissy93/dashy:latest
 ```
 
 ``` shell

 
 docker run -d \
  -p 8080:80 \
  -v /root/my-local-conf.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
  
  ```