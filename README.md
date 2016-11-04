STC\-1000+\-STM8
==========

This version of the STC\-1000+ is heavily based on the beautiful work from Mats Staffansson (https://github.com/matsstaff/stc1000p), where he creates an open-source implementation of firmware(s) for the STC\-1000 dual stage thermostat.
Mats version is used by numerous home-brewers for automating their brewery / climate chamber. The hardware is controlled by a PIC18F1828 microcontroller, which is pretty limited. Despite these limitations Mats succeeded in
adding 6 profiles with up to 9 temperature-time pairs per profile.

I bought a couple of STC\-1000 devices which had another microcontroller and completely different hardware on-board. It is the STM8S003F3 microcontroller. Being the electrical engineer that I am, I wanted to reverse engineer
the hardware, create the schematics and new boards and (like Mats) add new features. You can find the schematics (with the Eagle design files) all here. I also used Mats software as a start, but needed to heavily modify it in order
to run on the new hardware platform.

So, for those of you who have this version of the STC\-1000: enjoy! Because now you can have almost the same functionality as Mats realised in the PIC version of the STC\-1000. There's only one real drawback: the STM8 microcontroller
only has 128 bytes of EEPROM, so the number of profiles and the number of temperature-time pairs per profile are reduced. But you get more features as a standard (switchable) option (instead of programming a different firmware version).

For those of you willing to do some de-soldering: you can replace the microcontroller with a STM8S103Fs microcontroller that has 640 bytes of EEPROM. Then you have the 6 profiles with all temperature-time pairs again.

Last but not least: I also have PCB boards that replace the existing PCBs which contain
an Arduino Nano. Then you have everything you want and more: USB connection for easy changing of parameters and profiles, One-Wire temperaturesensor support, I2C interface for more fancy stuff and a PID controller.

![STC-1000](img/frontpanel_backplane.jpg)

Questions?
----------
Please don't open github issues for general questions. Only open an issue if you discovered an actual bug or have a (realistic) feature request (or better yet, send a pull request).

Quick start
-----------

You'd need one of those fancy coloured ST-Link V2 USB adapter (which are very cheap to find on ebay) and of-course a STC\-1000 with a STM8. Mine has a label '0602 05 R QC' on top, the PCB itself has a mark 'WR-032'. Furthermore you need
the IAR development environment for STM8, which can be downloaded free of charge. Use the code-size limited version. After having installed this, the drivers for the ST-Link USB adapter are also installed.
![st-link-v2](img/st_link_v2.png)

The frontpanel PCB has a 4-pin connector (labeled with SIG, RST, VCC and GND). Solder some pins to this and connect the ST-Link adapter (use GND-GND, RST-RST and SWIM-SIG). Power-up the STC\-1000 and connect the ST-Link V2 USB
If you have downloaded the project-files, open the project in IAR, do a Project->Rebuild All and then press Ctrl-D. This opens the debugger and transfers the code to the microcontroller. Remove the wires, re cycle power and you are good to go!
![swim-interface](img/swim_interface.jpg)

Schematics
----------
I reversed engineered both the frontpanel PCB as well as the backplane PCB. The frontpanel PCB holds the buttons, the 7-segment display (3 digit common-cathode) as well as the STM8S003F3 uC. There's an ingenious connection to the
backplane that holds both relays (able to switch 12A at 230VAC), the power-supply (12V and 5V) and the connectors. The schematics were made with the Eagle PCB program.
![frontpanel](img/schematics_frontpanel.png)

![backplane](img/schematics_backplane.png)
An interesting feature are the S1, S2 lines. It looks likes this is an I2C interface. Interesting feature for those of you willing to do some more hacking!

Introduction (taken from https://github.com/matsstaff/stc1000p)
----------------------------------------------------------

The STC\-1000 is a dual stage (that is, it can control heating *and* cooling) thermostat that is pretty affordable. It is microcontroller operated, that means there is a sort of 'computer on a chip' that reads the temperature of the probe, turns the relays on and off, reads the state of the buttons and updates the display. To do all this, the microcontroller needs to be programmed to perform these tasks. The program is stored in non volatile (flash) memory that is retained when there is no power. The microcontroller can be reprogrammed (flashed) with a new program (firmware), that can other or additional tasks. To do that, a new firmware is needed and you need a programmer that can send it to the microcontroller the way it expects it. The STC\-1000\-STM8 project provides both these things (and a few additional things as well).

So far so good, *but* there is a catch. Probably due to the popularity of the STC\-1000, there are a number of clones out there. These are functionally (from a user perspective) equivalent, but are not based on the same design. 
Specifically, they use other microcontrollers that while having similar specifications, use completely different architectures. 

This STC\-1000+ version is *only* compatible with the WR-032 version of the STC\-1000 as this supports the STM8S003F3 microcontroller, for which you have a code-size limited (8K) version of IAR available.

To upload (flash) the microcontroller, you also need the ST-Link V2 USB adapter ($2-$3 on ebay). There are official ST-Link programmers to purchase, but they typically cost a lot more. Neither of these options are very cost effective, considering the price of the STC\-1000. 

Updates
-------

|Date|Release|Description|
|----|-------|-----------|
|2016-10-27|v1.00|First release, copied from https://github.com/matsstaff/stc1000p

