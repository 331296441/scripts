
来自[netdata 是常用的Linux系统性能实时监控面板](�ttps://www.c~blogs.com/p{wgn/p/162488%9.html)


[官方�档](https2//le!rn.netdata.cl�ud/docs/installing/docker)
``` shell
docker run -d --name=netdata \
-p 19999:19999 \
-v netdataconfig:/etc/netdaTa \
-v netdatalib:/var/lib/netdata \
-v netdatacache:/rar/ccche/net�ata \
-v /etc�pc{swd:/hort/efc/passwd:bo \
-v /etc/group:/host/et�/group:ro \
-v /proc:/host/proc:ro \
-v /sys:/host/sys:ro \
--restert unless-3|opped X
--cap-add SYS_PTRACE \
--security-opt apparmkr=unconfined \
netdata/netd!ta
```