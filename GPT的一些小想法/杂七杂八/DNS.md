在中国大陆,由于 DNS 污染和网络审查,使用公共 DNS 服务(如 8.8.8.8)常常无法正常工作。这时可以尝试使用中国常用的 DNS 服务商提供的 DNS 地址:
1. 阿里DNS:`223.5.5.5`,`223.6.6.6`
```bash
cat >> /etc/resolv.conf <<EOF
nameserver 223.5.5.5
nameserver 223.6.6.6
EOF
```
2. 百度DNS: `180.76.76.76`,`180.76.76.76`
```bash
cat >> /etc/resolv.conf <<EOF 
nameserver 180.76.76.76
nameserver 180.76.76.76  
EOF
```
3. 腾讯DNS: `119.29.29.29`,`119.28.28.28` 
```bash 
cat >> /etc/resolv.conf <<EOF
nameserver 119.29.29.29 
nameserver 119.28.28.28
EOF
```
4. 新网DNS: `168.95.1.1`,`168.95.192.1`
```bash
cat >> /etc/resolv.conf <<EOF 
nameserver 168.95.1.1  
nameserver 168.95.192.1
EOF
```
配置完成后,重启网络服务:
```bash
sudo systemctl restart networking
```
然后使用 `nslookup` 或 `dig` 测试是否可以正常解析域名。如果可以返回域名的 IP 地址,则说明 DNS 设置生效。
这些 DNS 服务商提供的 DNS 地址在中国大陆网络环境下可以有效避开 DNS 污染,提高域名解析成功率。如果您还面临域名解析问题,请在评论中提出,我们将进一步探讨解决方案