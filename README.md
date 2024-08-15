# Mainsail
Installera mainsail enligt stegen på [deras hemsida](https://docs-os.mainsail.xyz/getting-started/raspberry-pi-os-based). Glöm inte att din Raspberry Pi 2 endast startar med ett sd kort och inte en usb sticka. Fortsätt inte med [First Boot](https://docs-os.mainsail.xyz/getting-started/first-boot) utan följ instruktionerna i detta dokument istället.

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

## TODO
Filament load/unload macros
Prusa Slicer configs (klipper flavoured gcode)