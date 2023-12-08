iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i wlan0 -o zteb4ofk7u -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i zteb4ofk7u -o wlan0 -j ACCEPT
