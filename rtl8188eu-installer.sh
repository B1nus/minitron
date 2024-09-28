## DO NOT have the wifi dongle plugged in until mentioned excplicitly down belov
##
## Credit to https://gist.github.com/MBing/de297a8ae5e8a191c55a67a568d20d31 for the excellent tutorial!
# Install dependencies
sudo apt update && sudo apt upgrade && sudo apt install -y build-essential git linux-headers raspberrypi-kernel-headers
reboot

# Install the new drivers
git clone https://github.com/lwfinger/rtl8188eu.git && cd rtl8188eu
make && sudo make install
reboot

# Shutdown and PLUG IN THE WIFI ADAPTER
sudo shutdown -h now

# Tests
lsusb
lsmod | grep "8188"

# Install network config
sudo sh -c "echo 'source /etc/network/interfaces.d/*
auto wlan0
iface wlan0 inet static
address 10.20.51.27
netmask 255.255.255.0
gateway 10.20.51.1
broadcast 10.20.51.255
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf' > /etc/network/interfaces"

sudo sh -c "echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid=\"Grid\"
    psk=\"kublizard39\"
}' > /etc/wpa_supplicant/wpa_supplicant.conf"

# Reboot and test if the connection is working
reboot
ping archlinux.org