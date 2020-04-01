STC\-1000+ One vessel brew system controller, STM8 version
============================================
This is a firmware version for the STC-1000 dual stage thermostat with an STM8 microcontroller. The purpose is to serve as a simple semi-automatic controller for a one vessel brewing system (OVBSC).
Note: almost all information on this page is a direct copy from Mats' OVBSC page (https://github.com/matsstaff/stc1000p/tree/master/ovbsc). There are however a few modifications made in this firmware, the most important one
being that there are no constant output (cO) parameters anymore. This is replaced by a PID-controller that controls the output.

By using a separate output for a Solid-State-Relay (SSR), you can connect any type of heater, since an SSR can typically switch a large current.

Features
--------
* Fahrenheit and Celsius adjustable
* Cheap, simple, semi automated one vessel brewing control
* Controls a pump and an electric heater
* Separate heater output for PID-controlled Solid-State-Relay (SSR)
* Alarm when user interaction is required
* Possible to delay heating of strike water
* PID-control during entire brew for accurate temperature control
* Four run-modes: OFF, run-program, constant output and constant temperature
* TODO: Manual pump control (on/off toggle) by pressing Up key for 3 seconds
* TODO: Heater control (on/off toggle) by pressing Down key for 3 seconds
* 1-6 mash steps, 0-4 hop addition alarms
* Pause program at any time
* Button acceleration, for frustrationless programming by buttons

Parameters
----------
|Menu item|Description|Values|
|--------|-------|-------|
|Sd|Strike delay|0-999 minutes|
|St|Strike water setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pt1|Mash step 1 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd1|Mash step 1 duration|0-999 minutes|
|Pt2|Mash step 2 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd2|Mash step 2 duration|0-999 minutes|
|Pt3|Mash step 3 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd3|Mash step 3 duration|0-999 minutes|
|Pt4|Mash step 4 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd4|Mash step 4 duration|0-999 minutes|
|Pt5|Mash step 4 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd5|Mash step 4 duration|0-999 minutes|
|Pt6|Mash step 4 setpoint|-40.0 to 140°C or -40.0 to 250°F|
|Pd6|Mash step 4 duration|0-999 minutes|
|Ht|Hot break temperature|-40.0 to 140°C or -40.0 to 250°F|
|Hd|Hot break duration|0-999 minutes|
|bt|Boil temperature|-40.0 to 140°C or -40.0 to 250°F|
|bd|Boil duration|0-999 minutes|
|hd1|Hop alarm 1|0-999 minutes|
|hd2|Hop alarm 2|0-999 minutes|
|hd3|Hop alarm 3|0-999 minutes|
|hd4|Hop alarm 4|0-999 minutes|
|cF|Celsius or Fahrenheit display|0 = Celsius, 1 = Fahrenheit|
|tc|Temperature correction|-5.0 to 5°C or -10.0 to 10.0°F|
|Hc|Kc parameter for PID-controller in %/°C|-9999 to 9999|
|Ti|Ti parameter for PID-controller in seconds|0 to 9999|
|Td|Td parameter for PID-controller in seconds|0 to 9999|
|Ts|Ts parameter for PID-controller in seconds|0 to 9999|
|APF|Alarm/Pause control flags|0 to 511|
|PF|Pump control flags|0 to 31|
|cO|Manual mode output when Run mode is OFF|-200 to 200%|
|cSP|Manual mode temperature setpoint when Run mode is OFF|-40.0 to 140°C or -40.0 to 250°F|
|cP|Manual mode pump when Run mode is OFF|0 (=off) or 1 (=on)|
|ASd|Safety shutdown timer|0-999 minutes|
|rUn|Run mode|OFF, Pr (run program), Ct (manual mode thermostat), Co (manual mode constant output)|

Note on APF parameter: APF is a parameter that holds flags to enable/disable the alarm/pause points during the program. By default all alarms/pause points are enabled, but this parameter allows the user to skip some/all of them if so desired. To make adjustments, the desired behaviour needs to be calculated.

|Value|Description|
|--------|-------|
|1|Strike temp reached/dough in alarm|
|2|Strike temp reached/dough in pause|
|4|Mash done/sparge/start boil up alarm|
|8|Mash done/sparge/start boil up pause|
|16|Hop addition 1 alarm|
|32|Hop addition 2 alarm|
|64|Hop addition 3 alarm|
|128|Hop addition 4 alarm|
|256|Boil done/start chill alarm|

Add up the values for the alarms/pause points desired, and set that value to the APF parameter. Say for example you'd like to mash in cold, and want the controller to skip the alarm and pause after strike temp is reached, and just continue with the mash profile (but still keep the other alarms/pause points). Then sum up all the alarms (511) and subtract 1 (strike temp reached alarm) and 2 (strike temp reached pause). The value (508) is what you'd want to enter in APF.

Note on PF parameter: The PF parameter holds flags to indicate pump status during different stages of the program. By default the pump is on during the mash.

|Value|Description|
|--------|-------|
|1|Pump during heating of strike water|
|2|Pump during ramping up to reach next mash steps|
|4|Pump during the mash steps|
|8|Pump during heating up to reach hot break|
|16|Pump during hot break|

Similar to the APF parameter. Add upp the values of the stages when the pump should be active and enter it into the PF parameter.

Hardware usage
--------------

Pretty simple really. The cool output relay is used to control a pump, the S3 output is used to connect a Solid-State-Relay (SSR) that connects to a heater. See the 'PID-output for connection to a Solid-State Relay (SSR)' 
section in the [user-manual](./usermanual/README.md) for details.

The output is specified as a percentage and is controlled with slow PWM (that is they are pulsed on/off). So for example, if the PID-output is 75%, the SSR switches 9.375 seconds ON and 2.625 seconds OFF (timebase for this slow PWM signal is 12 seconds).
Typically there's a LED on a SSR, so you can see when the SSR is on or off. Also, the heating LED on the display shows the SSR status. The PID-controller is active most of the time and only needs a setpoint temperature to control everything. 
This is also the case in 'constant temperature' mode where it uses the *cSP* setpoint temperature. Only in 'constant output' mode, the PID-controller is not used and the controller output is directly set to *cO* percent.

Program algorithm
-----------------

* Wait *Sd* minutes (with all outputs off)
* PID-controller on with setpoint *St*
* Wait until temp >= *St* (or end program if countdown-timer = 0)
* St alarm if APF flag set, countdown-timer = *ASd* minutes
* Wait until keypress (or end program if countdown-timer = 0)
* Pause if APF flag set (output off, pump off)
* (This is when you dough in and do manual vorlauf)
* Wait until power key is pressed
* *x* = 1
* *Init mashstep*: PID-controller uses setpoint *Ptx*, pump on if PF flag set, countdown = *ASd* minutes
* Wait until temp >= *Ptx* (or end program if countdown-timer = 0)
* countdown-timer = *Pdx*, pump on if PF flag set
* Wait until countdown-timer = 0
* x = x+1
* if x <= 6 goto *Init mashstep* 
* bU alarm if APF flag set, countdown-timer = *ASd* minutes
* Wait until keypress (or end program if countdown-timer = 0)
* Pause if APF flag set (output off, pump off)
* (This is when you remove grains and sparge)
* Wait until power key is pressed
* PID-controller uses setpoint *Ht*, pump on if PF flag set, countdown-timer = *ASd* minutes
* Wait until temp >= *Ht* (or end program if countdown-timer = 0)
* countdown-timer = *Hd* minutes, pump on if PF flag set
* Wait until countdown-timer = 0
* PID-controller uses setpoint *bt*, countdown-timer = *bd* minutes, pump off
* Wait until countdown-timer = 0, if countdown-timer = *hdx* then hdx alarm if APF flag set
* Ch alarm if APF flag set, output = 0, pump off, end program

During the program the keys have the following function:
- a single press on the power button will pause the program (during pause, a LED will flash and all outputs will be off). Press the power button again and the program will resume.
- a 3-second press on the Up key toggles the pump on/off (not implemented yet).
- a 3-second press on the Down key toggles the PID-controller on/off (not implemented yet).

![Graphical representation](OVBSCgraph.png)<br>
*Fig4: Graphical representation of the algorithm*

Now, I will try as best I can, to explain the algorithm and key concepts in 'english'.<br>
The program starts off with a delay of *Sd* minutes (strike delay), during this time it will do nothing but wait. This can be useful if you want to delay the heating of strike water, so it will be warm by the time you need it 
(don't recommend leaving it unattended, do so at your own risk). *Sd* can of course be set to 0 to start immediately.<br>

Reaching strike temperature is done by the PID-controller that uses setpoint value *St*. If the PID-controller is properly tuned (*Hc*, *Ti*, *Td*, *Ts* parameters), it will quickly reach its setpoint-temperature with no overshoot.<br>

Once strike temperature is reached, the alarm will go off if the corresponding APF flag is set and 'St' will flash on the display. The PID-controller will continue to control the *St* setpoint temperature. 
If the alarm is not acknowledged within *ASd* (automatic shutdown delay) minutes, the program will be stopped. Once acknowledged (by pressing any button), the program will pause if the corresponding APF flag is set 
(all outputs off) and during this pause you dough in your grains. Press the *power* button to continue the program.<br>

In a similar way, for each of the mashing steps, the PID-controller will continue to control the temperature by using the proper setpoint-temperature (*Pt1* to *Pt6*). Once this setpoint-temperature is reached, it holds the mash
step temperature for the programmed duration.<br>

When mashing is done, the alarm will go off again (again if the corresponding APF flag is set) and 'bU' (boil up) is flashing on the display. The PID-controller will now use the *Ht* setpoint temperature. Acknowledge the alarm and the unit will pause (APF flag...) again. Remove the grains and optionally sparge manually. Press *power* button to resume. <br>

Once *Ht* (hotbreak temperature) is reached, the PID-controller holds this temperature for *Hd* (hotbreak duration) minutes. The purpose of this, is that as the wort reaches boiling temp, proteins clump together and a foam is formed on the surface. The added nucleation points as well as the insulating effect of the foam can easily contribute to boil over. The heat will shortly break down the proteins (hot break), that will settle to the bottom of the kettle. So, to avoid boil over the power is reduced during this period. As an educated guess, you might want to set *Ht* a degree or so shy of your normal boiling temperature and *Hd* should probably be around 15 minutes.<br>

When *Hd* has passed, normal boil starts and the PID-controller now uses the *bt* setpoint temperature. Setting this temperature to 102-105 °C assures that the PID-output is 100 % on all the time. The timer also starts counting down the boil duration *bd*. When the timer matches a hop addition the alarm will sound and *hdx* will flash on the display. Acknowledge the alarm by pressing any button (and add the hops of course). Note that the *hdx* settings are in standard hop addition times as used in most recipies, that is the boil duration counted back from boil end.<br>

Once the boil is complete, output is turned off and the alarm goes off (flashing 'Ch' for chill). Acknowledge and chill your wort.<p>

An important note on *ASd*. This is in my opinion an important feature. Many of the steps in the program are timed. For example mash durations, boil duration and so on. But not every step is, for example, when 'stepping up' the temperature, the program will continue to heat until the temperature is reached, or during an alarm (except hop additions, during which the boil duration timer is running) when user input is required, during these times the timer is loaded with *ASd* instead and if not the condition is met within this timeframe, the program stops. This is of course for safety. *ASd* should therefore be set to the maximum of these duration + some wiggle room. For example, if it takes you around 35 minutes to reach strike temp and this is the longest of these delays, maybe set *ASd* to 45 minutes.<br>

Also, a note on switching times. The SSR is controlled with a fixed switching period (12.5 seconds). This is slow enough to control any large heating element (I connected a 3 kW heating element without any problem at all).

Updates
-------

|Date|Release|Description|
|----|-------|-----------|
|2020-04-01|v1.00|First release, copied from Matsstaf and modified|


