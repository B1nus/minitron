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
- Raspberry Pi
- PTFE tube
- LM8UU linear bearing
- GT2 belt 6mm
- GT2 idlers (6mm belt, 3mm bore)
  
- (Optional but recommended) Pi Camera Module v2.1

# Klipper
This printer uses klipper, you can also try [this modified prusa firmware](https://github.com/Snake-Edition/P32-FW/releases) if you're uncomfortable with klipper.

## MainsailOS
MainsailOS is the operating system you will run on your control board (the raspberry pi). Mainsail handles the webinterface, prints, sending gcode and basically anything except communication with hardware which is the Buddy Boards job. [Install Mainsail here](https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based).

## Problems with Wifi Dongle TP-link rtl8188eu

Fortsätt inte med [First Boot](https://docs-os.mainsail.xyz/getting-started/first-boot).

## Remote Control (Octoeverywhere)


## Backups
I broke my sd card to my printer once. Not fun. Nowdays I always backup my config files to github with [klipper-backup.git](https://github.com/Staubgeborener/klipper-backup?tab=readme-ov-file). Follow the instructions in their [documentation](https://klipperbackup.xyz/).

# SSH
Vid steget [First Boot](https://docs-os.mainsail.xyz/getting-started/first-boot) måste du fixa med ditt nätverk. Starta din Raspberry Pi och kolla ip addressen med ethernet inkopplat. Nu kan du börja använda ssh istället med kommandot `$ ssh 10.20.51.27`, det är enkelt att göra misstag om man kopierar för hand så jag rekommenderar starkt att använda ssh och installations skriptet.

## TP-link drivrutiner och nätverkskonfiguration
Börja med att installera rätt drivrutiner och konfigurera ditt nätverk med hjälp av filen *rtl8188eu-installer.sh*. Detta är en enklare version av MBings [fina instruktioner](https://gist.github.com/MBing/de297a8ae5e8a191c55a67a568d20d31) så tack till [MBing](https://gist.github.com/MBing).

Prova om allt fungerar med din telefon på <http://10.20.51.27> på nätverket Grid. Du kan nu koppla in Raspberry Pi till din printer och sätta din printer i DFU läget. Du gör detta genom att starta den samtidigt som du kortsluter appendix pinsen. kör sedan `ssh 10.20.51.27` från din valda dator och fortsätt med nästa del.

# Klipper, taget från [denna video av KennsKustoms](https://www.youtube.com/watch?v=6KAFPcL1O-4)
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

## Octoeverywhere (Mainsail utanför närverket)
Följ [deras officiella instruktioner](https://octoeverywhere.com/dashboard?source=mainsail_docs). För en översikt av olika lösningar så finns [mainsails hemsida](https://docs.mainsail.xyz/overview/quicktips/remote-access).

## Problems
I can't get input shaping to work. Dö not just use the input shaper present in prisa slicer, that makes my prints fall everytime.

Purging immidiately afterwards fixes it for me.

# Credit
Credit to Prusa for the Prusa Mini and credit to Kralyn for the Positron printer and Voxolite for the JourneyMaker. All printers were a massive help while trying to model my own printer.
