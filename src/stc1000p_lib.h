/*==================================================================
  File Name    : stc1000p_lib.h
  Author       : Mats Staffansson / Emile
  ------------------------------------------------------------------
  Purpose : This is the header-file for stc1000p_lib.c

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
  ------------------------------------------------------------------
  $Log: $
  ==================================================================
*/ 
#ifndef STC1000P_LIB_H
#define STC1000P_LIB_H

#include <stdint.h>
#include <stdbool.h>
#include <intrinsics.h>
#include "stc1000p.h"
#include "eep.h"
#include "pid.h"

// Define limits for temperatures in Fahrenheit and Celsius
#define TEMP_MAX_F	  (2500)
#define TEMP_MIN_F	  (-400)
#define TEMP_CORR_MAX_F	  ( 100)
#define TEMP_CORR_MIN_F	  (-100)
#define TEMP_HYST_1_MAX_F ( 100)
#define TEMP_HYST_2_MAX_F ( 500)
#define SP_ALARM_MIN_F	  (-800)
#define SP_ALARM_MAX_F	  ( 800)

#define TEMP_MAX_C	  (1400)
#define TEMP_MIN_C	  (-400)
#define TEMP_CORR_MAX_C	  (  50)
#define TEMP_CORR_MIN_C	  ( -50)
#define TEMP_HYST_1_MAX_C (  50)
#define TEMP_HYST_2_MAX_C ( 250)
#define SP_ALARM_MIN_C	  (-400)
#define SP_ALARM_MAX_C	  ( 400)

// Values for temperature control STD
#define STD_OFF      (0)
#define STD_DLY_HEAT (1)
#define STD_DLY_COOL (2)
#define STD_HEATING  (3)
#define STD_COOLING  (4)

//---------------------------------------------------------------------------
// Basic defines for EEPROM config addresses
// One profile consists of several temp. time pairs and a final temperature
//
// Do NOT Forget to set:
// 1) proper #include in stc1000p.h: <iostm8s003f3.h> or <iostm8s103f3.h>
// 2) Project -> Options -> Target -> Device to STM8S003F3 or STM8S103F3
//---------------------------------------------------------------------------
#ifdef __IOSTM8S103F3_H__
#define NO_OF_PROFILES	 (6)
#define NO_OF_TT_PAIRS   (9)
#else
#define NO_OF_PROFILES	 (4)
#define NO_OF_TT_PAIRS   (5)
#endif
#define PROFILE_SIZE     (2*(NO_OF_TT_PAIRS)+1)
#define MENU_ITEM_NO	 NO_OF_PROFILES
#define THERMOSTAT_MODE  NO_OF_PROFILES

//-----------------------------------------------------------------------------
// Enum to specify the types of the parameters in the menu.
// Note that this list needs to be ordered by how they should be presented 
// on the display. The 'temperature types' should be first so that everything 
// less or equal to t_sp_alarm will be presented as a temperature.
// t_runmode and t_period are handled as special cases, everything else is 
// displayed as integers.
//-----------------------------------------------------------------------------
enum e_item_type 
{
    t_temperature = 0,
    t_tempdiff,
#if defined(OVBSC)
    t_percentage,
    t_period,
    t_apflags,
    t_pumpflags, 
#endif
    t_hyst_1,
    t_hyst_2,
    t_sp_alarm,
    t_step,
    t_delay,
    t_runmode,
    t_duration,
    t_boolean,
    t_parameter
}; // e_item_type

#if defined(OVBSC)
    #define MENU_TYPE_IS_TEMPERATURE(x) 	((x) <= t_tempdiff)
#else
    #define MENU_TYPE_IS_TEMPERATURE(x) 	((x) <= t_sp_alarm)
#endif

#if defined(OVBSC)
//-----------------------------------------------------------------------------
// The data needed for the 'Set' menu. Using x macros to generate the needed
// data structures, all menu configuration can be kept in this single place.
//
// The values are:
// 	name, LED data 10, LED data 1, LED data 01, min value, max value, default value
//
// Sd	Strike delay	                                 0-999 minutes
// St	Strike water setpoint                            -40.0 to +140 °C or -40.0 to 250.0°F
// Pt1	Mash step 1 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd1	Mash step 1 duration                             0-999 minutes
// Pt2	Mash step 2 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd2	Mash step 2 duration                             0-999 minutes
// Pt3	Mash step 3 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd3	Mash step 3 duration                             0-999 minutes
// Pt4	Mash step 4 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd4	Mash step 4 duration                             0-999 minutes
// Pt5	Mash step 5 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd5	Mash step 5 duration                             0-999 minutes
// Pt6	Mash step 6 setpoint 	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Pd6	Mash step 6 duration                             0-999 minutes
// Ht	Hot break temperature	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// Hd	Hot break duration	                         0-999 minutes
// bt	Boil temperature	                         -40.0 to 140 °C or -40.0 to 250.0 °F
// bd	Boil duration	                                 0-999 minutes
// hd1	Hop alarm 1                                      0-999 minutes
// hd2	Hop alarm 2                                      0-999 minutes
// hd3	Hop alarm 3                                      0-999 minutes
// hd4	Hop alarm 4                                      0-999 minutes
// CF	Set Celsius of Fahrenheit temperature display    0 = Celsius, 1 = Fahrenheit
// tc	Temperature correction	                         -5.0 to 5.0°C or -10.0 to 10.0°F
// Hc   Kc parameter for PID controller in %/°C          -9999..9999, >0: heating loop, <0: cooling loop 
// ti   Ti parameter for PID controller in seconds       0..9999 
// td   Td parameter for PID controller in seconds       0..9999 
// ts   Ts parameter for PID controller in seconds       0..9999, 0 = disable PID controller = thermostat control
// APF	Alarm/Pause control flags	                 0 to 511
// PF	Pump control flags	                         0 to 31
// cO   Manual mode output                               -200 to +200 % 
// cSP  Manual mode Thermostat setpoint                  -40.0 to 140 °C or -40.0 to 250.0 °F
// cP   Manual mode Pump                                 0 (off) or 1 (on) 
// ASd  Safety shutdown timer                            0..999 minutes
// rUn	Run mode	                                 OFF, Pr (run program), 
//                                                       Ct (manual mode thermostat), Co (manual mode constant output)
//-----------------------------------------------------------------------------
#define MENU_DATA(_) \
    _(Sd,       LED_S, 	LED_d, 	LED_OFF,   t_duration,		0)	\
    _(St, 	LED_S, 	LED_t, 	LED_OFF,   t_temperature,	550)    \
    _(Pt1, 	LED_P, 	LED_t, 	LED_1,	   t_temperature,	530)	\
    _(Pd1, 	LED_P, 	LED_d, 	LED_1,	   t_duration,		20)	\
    _(Pt2, 	LED_P, 	LED_t, 	LED_2,	   t_temperature,	620)	\
    _(Pd2, 	LED_P, 	LED_d, 	LED_2,	   t_duration,		30)	\
    _(Pt3, 	LED_P, 	LED_t, 	LED_3,	   t_temperature,	720)	\
    _(Pd3, 	LED_P, 	LED_d, 	LED_3,	   t_duration,		20)	\
    _(Pt4, 	LED_P, 	LED_t, 	LED_4,	   t_temperature,	780)	\
    _(Pd4, 	LED_P, 	LED_d, 	LED_4,	   t_duration,		5)	\
    _(Pt5, 	LED_P, 	LED_t, 	LED_5,	   t_temperature,	0)	\
    _(Pd5, 	LED_P, 	LED_d, 	LED_5,	   t_duration,		0)	\
    _(Pt6, 	LED_P, 	LED_t, 	LED_6,	   t_temperature,	0)	\
    _(Pd6, 	LED_P, 	LED_d, 	LED_6,	   t_duration,		0)	\
    _(Ht, 	LED_H, 	LED_t, 	LED_OFF,   t_temperature,	985)	\
    _(Hd, 	LED_H, 	LED_d, 	LED_OFF,   t_duration,		15)	\
    _(bt, 	LED_b, 	LED_t, 	LED_OFF,   t_temperature,     1050)	\
    _(bd, 	LED_b, 	LED_d, 	LED_OFF,   t_duration,		90)	\
    _(hd1, 	LED_h, 	LED_d, 	LED_1,	   t_duration,		60)	\
    _(hd2, 	LED_h, 	LED_d, 	LED_2,	   t_duration,		45)	\
    _(hd3, 	LED_h, 	LED_d, 	LED_3, 	   t_duration,		15)	\
    _(hd4, 	LED_h, 	LED_d, 	LED_4,	   t_duration,		5)	\
    _(CF, 	LED_C, 	LED_F, 	LED_OFF,   t_boolean,	        0)	\
    _(tc, 	LED_t, 	LED_c, 	LED_OFF,   t_tempdiff,		0)	\
    _(Hc, 	LED_H, 	LED_c, 	LED_OFF,   t_parameter,	        80)	\
    _(Ti, 	LED_t, 	LED_I, 	LED_OFF,   t_parameter,         280)	\
    _(Td, 	LED_t, 	LED_d, 	LED_OFF,   t_parameter,         20)	\
    _(Ts, 	LED_t, 	LED_S, 	LED_OFF,   t_parameter,         10)	\
    _(APF, 	LED_A, 	LED_P, 	LED_F,	   t_apflags,		511)	\
    _(PF, 	LED_P, 	LED_F, 	LED_OFF,   t_pumpflags,		6)	\
    _(cO, 	LED_c, 	LED_O, 	LED_OFF,   t_percentage,	80)	\
    _(cSP, 	LED_c, 	LED_S, 	LED_P, 	   t_temperature,       300)	\
    _(cP, 	LED_c, 	LED_P, 	LED_OFF,   t_boolean,		0)	\
    _(ASd, 	LED_A, 	LED_S, 	LED_d, 	   t_duration,		70) 
#else
//-----------------------------------------------------------------------------
// The data needed for the 'Set' menu. Using x macros to generate the needed
// data structures, all menu configuration can be kept in this single place.
//
// The values are:
// 	name, LED data 10, LED data 1, LED data 01, min value, max value, default value
//
// SP	Set setpoint	                                 -40 to 140°C or -40 to 250°F
// hy	Set hysteresis                                   0.0 to 5.0°C or 0.0 to 10.0°F
// hy2	Set hysteresis for 2nd temp probe	         0.0 to 25.0°C or 0.0 to 50.0°F
// tc	Set temperature correction	                 -5.0 to 5.0°C or -10.0 to 10.0°F
// tc2	Set temperature correction for 2nd temp probe    -5.0 to 5.0°C or -10.0 to 10.0°F
// SA	Setpoint alarm	                                 0 = off, -40 to 40°C or -80 to 80°F
// St	Set current profile step	                 0 to 8
// dh	Set current profile duration	                 0 to 999 hours
// cd	Set cooling delay	                         0 to 60 minutes
// hd	Set heating delay	                         0 to 60 minutes
// rP	Ramping	                                         0 = off, 1 = on
// CF	Set Celsius of Fahrenheit temperature display    0 = Celsius, 1 = Fahrenheit
// Pb2	Enable 2nd temp probe for thermostat control	 0 = off, 1 = on, 2 = probe controls compressor fan
// HrS	Control and Times in minutes or hours	         0 = minutes, 1 = hours
// Hc   Kc parameter for PID controller in %/°C          -9999..9999, >0: heating loop, <0: cooling loop 
// ti   Ti parameter for PID controller in seconds       0..9999 
// td   Td parameter for PID controller in seconds       0..9999 
// ts   Ts parameter for PID controller in seconds       0..9999, 0 = disable PID controller = thermostat control
// rn	Set run mode	                                 Pr0 to Pr5 and th (6)
//-----------------------------------------------------------------------------
#define MENU_DATA(_) \
	_(SP, 	LED_S, 	LED_P, 	LED_OFF, t_temperature,	200)	        \
	_(hy, 	LED_h, 	LED_y, 	LED_OFF, t_hyst_1,	5) 	        \
	_(hy2, 	LED_h, 	LED_y, 	LED_2, 	 t_hyst_2, 	100)	        \
	_(tc, 	LED_t, 	LED_c, 	LED_OFF, t_tempdiff,	0)		\
	_(tc2, 	LED_t, 	LED_c, 	LED_2, 	 t_tempdiff,	0)		\
	_(SA, 	LED_S, 	LED_A, 	LED_OFF, t_sp_alarm,	0)		\
	_(St, 	LED_S, 	LED_t, 	LED_OFF, t_step,	0)		\
	_(dh, 	LED_d, 	LED_h, 	LED_OFF, t_duration,	0)		\
	_(cd, 	LED_c, 	LED_d, 	LED_OFF, t_delay,	5)		\
	_(hd, 	LED_h, 	LED_d, 	LED_OFF, t_delay,	2)		\
	_(rP, 	LED_r, 	LED_P, 	LED_OFF, t_boolean,	1)		\
	_(CF, 	LED_C, 	LED_F, 	LED_OFF, t_boolean,	0)		\
	_(Pb2, 	LED_P, 	LED_b, 	LED_2, 	 t_parameter,	0)		\
	_(HrS, 	LED_H, 	LED_r, 	LED_S, 	 t_boolean,	1)		\
	_(Hc, 	LED_H, 	LED_c, 	LED_OFF, t_parameter,	80)		\
	_(Ti, 	LED_t, 	LED_I, 	LED_OFF, t_parameter,  280)		\
	_(Td, 	LED_t, 	LED_d, 	LED_OFF, t_parameter,   20)		\
	_(Ts, 	LED_t, 	LED_S, 	LED_OFF, t_parameter,    0)		\
	_(rn, 	LED_r, 	LED_n, 	LED_OFF, t_runmode,    NO_OF_PROFILES)
#endif
            
#define ENUM_VALUES(name,led10ch,led1ch,led01ch,type,default_value) name,
#define EEPROM_DEFAULTS(name,led10ch,led1ch,led01ch,type,default_value) default_value,

// Generate enum values for each entry int the set menu
enum menu_enum 
{
    MENU_DATA(ENUM_VALUES)
}; // menu_enum

//---------------------------------------------------------------------------
// Macros for calculation of EEPROM addresses
// One profile consists of several temp. time pairs and a final temperature
//---------------------------------------------------------------------------
#define EEADR_PROFILE_SETPOINT(profile, step)	(((profile)*PROFILE_SIZE) + ((step)<<1))
#define EEADR_PROFILE_DURATION(profile, step)	EEADR_PROFILE_SETPOINT(profile, step) + 1

// Find the parameter word address in EEPROM
#define EEADR_MENU_ITEM(name)		        (EEADR_MENU + (name))
// Help to convert menu item number and config item number to an EEPROM config address
#define MI_CI_TO_EEADR(mi, ci)	                ((mi)*PROFILE_SIZE + (ci))
#if defined(OVBSC)
    #define EEADR_MENU (0)
#else
    #define EEADR_MENU				EEADR_PROFILE_SETPOINT(NO_OF_PROFILES, 0)
    // Set POWER_ON after LAST parameter (in this case rn)!
    #define EEADR_POWER_ON				(EEADR_MENU_ITEM(rn) + 1)
#endif

// KEY_UP..KEY_S are the hardware bits on PORTC
#define KEY_UP   (0x40)
#define KEY_DOWN (0x20)
#define KEY_PWR  (0x10)
#define KEY_S    (0x08)
#define BUTTONS (KEY_UP | KEY_DOWN | KEY_PWR | KEY_S)

// These are the bit-definitions in _buttons
#define BTN_UP	 (0x88)
#define BTN_DOWN (0x44)
#define BTN_PWR	 (0x22)
#define BTN_S	 (0x11)

// Helpful defines to handle buttons
#define BTN_IDLE(btn)		  ((_buttons & (btn)) == 0x00)
#define BTN_PRESSED(btn)	  ((_buttons & (btn)) == ((btn) & 0x0f))
#define BTN_HELD(btn)		  ((_buttons & (btn)) == (btn))
#define BTN_RELEASED(btn)	  ((_buttons & (btn)) == ((btn) & 0xf0))
#define BTN_HELD_OR_RELEASED(btn) ((_buttons & (btn) & 0xf0))

// Defines for prx_led() function
#define LEDS_RUN_MODE (0)
#define LEDS_MENU     (1)

// Defines for value_to_led() function
#define LEDS_INT      (0)
#define LEDS_TEMP     (1)
#define LEDS_PERC     (2)

// Timers for state transition diagram. One-tick = 100 msec.
#define TMR_POWERDOWN          (30)
#define TMR_SHOW_PROFILE_ITEM  (15)
#define TMR_NO_KEY_TIMEOUT    (150)
#define TMR_KEY_ACC            (20)

#if defined(OVBSC)
enum prg_state_enum 
{
	PRG_OFF = 0,
	PRG_WAIT_STRIKE,
	PRG_STRIKE,
	PRG_STRIKE_WAIT_ALARM,
	PRG_INIT_MASH_STEP,
	PRG_MASH,
	PRG_WAIT_BOIL_UP_ALARM,
	PRG_INIT_BOIL_UP,
	PRG_HOTBREAK,
	PRG_BOIL
    };
#endif 
        
/* Menu struct */
struct s_menu 
{
   uint8_t led_c_10;
   uint8_t led_c_1;
   uint8_t led_c_01;
   uint8_t type;
}; // s_menu

// Menu struct data generator
#define TO_STRUCT(name, led10ch, led1ch, led01ch, type, default_value) \
        { led10ch, led1ch, led01ch, type },

// States for menu_fsm()
enum menu_states 
{
    MENU_IDLE = 0,            // Default menu
    MENU_SHOW_VERSION,        // Show version number of firmware
    MENU_SHOW_STATE_UP,       // Show Setpoint value
    MENU_SHOW_STATE_DOWN,     // Show profile number or th
    MENU_SHOW_STATE_DOWN_2,   // Show current step number within profile
    MENU_SHOW_STATE_DOWN_3,   // Show current duration of profile
    MENU_POWER_DOWN_WAIT,     // Power-down mode, display is off
    MENU_SHOW_MENU_ITEM,      // Show name of menu-item / profile
    MENU_SET_MENU_ITEM,       // Navigate through menu-items / profile
    MENU_SHOW_CONFIG_ITEM,    // Show name of menu-item / profile-item
    MENU_SET_CONFIG_ITEM,     // Change menu-item / profile-item
    MENU_SHOW_CONFIG_VALUE,   // Show value of menu-item / profile-item
    MENU_SET_CONFIG_VALUE,    // Change value of menu-item / profile-item
}; // menu_states

// Function Prototypes
uint16_t divu10(uint16_t n); 
void     prx_to_led(uint8_t run_mode, uint8_t is_menu);
void     value_to_led(int value, uint8_t mode); 
void     update_profile(void);
int16_t  range(int16_t x, int16_t min, int16_t max);
int16_t  check_config_value(int16_t config_value, uint8_t eeadr);
void     read_buttons(void);
void     menu_fsm(void);
void     temperature_control(void);
void     pid_control(bool pid_run);
void     ovbsc_fsm(void); // in ovbsc.c
#endif