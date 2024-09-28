# Minitron
Transform your Prusa Mini into a Upside down CoreXY printer.

![Screenshot of the positron CAD project](http://url/to/img.png)

# Why Upside Down
Because it looks cool.

Also so we can implement CoreXY without needing a frame, which means you don't need to buyextrusion for this mod. The lower center of mass should also help with stability and ringing.

Also, you get about 4 cm more print volume on the z axis.

# WARNING
This project is not even close to being finished. I have yet to print the parts and try the first prototype, hopefully, I wall be able to iterate to a functional version fast.

# BOM (Bill of Materials)
- PTFE tube
- LM8UU linear bearing
- GT2 belt 6mm
- GT2 idlers (6mm belt, 3mm bore)

- (Optional for those who want Klipper/Mainsail) Raspberry Pi
- (Optional but recommended for Mainsail) Pi Camera Module v2.1

# MainsailOS
MainsailOS is the operating system you will run on your control board (the raspberry pi). Mainsail handles the webinterface, prints, sending gcode and basically anything except communication with hardware which is the Buddy Boards job. [Install Mainsail here](https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based). If you don't fell comfortable with Klipper and Mainsail you can try [this modified buddy board firmware](https://github.com/Snake-Edition/P32-FW/releases).

If you're using the rtl8188eu wifi adapter you should follow [these instruction](#rtl8188eu) to get wifi working.

## Remote Control (Octoeverywhere)https://help.prusa3d.com/article/flashing-custom-firmware-mini_14
Follow [their official instructions](https://octoeverywhere.com/dashboard?source=mainsail_docs). To learn of other solutions visit [mainsails page](https://docs.mainsail.xyz/overview/quicktips/remote-access).

## Backups
I broke my sd card to my printer once. Not fun. Nowdays I always backup my config files to github with [klipper-backup.git](https://github.com/Staubgeborener/klipper-backup?tab=readme-ov-file). Follow the instructions in their [documentation](https://klipperbackup.xyz/).

#rtl8188eu
Install the drivers with this [excellent tutorial](https://gist.github.com/MBing/de297a8ae5e8a191c55a67a568d20d31) by [MBing](https://gist.github.com/MBing). I prefer a static ip address so my /etc/network/interfaces looks like this instead:
```
auto wlan0
iface wlan0 inet static
address [insert ip address]
netmask [insert netmask]
gateway [insert gateway]
broadcast [insert broadcast]
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf' > /etc/network/interfaces"
```
To get all these values you need to connect the Raspberry Pi to ethernet and run ```ifconfig```.

## Installing Klipper
To install third party firmware you need to put your printer int DFU mode. Do this by following [the official instructions](https://help.prusa3d.com/article/flashing-custom-firmware-mini_14). Basically, it boils down to cuting the appendix and then short circuing the appendix pins at the same time as switching on the printer. The screen should be completely white.

## Klipper, taget från [denna video av KennsKustoms](https://www.youtube.com/watch?v=6KAFPcL1O-4)
Gå in i klipper mappen `$ cd ~/klipper`
Starta klipper konfigurationen `$ make menuconfig` och välj inställningarna:
    Enable extra low-level configuration options
    STMicroelectronics STM32
    STM32F407
    No Bootloader
    Clock Reference 12 Mhz crystal
    Communication interface USB (on PA11/PA12)

Kör kommandot `$ lsusb` och letar efter en enhet med DFU i namnet. Använd den enhetens id och kör kommandot `make flash FLASH_DEVICE=[id]` där id är enhetens id.

## Klipper konfiguration
Kopiera innehållet av *printer.cfg* till klipper genom mainsails interface. Kör kommandot `ls /dev/serial/by-id/*` och använd värdet för att ändra *mcu > serial* i *printer.cfg*.

## Kamera (RPI Camera Module v2.1)
Kolla Crowsnests log för att hitta vilken sökväg din camera har. Sedan sätter du denna under *cam > device* i filen *crowsnest.conf*.

Du kan behöva ladda om sidan för att kameran ska fungera.

## Problems
I can't get input shaping to work. Dö not just use the input shaper present in prisa slicer, that makes my prints fall everytime.

Purging immidiately afterwards fixes it for me.

# Credit
Credit to Prusa for the Prusa Mini and credit to Kralyn for the Positron printer and Voxolite for the JourneyMaker. All printers were a massive help while trying to model my own printer.
