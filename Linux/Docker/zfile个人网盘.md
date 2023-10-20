```
docker run -d --name=zfile --restart=always \
    -p 8080:8080 \
    -v /mnt/zfile/db:/root/.zfile-v4/db \
    -v /mnt/zfile/logs:/root/.zfile-v4/logs \
    -v /mnt/zfile/file:/data/file \
    -v /mnt/zfile/application.properties:/root/application.properties \
    zhaojun1998/zfile
```