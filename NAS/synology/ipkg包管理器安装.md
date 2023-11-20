# ipkg包管理器安装

[温控显示安装](https://post.smzdm.com/p/a8xze450/)


```
mkdir /temp

cd /temp

wget http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/syno-i686-bootstrap_1.2-7_i686.xsh

chmod +x syno-i686-bootstrap_1.2-7_i686.xsh

sh syno-i686-bootstrap_1.2-7_i686.xsh

ipkg update
```