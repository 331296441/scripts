```
docker run -d --name=zfile --restart=always \
    -p 8080:8080 \
    -v /mnt/zfile/db:/root/.zfile-v4/db \
    -v /mnt/zfile/logs:/root/.zfile-v4/logs \
    -v /mnt/zfile/file:/data/file \
    -v /mnt/zfile/application.properties:/root/application.properties \
    zhaojun1998/zfile
```


```
docker run -d --name=zfile --restart=always \
    -p 8080:8080    \
    -v /volume2/docker/zfile/db:/root/.zfile-v4/db     \
    -v /volume2/docker/zfile/logs:/root/.zfile-v4/logs     \
    -v /volume2/docker/zfile/file:/data/file     \
    -v /volume2/docker/zfile/application.properties:/root/application.properties     \
    -v /volume2/projects:/root/projects     \
    -v /volume2/video/media:/root/media     \
    -v /volume2/CloudSync:/root/CloudSync     \
    zhaojun1998/zfile
```