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

// Default values
#define DEFAULT_SP	  (200)
#define DEFAULT_hy	   (50)
#define DEFAULT_hy2	  (100)

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

#define MENU_TYPE_IS_TEMPERATURE(x) 	((x) <= t_sp_alarm)

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
// Pb2	Enable 2nd temp probe for thermostat control	 0 = off, 1 = on
// HrS	Control and Times in minutes or hours	         0 = minutes, 1 = hours
// Hc   Kc parameter for PID controller in %/°C          0..9999 
// ti   Ti parameter for PID controller in seconds       0..9999 
// td   Td parameter for PID controller in seconds       0..9999 
// ts   Ts parameter for PID controller in seconds       0..100, 0=disable PID controller = thermostat control
// rn	Set run mode	                                 Pr0 to Pr5 and th (6)
//-----------------------------------------------------------------------------
#define MENU_DATA(_) \
	_(SP, 	LED_S, 	LED_P, 	LED_OFF, t_temperature,	DEFAULT_SP)	\
	_(hy, 	LED_h, 	LED_y, 	LED_OFF, t_hyst_1,	DEFAULT_hy) 	\
	_(hy2, 	LED_h, 	LED_y, 	LED_2, 	 t_hyst_2, 	DEFAULT_hy2)	\
	_(tc, 	LED_t, 	LED_c, 	LED_OFF, t_tempdiff,	3)		\
	_(tc2, 	LED_t, 	LED_c, 	LED_2, 	 t_tempdiff,	-2)		\
	_(SA, 	LED_S, 	LED_A, 	LED_OFF, t_sp_alarm,	0)		\
	_(St, 	LED_S, 	LED_t, 	LED_OFF, t_step,	0)		\
	_(dh, 	LED_d, 	LED_h, 	LED_OFF, t_duration,	0)		\
	_(cd, 	LED_c, 	LED_d, 	LED_OFF, t_delay,	5)		\
	_(hd, 	LED_h, 	LED_d, 	LED_OFF, t_delay,	2)		\
	_(rP, 	LED_r, 	LED_P, 	LED_OFF, t_boolean,	0)		\
	_(CF, 	LED_C, 	LED_F, 	LED_OFF, t_boolean,	0)		\
	_(Pb2, 	LED_P, 	LED_b, 	LED_2, 	 t_boolean,	0)		\
	_(HrS, 	LED_H, 	LED_r, 	LED_S, 	 t_boolean,	1)		\
	_(Hc, 	LED_H, 	LED_c, 	LED_OFF, t_parameter,	80)		\
	_(Ti, 	LED_t, 	LED_I, 	LED_OFF, t_parameter,  280)		\
	_(Td, 	LED_t, 	LED_d, 	LED_OFF, t_parameter,   20)		\
	_(Ts, 	LED_t, 	LED_S, 	LED_OFF, t_parameter,    0)		\
	_(rn, 	LED_r, 	LED_n, 	LED_OFF, t_runmode,	6)

#define ENUM_VALUES(name,led10ch,led1ch,led01ch,type,default_value) name,
#define EEPROM_DEFAULTS(name,led10ch,led1ch,led01ch,type,default_value) default_value,

// Generate enum values for each entry int the set menu
enum menu_enum 
{
    MENU_DATA(ENUM_VALUES)
}; // menu_enum

//---------------------------------------------------------------------------
// Defines for EEPROM config addresses
// One profile consists of several temp. time pairs and a final temperature
// When changing NO_OF_PROFILES and/or NO_OF_TT_PAIRS, DO NOT FORGET (!!!) to
// change eedata[] in stc1000p_lib.c
//---------------------------------------------------------------------------
#define NO_OF_PROFILES	 (4)
#define NO_OF_TT_PAIRS   (5)
#define PROFILE_SIZE     (2*(NO_OF_TT_PAIRS)+1)
#define MENU_ITEM_NO	 NO_OF_PROFILES
#define THERMOSTAT_MODE  NO_OF_PROFILES

#define EEADR_PROFILE_SETPOINT(profile, step)	(((profile)*PROFILE_SIZE) + ((step)<<1))
#define EEADR_PROFILE_DURATION(profile, step)	EEADR_PROFILE_SETPOINT(profile, step) + 1
#define EEADR_MENU				EEADR_PROFILE_SETPOINT(NO_OF_PROFILES, 0)
// Find the parameter word address in EEPROM
#define EEADR_MENU_ITEM(name)		        (EEADR_MENU + (name))
// Help to convert menu item number and config item number to an EEPROM config address
#define MI_CI_TO_EEADR(mi, ci)	                ((mi)*PROFILE_SIZE + (ci))
// Set POWER_ON after LAST parameter (in this case rn)!
#define EEADR_POWER_ON				(EEADR_MENU_ITEM(rn) + 1)

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

// Timers for state transition diagram. One-tick = 100 msec.
#define TMR_POWERDOWN          (30)
#define TMR_SHOW_PROFILE_ITEM  (15)
#define TMR_NO_KEY_TIMEOUT    (150)

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
    MENU_SHOW_CONFIG_ITEM,    // Show value of menu-item / profile-item
    MENU_SET_CONFIG_ITEM,     // Change value of menu-item / profile-item
    MENU_SHOW_CONFIG_VALUE,   // 
    MENU_SET_CONFIG_VALUE,    // 
}; // menu_states

// Function Prototypes
uint16_t divu10(uint16_t n); 
void     prx_to_led(uint8_t run_mode, uint8_t is_menu);
void     value_to_led(int value, uint8_t decimal); 
void     update_profile(void);
int16_t  range(int16_t x, int16_t min, int16_t max);
int16_t  check_config_value(int16_t config_value, uint8_t eeadr);
void     read_buttons(void);
void     menu_fsm(void);
void     temperature_control(void);
void     pid_control(void);
#endif