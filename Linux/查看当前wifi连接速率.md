在Debian系统中,可以通过以下命令来查询当前WiFi连接的速度:

1. 使用iwconfig命令

 bash
 iwconfig wlan0


其中wlan0是无线网络接口的名称。

命令输出中会包含Bit Rate字段,显示当前连接速度,单位为Mbps。

2. 使用iw命令

 bash
 iw dev wlan0 link


输出中会显示Tx bitrate和Rx bitrate,分别表示发送和接收速率。

3. 使用nmcli命令

 bash
 nmcli device show wlan0 | grep SPEED


nmcli是NetworkManager的命令行接口,可以直接显示连接速度。

4. 如果安装了iostat命令,可以显示网络接口的吞吐速率:

 bash
 iostat -p wlan0


这些命令需要切换到无线网络连接界面wlan0,将显示当前的WiFi连接速度,可以用来检测网络状态。
