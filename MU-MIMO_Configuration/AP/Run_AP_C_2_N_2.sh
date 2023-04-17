hostapd -B hostapd_ch_36_bw80.conf
ifconfig wlan0 192.168.10.1
ifconfig wlan0 down
iw phy phy0 set antenna 0x3
ifconfig wlan0 up
iw dev wlan0 set bitrates vht-mcs-5 1:0-9
iw phy0 info
