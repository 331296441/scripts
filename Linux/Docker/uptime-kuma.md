# uptime-kuma

uptime是监控服务状态的，可以监控http/redis/mysql等的状态
``` shell
docker run -d --restart=always --name uptime-kuma -p 3001:3001 -v /volume1/homes/wood/uptime-kuma/data:/app/data --name uptime-kuma louislam/uptime-kuma
```