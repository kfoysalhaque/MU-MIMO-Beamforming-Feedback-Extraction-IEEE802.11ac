# MU-MIMO_Beamforming_Feedback_Extraction

This repository provides tool for the IEEE 802.11ac MU-MIMO Beamforming Feedback Information (BFI) extraction with any Wi-Fi compliant device in monitor mode. We consider that, you have already setup the MU-MIMO WLAN or access to your target MU-MIMO network. However, the extraction tool will also work with any home/office  network where the AP supports IEEE 802.11ac MU-MIMO beamforming. 


*The AP (beamformer) continuously perform channel calibration procedure leveraging the available STAs (beamformees), the BFI contains very rich, reliable and spatially diverse information. Since the BFI is broadcasted by the beamformees, this spatially diverse information can be collected with a single capture by the AP or any other Wi-Fi compliant device*

### MU-MIMO BFI from AP to the multiple STAs can be collected in a signle capture without any need for specialized equipments or firmware modifications (unlike CSI) which can be leveraged in various applications including *Radio Fingerprinting, Wi-Fi Sensing, Spectrum Sensing*

For capturing such feedback, even  though we do not need any direct communication / link to the AP or any STAs, we need to know the communication channel and bandwidth. We need wireshark and airmon-ng tool for capturing the transmission in monitor mode which can be installed with (in any ubuntu or ubuntu based distros):

``` 
sudo apt install wireshark &&
sudo apt-get install -y aircrack-ng
```
