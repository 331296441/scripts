# nas-cab docker部署，支持X86-64和arm64

``` shell
docker run -v /volume1/:/myData -v /volume1/:/root/.local/share/nascab -p 8888:80 -p 5555:90 -d ypptec/nascab
```