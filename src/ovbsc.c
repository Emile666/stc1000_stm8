/*==================================================================
  File Name    : ovbsc.c
  Author       : Mats Staffansson / Emile
  ------------------------------------------------------------------
  Purpose : This files contains the relevant functions to transfer
            the stc1000 into a one-vessel brew-system controller.

            Most of these functions are directly copied from the
            Github library https://github.com/matsstaff/stc1000p.

            The original source is created by Mats Staffansson and
            adapted for the STM8S uC by Emile.
  ------------------------------------------------------------------
  STC1000+ is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  STC1000+ is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with STC1000+.  If not, see <http://www.gnu.org/licenses/>.
  ==================================================================
*/
#if defined(OVBSC)
#include <stdint.h>
#include <stdbool.h>
#include <intrinsics.h>
#include "stc1000p.h"
#include "stc1000p_lib.h"
#include "pid.h"

bool ovbsc_off        = true;
bool ovbsc_pause      = false;
bool ovbsc_run_prg    = false;
bool ovbsc_pump_on    = false;
bool ovbsc_thermostat = false;
bool ovbsc_pid_on     = false;

uint8_t  prg_state = PRG_OFF;
uint16_t countdown = 0;
uint8_t  mashstep  = 0; 

extern bool    sound_alarm; // true = sound alarm
extern int16_t setpoint;    // Setpoint temperature
extern int16_t temp_ntc1;   // The temperature in E-1 °C from NTC probe 1
extern int16_t pid_out;     // Output from PID controller in E-1 %
extern const uint8_t led_lookup[];

// Global variables to hold LED alarm data
uint8_t al_led_10, al_led_1, al_led_01;  // values of 10s, 1s and 0.1s

/*-----------------------------------------------------------------------------
  Purpose  : This is the state machine for the One Vessel Brew System Controller.
             It is called every second from ctrl_task().
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void ovbsc_fsm(void)
{
    static uint8_t sec_countdown = 60;
    uint8_t        i;
    bool           found;
    
    if (!ovbsc_off && !ovbsc_pause && countdown)
    {   // countdown minutes
        if (sec_countdown == 0)
        {
            sec_countdown = 60;
            countdown--;
        } // if
        sec_countdown--;
    } // if

    switch (prg_state)
    {
        //---------------------------------------------------------------------
        case PRG_OFF:
             ovbsc_pid_on = false; // disable PID controller
             if (ovbsc_run_prg)
             {   // ovbsc_run_prg is set to by Run Mode Parameter (rUn)
                 countdown = eeprom_read_config(EEADR_MENU_ITEM(Sd)); /* Strike delay */	
                 ovbsc_pid_on    = false; // disable PID-controller / SSR
                 ovbsc_pump_on   = false;
                 prg_state       = PRG_WAIT_STRIKE;
             } // if
             else 
             {
                 if (ovbsc_thermostat)
                 {   // manual mode: set fixed temperature
                     ovbsc_pid_on = true; // enable PID controller
                     setpoint     = eeprom_read_config(EEADR_MENU_ITEM(cSP));
                 } 
                 else 
                 {   // manual mode: set constant output
                     pid_out = 10 * eeprom_read_config(EEADR_MENU_ITEM(cO));
                 } // else
                 ovbsc_pump_on = eeprom_read_config(EEADR_MENU_ITEM(cP));
             } // else
             break;
        //---------------------------------------------------------------------
        case PRG_WAIT_STRIKE:
             if (countdown == 0)
             {   // strike delay timer time-out
                 countdown     = eeprom_read_config(EEADR_MENU_ITEM(ASd)); /* Safety shutdown timer */
                 ovbsc_pid_on  = true; // enable PID-controller / SSR
                 ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 0) & 0x1;
                 prg_state     = PRG_STRIKE;
             } // if
             else if (ovbsc_off)
             {
                 prg_state = PRG_OFF;
             } // else
             break;
        //---------------------------------------------------------------------
        case PRG_STRIKE:
             setpoint = eeprom_read_config(EEADR_MENU_ITEM(St)); /* Strike temp */
             if (temp_ntc1 >= setpoint)
             {
                 sound_alarm = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> 0) & 0x1;
                 al_led_10 = LED_S;
                 al_led_1  = LED_t;
                 al_led_01 = LED_OFF;
                 countdown = eeprom_read_config(EEADR_MENU_ITEM(ASd)); /* Safety shutdown timer */
                 prg_state = PRG_STRIKE_WAIT_ALARM;
             } // if
             else if ((countdown == 0) || ovbsc_off)
             {   // Safety shutdown timer time-out
                 ovbsc_off = true;
                 prg_state = PRG_OFF;
             } // else if
             break;
        //---------------------------------------------------------------------
        case PRG_STRIKE_WAIT_ALARM:
             if (!sound_alarm)
             {
                 ovbsc_pause = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> 1) & 0x1;
                 mashstep    = 0;
                 countdown   = eeprom_read_config(EEADR_MENU_ITEM(ASd));  // Safety shutdown timer
                 ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 1) & 0x1;
                 prg_state   = PRG_INIT_MASH_STEP;
             } // if
             else if ((countdown == 0) || ovbsc_off)
             {   // Safety shutdown timer time-out
                 ovbsc_off = true;
                 prg_state = PRG_OFF;
             } // else if
             break;
        //---------------------------------------------------------------------
        case PRG_INIT_MASH_STEP:
             setpoint   = eeprom_read_config(EEADR_MENU_ITEM(Pt1) + (mashstep << 1)); /* Mash step temp */
             if (!ovbsc_pause && ((temp_ntc1 >= setpoint) || 
                                  (eeprom_read_config(EEADR_MENU_ITEM(Pd1) + (mashstep << 1)) == 0)))
             {
                 countdown = eeprom_read_config(EEADR_MENU_ITEM(Pd1) + (mashstep << 1)); /* Mash step duration */
                 ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 2) & 0x1;
                 prg_state = PRG_MASH;
             } 
             else if ((countdown == 0) || ovbsc_off)
             {   // Safety shutdown timer time-out
                 ovbsc_off = true;
                 prg_state = PRG_OFF;
             } // else if
             break;
        //---------------------------------------------------------------------
        case PRG_MASH:
             if (countdown == 0)
             {
                 countdown = eeprom_read_config(EEADR_MENU_ITEM(ASd));
                 if (++mashstep < 6)
                 {
                     ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 1) & 0x1;
                     prg_state = PRG_INIT_MASH_STEP;
                 } // if
                 else 
                 {
                     sound_alarm = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> 2) & 0x1;
                     al_led_10 = LED_b;
                     al_led_1  = LED_U;
                     al_led_01 = LED_OFF;
                     prg_state = PRG_WAIT_BOIL_UP_ALARM;
                 } // else
             } // if
             else if (ovbsc_off)
             {
                 prg_state = PRG_OFF;
             } // else
             break;
        //---------------------------------------------------------------------
        case PRG_WAIT_BOIL_UP_ALARM:
             if (!sound_alarm)
             {
                 ovbsc_pause   = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> 3) & 0x1;
                 countdown     = eeprom_read_config(EEADR_MENU_ITEM(ASd));
                 ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 3) & 0x1;
                 prg_state     = PRG_INIT_BOIL_UP;
             } // if
             else if ((countdown == 0) || ovbsc_off)
             {   // Safety shutdown timer time-out
                 ovbsc_off = true;
                 prg_state = PRG_OFF;
             } // else if
             break;
        //---------------------------------------------------------------------
        case PRG_INIT_BOIL_UP:
             if (!ovbsc_pause && (temp_ntc1 >= eeprom_read_config(EEADR_MENU_ITEM(Ht))))
             {   /* Boil up temp */
                 countdown     = eeprom_read_config(EEADR_MENU_ITEM(Hd)); /* Hotbreak duration */
                 ovbsc_pump_on = (eeprom_read_config(EEADR_MENU_ITEM(PF)) >> 4) & 0x1;
                 prg_state     = PRG_HOTBREAK;
             } // if
             else if ((countdown==0) || ovbsc_off)
             {   // Safety shutdown timer time-out
                 ovbsc_off = true;
                 prg_state = PRG_OFF;
             } // else if
             break;
        //---------------------------------------------------------------------
        case PRG_HOTBREAK:
             if (countdown == 0)
             {
                 countdown     = eeprom_read_config(EEADR_MENU_ITEM(bd)); /* Boil duration */ 
                 ovbsc_pump_on = false;
                 prg_state     = PRG_BOIL;
             } // if
             else if (ovbsc_off)
             {
                 prg_state = PRG_OFF;
             } // else
             break;
        //---------------------------------------------------------------------
        case PRG_BOIL:
             found = false;
             i     = 0;
             while (!found && (i < 4))
             {
                 if ((countdown == eeprom_read_config(EEADR_MENU_ITEM(hd1) + i)) && (sec_countdown > 57))
                 {   /* Hop timer */
                     sound_alarm = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> (4+i)) & 0x1;
                     al_led_10   = LED_h;
                     al_led_1    = LED_d;
                     al_led_01   = led_lookup[i+1];
                     found       = true;
                 } // if
                 i++;
             } // while
             if ((countdown == 0) || ovbsc_off)
             {   // finished boiling
                 ovbsc_off     = true;
                 ovbsc_run_prg = false;
                 prg_state     = PRG_OFF;
                 ovbsc_pid_on  = false; // disable PID controller
                 sound_alarm   = (eeprom_read_config(EEADR_MENU_ITEM(APF)) >> 8) & 0x1;
                 al_led_10     = LED_C;
                 al_led_1      = LED_h;
                 al_led_01     = LED_OFF;
             } // if
             break;
    } // switch(prg_state)
} // program_fsm()
 
#endif /* #define(OVBSC) */