# chinesesubfinder 一个自动下载字幕的软件


``` shell

docker create \
  --name=chinesesubfinder  \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Asia/Shanghai \
  -p 19035:19035\
  -v /media/chinesesubfinder/config:/config \
  -v /media/chinesesubfinder/SubFixCache:/app/SubFixCache \
  -v /media/waitforwatchvideo:/media \
  allanpk716/chinesesubfinder:latest
  

```