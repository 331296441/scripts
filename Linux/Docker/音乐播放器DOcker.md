# 音乐播放器


## mstream
支持X64和arm64

``` shell
mkdir -p /mnt/mstream/config
mkdir -p /mnt/mstream/music
docker run -d   --name=mstream   -e PUID=1000   -e PGID=1000   -e USER=admin   -e PASSWORD=password   -e USE_JSON=true   -e TZ=Shanghai   -p 3000:3000   -v /mnt/mstream/config:/config   -v /mnt/mstream/music:/music   --restart always   linuxserver/mstream
```


## koel
```
docker pull phanan/koel:latest
```