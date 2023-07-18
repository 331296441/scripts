
来自[netdata 是常用的Linux系统性能实时监控面板](https://www.cnblogs.com/pywen/p/16248859.html)
``` shell
docker run -d --name=netdata \
-p 19999:19999 \
-v netdataconfig:/etc/netdata \
-v netdatalib:/var/lib/netdata \
-v netdatacache:/var/cache/netdata \
-v /etc/passwd:/host/etc/passwd:ro \
-v /etc/group:/host/etc/group:ro \
-v /proc:/host/proc:ro \
-v /sys:/host/sys:ro \
--restart unless-stopped \
--cap-add SYS_PTRACE \
--security-opt apparmor=unconfined \
netdata/netdata
```