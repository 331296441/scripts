# 使用内置H2数据库直接启用halo
``` shell
docker run \
  -it -d \
  --name halo \
  -p 8090:8090 \
  -v ~/.halo2:/root/.halo2 \
  halohub/halo \
  --halo.external-url=http://localhost:8090/ \
  --halo.security.initializer.superadminusername=admin \
  --halo.security.initializer.superadminpassword=P@88w0rd  
  ```