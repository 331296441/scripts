```shell
docker run -d --name="transmission" \
  -e USERNAME=wood \
  -e PASSWORD=1QAZ2wsx. \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /mnt/PT/downloads:/root/Downloads \
  -v /mnt//data/transmission:/root/.config/transmission-daemon \
  --restart=always \
  helloz/transmission
  ```