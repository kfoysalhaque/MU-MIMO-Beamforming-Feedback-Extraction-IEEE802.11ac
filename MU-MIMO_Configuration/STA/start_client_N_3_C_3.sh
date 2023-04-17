wpa_supplicant -B -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf
ifconfig wlan0 "$1"
service firewall stop
echo "if firewall stop doesnt work run 'service firewall stop'"
ifconfig wlan0 down
iw phy phy0 set antenna 0x7
ifconfig wlan0 up
iw dev wlan0 set bitrates vht-mcs-5 3:0-9
iw phy0 info

