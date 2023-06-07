# jellyfin
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