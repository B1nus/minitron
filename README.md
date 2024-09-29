# Minitron
Turn your Prusa Mini into an upside-down CoreXY 3D Printer. This github repository covers the software side of the project, for build instructions and the bill of materials check out [the printables page](https://www.printables.com/model/1022602-minitron).

![Screenshot of the positron CAD project](https://github.com/B1nus/minitron/blob/main/Images/cad-dark.png)

# WARNING!
This project is far from being finished. I have yet to print the parts for the first prototype, please bear with me.

# MainsailOS
MainsailOS is the operating system you will run on your control board (the raspberry pi). Mainsail handles the webinterface, scheduling prints, sending gcode and basically anything except communication with hardware which is the Buddy Boards job. [Install Mainsail here](https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based). If you don't fell comfortable with Klipper and Mainsail you can try [this modified buddy board firmware](https://github.com/Snake-Edition/P32-FW/releases). Please note that you won't have a place to mount the LCD screen, as this printer is designed to use Mainsail's web interface instead of the LCD.

If you're using the rtl8188eu wifi adapter you should follow [these instruction](#rtl8188eu) to get wifi working.

## Installing Klipper
To install third party firmware you need to put your printer into DFU mode. Do this by following [the official instructions](https://help.prusa3d.com/article/flashing-custom-firmware-mini_14). Basically you need to cut the appendix and then short circuit two pins at the same time as switching on the printer. Connect the printer to your Raspberry Pi and proceed with these commands:

First run `$ cd ~/klipper`
Then `$ make menuconfig` and choose:
- Enable extra low-level configuration options
- STMicroelectronics STM32
- STM32F407
- No Bootloader
- Clock Reference 12 Mhz crystal
- Communication interface USB (on PA11/PA12)

Now run `lsusb` and look for a device with "DFU" in the name. If you can't find it, chances are the printer is not in DFU mode or the cable to the printer isn't working. To check if the printer is in DFU mode, turn it off and connect the LCD to the board. After putting it into DFU mode the screen should be blinding white.

When you've found the DFU device run `make flash FLASH_DEVICE=[insert id here]` with the id you found with `lsusb`.

# Configuration
My printer configuration is backed up automatically to this repository in *printer_data/config*. Feel free to use my config files. Don't forget to change the `rotation_distance` to `32` in the *printer.cfg* file if you're using the stock extruder. My prusa slicer profiles are also in this repository in the folder *prusa_profiles*.

Learn more about Klipper from their [documentation](https://www.klipper3d.org/pressure_advance.html).

# Extras
### Camera
Check crowsnests logs to find the search path to your camera. Set *cam > device* in the file *crowsnest.conf* to this path. Sometimes it takes a while for the camera to load, you might need to refresh the page as well.

### Remote Control (Octoeverywhere)
Follow [their official instructions](https://octoeverywhere.com/dashboard?source=mainsail_docs). To learn of other solutions visit [mainsails page](https://docs.mainsail.xyz/overview/quicktips/remote-access).

### Backups
I broke my sd card once. Not fun. Nowdays I always backup my config files to github with [klipper-backup.git](https://github.com/Staubgeborener/klipper-backup?tab=readme-ov-file). Follow the instructions in their [documentation](https://klipperbackup.xyz/).

# Technical detail
### rtl8188eu
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
