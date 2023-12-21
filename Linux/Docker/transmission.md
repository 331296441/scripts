```shell
docker run -d --name="transmission" \
  -e USERNAME=wood \
  -e PASSWORD=xiaoz.me \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /data/downloads:/root/Downloads \
  -v /data/transmission:/root/.config/transmission-daemon \
  --restart=always \
  helloz/transmission
  ```