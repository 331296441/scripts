# chinesesubfinder 一个自动下载字幕的软件


``` shell

docker create \
  --name=chinesesubfinder  \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Asia/Shanghai \
  -p 16035:16035\
  -v $PWD/chinesesubfinder:/config \
  -v $PWD/chinesesubfinder/SubFixCache:/app/SubFixCache \
  -v $PWD/chinesesubfinder/video:/media \
  allanpk716/chinesesubfinder:latest
  

```