docker run -it --name openwrt --network host --privileged \
    -e "LAN_IFACE=eth0" \
    -e "LAN_IP=192.168.31.100" \
    -e "LAN_NETMASK=255.255.255.0" \
    -e "WIFI_IFACE=wlxec888fbd53b0" \
    -e "WIFI_SSID=Didi-Guest" \
    -e "WIFI_PASSWORD=didichuxing" \
    -e "WIFI_DHCP=true" \
    chinkiang/onecloud_openwrt