

``` shell
docker run -d --name zt --restart=always --device=/dev/net/tun --net=host   --cap-add=NET_ADMIN --cap-add=SYS_ADMIN  -v /volume2/docker/zerotier:/var/lib/zerotier-one zerotier/zerotier-synology:latest
 ```