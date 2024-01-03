# chinesesubfinder 一个自动下载字幕的软件


``` shell

docker create \
  --name=chinesesubfinder  \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Asia/Shanghai \
  -p 19035:19035 \
  -v /media/chinesesubfinder/config:/config \
  -v /media/chinesesubfinder/SubFixCache:/app/SubFixCache \
  -v /media/waitforwatch:/media \
  --add-host=api.themoviedb.org:13.225.174.30 \
  --add-host=image.tmdb.org:13.227.73.57 \
  --add-host=www.themoviedb.org:54.192.22.105 \
  allanpk716/chinesesubfinder:latest
  

```