STC-1000p-STM8
==========

This version of the STC-1000p (STC-1000p-STM8) is heavily based on the beautiful work from Mats Staffansson (https://github.com/matsstaff/stc1000p), where he creates an open-source implementation of firmware(s) for the STC-1000 dual stage thermostat.
Mats version is used by numerous home-brewers for automating their brewery / climate chamber. The hardware is controlled by a **PIC16F1828** microcontroller (µC), which is pretty limited. Despite these limitations Mats succeeded in
adding 6 profiles with up to 9 temperature-time pairs per profile.

I bought a couple of STC-1000 devices which had another µC with completely different hardware on-board. It is the **STM8S003F3** µC. Being the electrical engineer that I am, I wanted to reverse engineer
the hardware, create the schematics and new boards and (like Mats) add new features. You can find the schematics (with the Eagle design files) all here. I also used Mats software as a start, but needed to heavily modify it in order
to run on the new hardware platform.

So, for those of you who have this version of the STC-1000: enjoy! Because now you can have almost the same functionality as Mats realised in the PIC version of the STC-1000. There's only one real drawback: the STM8 µC
only has 128 bytes of EEPROM, so the number of profiles and the number of temperature-time pairs per profile needed to be reduced. But you get more features as a standard (switchable) option (instead of programming a different firmware version). 
For those of you willing to do some de-soldering (see text below): you can replace the µC with a **STM8S103F3** µC that has 640 bytes of EEPROM. Then you have the 6 profiles with all temperature-time pairs again.

![STC-1000](img/frontpanel_backplane.jpg)<br>
*The frontpanel and backplane of the STC-1000 device*

![stc-1000-top](img/stc1000_top.jpg)<br>
*The top of the STC-1000 device. Note the label '0602 05 R QC'*

If you happen to have an STC-1000 device without the label, you could have the newer hardware revision (**WR-032 v2**). It is almost the same, but has a few changes. Read more about this [here](./WR-032-v2-2016-4-7.md).

Questions?
----------
Please don't open github issues for general questions. Only open an issue if you discovered an actual bug or have a (realistic) feature request (or better yet, send a pull request).

Quick start
-----------
You'd need one of those fancy coloured ST-Link V2 USB adapter (which are very cheap to find on ebay) and of-course an STC-1000 with a STM8. Mine has a label '0602 05 R QC' on top, the Printed Circuit-Board (PCB) itself has a mark 'WR-032'.
 
![st-link-v2](img/st_link_v2.png)<br>
*The ST-Link V2 USB adapter*

The frontpanel PCB already has a 4-pin connector (labeled with SIG, RST, VCC and GND). Solder some pins to this and connect the ST-Link adapter (use GND-GND, RST-RST and SWIM-SIG). Power up the STC-1000 device, so that it uses it's own
power-supply (in this way, the 4th VCC pin on the connecter is not needed). **Please be aware that most of the PCB is directly connected to the MAINS voltage, so keep your fingers out of it!**

This is all you need to reprogram the device! Now power-up the STC-1000 and connect the ST-Link V2 USB to it. 

![swim-interface](img/swim_interface.jpg)<br>
*The Programming Interface. Note that you have to solder the 4-pins in place!*

Method 1: Just program it with ST Visual Programmer
-------------------------
This is the best method if you just want to flash the STC-1000 with the software provided and you don't want to change any software functionality.

- Download the ST Visual Programmer (STVP) software, unpack the .zip file and install it. This file can be downloaded free of charge from the ST website (st.com). Just search for 'STVP-STM8', the file to download is called en.stvp-stm8.zip.
- Run the STVP program, then click on Project -> Open..., select the **stvp_stm8s003f3_4pr_5tt.stp** file and open it. This file is located in src\Debug\Exe. You can safely ignore the 'address out of range' warnings, this is not a problem. Both the *Program Memory* tab and the *Data Memory* tabs are now filled with the data from the .hex file. Check that these tabs are indeed filled with data.
- Now find the button that says "Program all tabs" or click Program->All Tabs. This will program the microcontroller with the new functionality.

Note: there's also a project and .hex file for the **STM8S103F3** microcontroller (with 6 profiles and 9 temperature-time pairs). Use this version when you have replaced the stock microcontroller (see text below).

Method 2: Program and install complete development environment
-------------------------
This is the best method for anyone wanting to flash the STC-1000 and be able to make changes to the software.

- Download and install the IAR development environment for STM8 from the IAR website, which can be downloaded free of charge. Use the code-size limited version. After having installed this, the drivers for the ST-Link USB adapter are also installed.
- If you have downloaded the project- and source-files, open the workspace in IAR (File -> Open -> Workspace... -> stc1000p_dev.eww), then do a Project -> Rebuild All.
- The µC has Read-Only-Protection (ROP) enabled and this needs to be disabled before the new firmware can be uploaded. Click on ST-LINK -> Option Bytes... The following dialog box opens:
![rop-protection](img/Disable_ROP.png)<br>
*The Read-Only-Protection dialog box. Press OK to continue*
- If ROP protection is disabled (and your stock program has been erased, with no way of getting this back), press Ctrl-D. This opens the debugger and transfers the code to the microcontroller. 
- Press Ctrl-Shift-D to Stop Debugging. Remove the wires, re-cycle power and you are good to go!

Introduction (taken from https://github.com/matsstaff/stc1000p)
----------------------------------------------------------
The STC-1000 is a dual stage (that is, it can control heating *and* cooling) thermostat that is pretty affordable. It is microcontroller operated, that means there is a sort of 'computer on a chip' that reads the temperature of the probe, turns the relays on and off, reads the state of the buttons and updates the display. 
To do all this, the microcontroller needs to be programmed to perform these tasks. The program is stored in non volatile (flash) memory that is retained when there is no power. The microcontroller can be reprogrammed (flashed) with a new program (firmware), that can other or additional tasks. 
To do that, a new firmware is needed and you need a programmer that can send it to the microcontroller the way it expects it. The STC-1000\-STM8 project provides both these things (and a few additional things as well).

So far so good, *but* there is a catch. Probably due to the popularity of the STC-1000, there are a number of clones out there. These are functionally (from a user perspective) equivalent, but are not based on the same design. 
Specifically, they use other microcontrollers that while having similar specifications, use completely different architectures. 

This STC-1000+ version is *only* compatible with the **WR-032** version of the STC-1000 as this supports the **STM8S003F3** microcontroller, for which you have a code-size limited (8K) version of IAR available. IAR is the embedded development tool which you use to program the device in the C-language.
To upload (flash) the microcontroller, you also need the ST-Link V2 USB adapter ($2-$3 on ebay). There are official ST-Link programmers to purchase, but they typically cost a lot more. Neither of these options are very cost effective, considering the price of the STC-1000. 

Schematics
----------
I reversed engineered both the frontpanel PCB as well as the backplane PCB. The frontpanel PCB holds the buttons, the 7-segment display (3 digit common-cathode) as well as the **STM8S003F3** µC. There's an ingenious soldered connection that connects the frontpanel PCB to the backplane PCB. The backplane PCB holds both relays (able to switch 12A at 230VAC), the power-supply (12V and 5V) and the connectors. The schematics were made with the Eagle PCB program.

![frontpanel](img/schematics_frontpanel.png)<br>
*Eagle schematic of the Frontpanel PCB*

Two interesting features are shown in this schematic:
- The **S1** and **S2** lines. It looks likes this is an **I<sup>2</sup>C** interface. Interesting feature for those of you willing to do some more hacking! It is not used in this firmware version, these lines are solely for multiplexing the 7-segment displays.
- The **S3** line. Now this is interesting, it is the only hardware pin *NOT* used. The new firmware uses it to switch an SSR (with a slow PWM signal) controlled by a PID-controller. But I guess it can be used for other purposes as well.

![backplane](img/schematics_backplane.png)<br>
*Eagle schematic of the Backplane PCB*

Replacing the STM8S003F3 µC for more EEPOM size
-----------------------------------------------
You do not need to do this, but if you replace the existing **STM8S003F3** microcontroller (µC) with a **STM8S103F3** µC, you get 640 bytes of EEPROM and you can have 6 profiles with up to 9 temperature-time pairs (same as in Mats his version).
You can skip this section if you are not into soldering small devices and the default profiles are oke for you. To replace the device, you would need the following:
- A new **STM8S103F3P6** device (Mouser part nr. 511-STM8S103F3P6). This is a 20-pin TSSOP package that costs about a $1.
- A hot-air rework station for SMD devices (I bought a 858D hot-air station that is very affordable on ebay)
- A soldering iron.
- Solder wick.
- Solder paste. This typically comes with an injection-needle for applying just a little paste on every solder pad.

To start with, we want to remove the frontpanel PCB from the backplane. Remove all the solder-joints with the solder wick. Place the solder wick over the solder-joints, heat it up with the soldering iron and make sure that the solder wick absorbs all solder.
After having done this, it is possible to remove the frontpanel from the backplane with just a little bit of pulling. Be careful, since you don't want to break anything.

![frontpanel removed](img/frontpanel_bottom_view.jpg)<br>
*This is how it looks after the frontpanel is removed from the backplane*

Next: use the hot-air to heat-up the pins on one side of the µC. Use a sharp knife and place it under the µC. Carefully lift-up one side. Do not overheat, since you could damage the PCB tracks. If this is done, let it cool down and heat-up the other side. When the solder melts, it is easy to remove the µC. Use the solder-wick again to remove excess solder from the solder-pads.

If you don't have access to a hot-air rework station, here's a tip from Mats himself: one can can simply thread a thin wire under the legs on one side of the IC, fix one end of the wire and heat the legs with a soldering iron (starting at the other end) while keeping the wire under tension. As the solder melts, you pull the wire under the leg/pad, freeing them.

![uC removed](img/stm8s_removed.jpg)<br>
*This is how it looks after the microcontroller is removed*

Then: apply solder paste to the solder-pads of the µC and position the **STM8S103F3P6** µC exactly above the pads. Note the orientation of the device (there's a small circle denoting pin 1), you don't want to solder it upside-down! Position the µC exactly above the solder-pads, make sure the position is correct for all pins and use the hot-air station again to solder the new IC. Let is cool down again. It would be wise at this point to connect the ST-Link V2 USB device to the programming connector and see if you can connect to the device. If all is well, solder both PCB boards back together. If not, check all solder-joints to see if one or more pins are not connected properly.

Updates
-------

|Date|Release|Description|
|----|-------|-----------|
|2016-12-02|v1.10|reduced code-size by removing unions and bit-fields. Added description how to flash firmware with STVP program. Description added for v2 hardware.|
|2016-10-27|v1.00|First release, copied from https://github.com/matsstaff/stc1000p |

