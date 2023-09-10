# nas-cab docker部署，支持X86-64和arm64

``` shell
docker run -v /volume1/Something/nascab:/myData -v /volume1/video:/video -v /volume2/docker/nascab:/root/.local/share/nascab -p 8888:80 -p 5555:90 -d ypptec/nascab
```