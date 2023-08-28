# jellyfin

这两个在群晖上均不可用，直接使用工具更好

``` shell
docker run -d --privileged \
--restart=always \
--name=jellyfin \
--device /dev/dri/renderD128:/dev/dri/renderD128 \
--device /dev/dri/card0:/dev/dri/card0 \
--add-host=api.themoviedb.org:13.225.174.30 \
--add-host=image.tmdb.org:13.227.73.57 \
--add-host=www.themoviedb.org:54.192.22.105 \
--volume /volume1/homes/wood/jellyfin/config:/config \
--volume /volume1/homes/wood/jellyfin/cache:/cache \
--volume /volume1/video:/media \
nyanmisaka/jellyfin
```



# 第二种方式 实测armv7 玩客云可用


``` shell
docker run -d --privileged \
--restart=always \
--name=jellyfin \
--add-host=api.themoviedb.org:13.225.174.30 \
--add-host=image.tmdb.org:13.227.73.57 \
--add-host=www.themoviedb.org:54.192.22.105 \
--volume /mnt/media/config:/config \
--volume /mnt/media/cache:/cache \
--volume /mnt/media:/media \
-p 8096:8096 \
jellyfin/jellyfin
```