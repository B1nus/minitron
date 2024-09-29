# Minitron
Turn your Prusa Mini into an upside-down CoreXY 3D Printer.

![Screenshot of the positron CAD project](https://github.com/B1nus/minitron/blob/main/Images/CAD-dark.png)

# Why Upside Down?
Because it looks cool. ;)

We can implement CoreXY without needing a frame, which means you don't need to buy extrusions for this mod. The lower center of mass should also help with stability and ringing. Another bonus are the 4 extra centimeters of print height.

# WARNING!
This project is far from being finished. I have yet to print the parts for the first prototype, please bear with me.

# BOM (Bill of Materials)
### Needed
- PTFE tube
- LM8UU linear bearing
- GT2 belt 6mm
- GT2 idlers (6mm belt, 3mm bore)
### Optional
- (for those who want Klipper/Mainsail) Raspberry Pi
- (Not necessary, but recommended for Mainsail) Pi Camera Module v2.1
### Very Optional mods made by yours truly ;)
- (Not necessary!) [Dual gear drive extruder](https://www.printables.com/model/946290-dual-gear-drive-extruder-for-prusa-minimini)
- (Not necessary!) [Raspberry Pi Mount](https://www.printables.com/model/978537-raspberry-pi-2-model-b-mount-for-prusa-minimini)

# Build instructions
Use the CAD model to unserstand how to build the printer. Here's a link to the [Onshape document](https://cad.onshape.com/documents/bdba07cfb1c6cbca39f7ad6d/w/d4acb14181f8491cce1dc9c2/e/9745e20551a21d0f0c47736c?renderMode=0&uiState=66f93200321c431edb2c02a8) which will help you with screw names and such. Let me know if build instructions are needed or if anything is wrong with the Onshape doucment.

# MainsailOS
MainsailOS is the operating system you will run on your control board (the raspberry pi). Mainsail handles the webinterface, scheduling prints, sending gcode and basically anything except communication with hardware which is the Buddy Boards job. [Install Mainsail here](https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based). If you don't fell comfortable with Klipper and Mainsail you can try [this modified buddy board firmware](https://github.com/Snake-Edition/P32-FW/releases).

If you're using the rtl8188eu wifi adapter you should follow [these instruction](#rtl8188eu) to get wifi working.

## Installing Klipper
To install third party firmware you need to put your printer into DFU mode. Do this by following [the official instructions](https://help.prusa3d.com/article/flashing-custom-firmware-mini_14). Basically you need to cut the appendix and then short circuit two pins at the same time as switching on the printer. The screen should be completely white if done correctly. Connect the printer to your Raspberry Pi and proceed with these commands:

First run `$ cd ~/klipper`
Then `$ make menuconfig` and choose:
- Enable extra low-level configuration options
- STMicroelectronics STM32
- STM32F407
- No Bootloader
- Clock Reference 12 Mhz crystal
- Communication interface USB (on PA11/PA12)

Now run `lsusb` and look for a device with "DFU" in the name. Then run `make flash FLASH_DEVICE=[insert id here]` with the usb identifier found from `lsusb`.

## Klipper konfiguration
My configuration is backed up automatically to *printer_data/config*. Feel free to use my config files. Don't forget to change the `rotation_distance` to `32` in the *printer.cfg* file if you're using the stock extruder.

Learn more about Klipper from their [documentation](https://www.klipper3d.org/pressure_advance.html).

# Extras
## Camera
Check crowsnests logs to find the search path to your camera. Set *cam > device* in the file *crowsnest.conf* to this path. Sometimes it takes a while for the camera to load, you might need to refresh the page as well.

## Remote Control (Octoeverywhere)
Follow [their official instructions](https://octoeverywhere.com/dashboard?source=mainsail_docs). To learn of other solutions visit [mainsails page](https://docs.mainsail.xyz/overview/quicktips/remote-access).

## Backups
I broke my sd card once. Not fun. Nowdays I always backup my config files to github with [klipper-backup.git](https://github.com/Staubgeborener/klipper-backup?tab=readme-ov-file). Follow the instructions in their [documentation](https://klipperbackup.xyz/).

# rtl8188eu
This specific driver caused me some trouble. To fix it, install the driver with this [excellent tutorial](https://gist.github.com/MBing/de297a8ae5e8a191c55a67a568d20d31) by [MBing](https://gist.github.com/MBing). If you want to choose a specific ip address change your /etc/interfaces file to something like this:
```
auto wlan0
iface wlan0 inet static
address [insert ip address]
netmask [insert netmask]
gateway [insert gateway]
broadcast [insert broadcast]
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
Get the values by running ```ifconfig``` on another device connected to the same wifi.

# Credit
Credit to Prusa for the Prusa Mini, Kralyn for the Positron printer and Voxolite for the JourneyMaker. I wouldn't have been able to make this printer without you.
