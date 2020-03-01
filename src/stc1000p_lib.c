/*==================================================================
  File Name    : stc1000p_lib.c
  Author       : Mats Staffansson / Emile
  ------------------------------------------------------------------
  Purpose : This files contains the relevant functions for the menu,
            thermostat control and other functions needed for th
            STC1000 thermostat hardware WR-032.

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
#include "stc1000p_lib.h"

// LED character lookup table (0-9)
const uint8_t led_lookup[] = {LED_0,LED_1,LED_2,LED_3,LED_4,LED_5,LED_6,LED_7,LED_8,LED_9};

//----------------------------------------------------------------------------
// These values are stored directly into EEPROM
// PR0: Pilsner Urquell profile (21 d @ 11°, 3 d @ 16°, then 6°) 
// PR1: Weizen profile (3d @ 19°, 3d @ 20°, 17 d @ 21°, then 6°)
// PR2: Tripel / Wyeast 1214 Belgian Abbey (3 d @ 20°, 3 d @ 21°, 17 d @ 22°, then 6°)
// PR3: IPA / SafAle US-05 yeast (3.5 wk @ 18°, then 6°)
// PR4: 3.5 wk @ 19°, then 6°
// PR5: 3.5 wk @ 20°, then 6°
//----------------------------------------------------------------------------
__root __eeprom const int eedata[] = 
{
#ifdef __IOSTM8S103F3_H__
    // STM8S103F3 with 640 bytes EEPROM
   110,504, 110,  6, 160, 72, 160, 12,  60,   0,   0,  0,  0, 0, 0, 0, 0, 0, 0, // Pr0 (SP0, dh0, ..., dh8, SP9)
   190, 72, 190,  6, 200, 72, 200,  6, 210, 408, 210, 12, 60, 0, 0, 0, 0, 0, 0, // Pr1 (SP0, dh0, ..., dh8, SP9)
   200, 72, 200,  6, 210, 72, 210,  6, 220, 408, 220, 12, 60, 0, 0, 0, 0, 0, 0, // Pr2 (SP0, dh0, ..., dh8, SP9)
   180,564, 180, 12,  60,  0,   0,  0,   0,   0,   0,  0,  0, 0, 0, 0, 0, 0, 0, // Pr3 (SP0, dh0, ..., dh8, SP9)
   190,564, 190, 12,  60,  0,   0,  0,   0,   0,   0,  0,  0, 0, 0, 0, 0, 0, 0, // Pr4 (SP0, dh0, ..., dh8, SP9)
   200,564, 200, 12,  60,  0,   0,  0,   0,   0,   0,  0,  0, 0, 0, 0, 0, 0, 0, // Pr5 (SP0, dh0, ..., dh8, SP9)
#else
    // STM8S003F3 with 128 bytes EEPROM (stock STC1000 IC)
   110,504, 110,  6, 160, 72, 160, 12,  60,   0,   0, // Pr0 (SP0, dh0, ..., dh4, SP5)
   190, 72, 190, 12, 210,504, 210, 12,  60,   0,   0, // Pr1 (SP0, dh0, ..., dh4, SP5)
   200, 72, 200, 12, 220,504, 220, 12,  60,   0,   0, // Pr2 (SP0, dh0, ..., dh4, SP5)
   180,564, 180, 12,  60,  0,   0,  0,   0,   0,   0, // Pr3 (SP0, dh0, ..., dh4, SP5)
#endif
   MENU_DATA(EEPROM_DEFAULTS) 1 // Last one is for POWER_ON
}; // eedata[]

// Global variables to hold LED data (for multiplexing purposes)
uint8_t led_e = {0x00};         // value of extra LEDs
uint8_t led_10, led_1, led_01;  // values of 10s, 1s and 0.1s

uint16_t cooling_delay = 60;    // Initial cooling delay
uint16_t heating_delay = 60;    // Initial heating delay
uint8_t  menustate     = MENU_IDLE; // Current STD state number for menu_fsm()
bool     menu_is_idle  = true;  // No menu active within STD
bool     pwr_on        = true;  // True = power ON, False = power OFF
bool     fahrenheit    = false; // false = Celsius, true = Fahrenheit
bool     minutes       = false; // timing control: false = hours, true = minutes
uint8_t  menu_item     = 0;     // Current menu-item: [0..NO_OF_PROFILES]
uint8_t  config_item   = 0;     // Current index within profile or parameter menu
uint8_t  m_countdown   = 0;     // Timer used within menu_fsm()
uint8_t  _buttons      = 0;     // Current and previous value of button states
int16_t  config_value;          // Current value of menu-item
int8_t   key_held_tmr;          // Timer for value change acceleration
uint8_t  sensor2_selected = 0;  // DOWN button pressed < 3 sec. shows 2nd temperature / pid_output
int16_t  setpoint;              // local copy of SP variable
uint16_t curr_dur = 0;          // local counter for temperature duration
int16_t  pid_out  = 0;          // Output from PID controller in E-1 %
int16_t  hysteresis;            // th-mode: hysteresis for temp probe ; pid-mode: lower hyst. limit in E-1 %
int16_t  hysteresis2;           // th-mode: hysteresis for 2nd temp probe ; pid-mode: upper hyst. limit in E-1 %

// External variables, defined in other files
extern uint8_t  probe2;    // cached flag indicating whether 2nd probe is active
extern int16_t  temp_ntc1; // The temperature in E-1 °C from NTC probe 1
extern int16_t  temp_ntc2; // The temperature in E-1 °C from NTC probe 2
extern int16_t  kc;        // Parameter value for Kc value in %/°C
extern uint16_t ti;        // Parameter value for I action in seconds
extern uint16_t td;        // Parameter value for D action in seconds
extern uint8_t  ts;        // Parameter value for sample time [sec.]

// This contains the definition of the menu-items for the parameters menu
const struct s_menu menu[] = 
{
    MENU_DATA(TO_STRUCT)
}; // menu[]
#define MENU_SIZE (sizeof(menu)/sizeof(menu[0]))

/*-----------------------------------------------------------------------------
  Purpose  : This routine does a divide by 10 using only shifts
  Variables: n: the number to divide by 10
  Returns  : the result
  ---------------------------------------------------------------------------*/
uint16_t divu10(uint16_t n) 
{
  uint16_t q, r;

  q = (n >> 1) + (n >> 2);       // 1/2 + 1/4 = 3/4
  q = q + (q >> 4);              // 3/4 + 3/64 = 51/64
  q = q + (q >> 8);              // 51/64 + 51/(16384) = 13107/16384
  q = q >> 3;                    // 13107 / 131072
  r = n - ((q << 3) + (q << 1)); // 1 - (13107/16384 + 13107/65536) = 1/65536
  return q + ((r + 6) >> 4);     // 13107/131072 + 1/1048576 = 104857 / 1048576  
} // divu10()

/*-----------------------------------------------------------------------------
  Purpose  : This routine is called by menu_fsm() to show the name of the
             menu-item. This can be either one of the Profiles (Pr0, Pr1, ...),
             the text 'SET' (when in the parameter menu) of the text 'th' when
             in thermostat mode.
  Variables: run_mode: [0..NR_OF_PROFILES]
             is_menu : 0=thermostat mode, 1=within a menu         
  Returns  : -
  ---------------------------------------------------------------------------*/
void prx_to_led(uint8_t run_mode, uint8_t is_menu)
{
    // clear negative, deg, c and point indicators
    led_e &= ~(LED_NEG | LED_DEGR | LED_CELS | LED_POINT);  
    if(run_mode < NO_OF_PROFILES)
    {   // one of the profiles
	led_10 = LED_P;
	led_1  = LED_r;
	led_01 = led_lookup[run_mode];
    } else { // parameter menu
	if (is_menu)
        {   // within menu
	    led_10 = LED_S;
	    led_1  = LED_E;
	    led_01 = LED_t;
	} else if (ts == 0) 
        { // Thermostat Mode
	    led_10 = LED_t; 
	    led_1  = LED_h;
	    led_01 = LED_OFF;
	} // else if
        else 
        {   // PID controller mode
	    led_10 = LED_P; 
	    led_1  = LED_I;
	    led_01 = LED_d;
        } // else
    } // else
} // prx_to_led()

/*-----------------------------------------------------------------------------
  Purpose  : This routine is called by menu_fsm() to show the value of a
             temperature or a non-temperature value.
             In case of a temperature, a decimal point is displayed (for 0.1).
             In case of a non-temperature value, only the value itself is shown.
  Variables: value: the value to display
             mode : LEDS_INT : display as integer
                    LEDS_TEMP: display temperature as xx.1
                    LEDS_PERC: display percentage as xx.1
  Returns  : -
  ---------------------------------------------------------------------------*/
void value_to_led(int value, uint8_t mode) 
{
	uint8_t i;
        uint8_t decimal = 0;

	led_e &= ~(LED_NEG | LED_DEGR | LED_CELS); // clear negative, ° and Celsius symbols
        if (value < 0) 
        {  // Handle negative values
           led_e |= LED_NEG;
	   value  = -value;
	} // if

        if (mode == LEDS_TEMP)
        {  // this is a temperature in E-1 °C
	   led_e |= LED_DEGR;
           if (!fahrenheit) led_e |= LED_CELS; // Celsius symbol
           decimal = 1;
	} // if
        else if (mode == LEDS_PERC)
        {  // this is a percentage in E-1 %
            decimal = 1;
        } // else if

	// If temperature >= 100 °C or percentage is 100 %, we must loose a decimal...
	if (value >= 1000) 
        {
	   value   = divu10((uint16_t) value);
	   decimal = 0; // no decimal point in this case
	} // if

	// Convert value to BCD and set LED outputs
	if (value >= 100)
        {
	   for (i = 0; value >= 100; i++)
           {
	      value -= 100;
	   } // for
	   led_10 = led_lookup[i & 0x0f];
	} else {
	   led_10 = LED_OFF; // Turn off led if zero (loose leading zeros)
	} // else
	if (value >= 10 || decimal || led_10 != LED_OFF)
        {  // If decimal, we want 1 leading zero
	   for (i = 0; value >= 10; i++)
           {
	      value -= 10;
	   } // for
	   led_1 = led_lookup[i];
	   if (decimal)
           {
	      led_1 |= LED_DECIMAL;
	   } // if
	} else {
	   led_1 = LED_OFF; // Turn off led if zero (loose leading zeros)
	} // else
	led_01 = led_lookup[(uint8_t)value];
} // value_to_led()

/*-----------------------------------------------------------------------------
  Purpose  : This task updates the current running profile. A profile consists
             of several temperature-time pairs. When a time-out occurs, the
             next temperature-time pair within that profile is selected.
             Updates are stored in the EEPROM configuration.
             It is called once every hour on the hour or every minute.
  Variables: minutes: timing control: false = hours, true = minutes
  Returns  : -
  ---------------------------------------------------------------------------*/
void update_profile(void)
{
  uint8_t  profile_no = eeprom_read_config(EEADR_MENU_ITEM(rn));
  uint8_t  curr_step;            // Current step number within a profile
  uint8_t  profile_step_eeaddr;  // Address index in eeprom for step nr in profile
  uint16_t profile_step_dur;     // Duration of current step
  int16_t  profile_next_step_sp; // Setpoint value of next step in profile
  int16_t  profile_step_sp;      // Setpoint value of current step in profile
  uint16_t t;
  int32_t  sp;
  uint8_t  i;

  // Running profile?
  if (profile_no < THERMOSTAT_MODE) 
  {
      curr_step = eeprom_read_config(EEADR_MENU_ITEM(St));
      if (minutes) // is timing-control in minutes?
           curr_dur++;
      else curr_dur = eeprom_read_config(EEADR_MENU_ITEM(dh)) + 1;

      // Sanity check
      if(curr_step > NO_OF_TT_PAIRS-1) curr_step = NO_OF_TT_PAIRS - 1;

      profile_step_eeaddr  = EEADR_PROFILE_SETPOINT(profile_no, curr_step);
      profile_step_dur     = eeprom_read_config(profile_step_eeaddr + 1);
      profile_next_step_sp = eeprom_read_config(profile_step_eeaddr + 2);

      // Reached end of step?
      if (curr_dur >= profile_step_dur) 
      {   // Update setpoint with value from next step
	  if (minutes) setpoint = profile_next_step_sp;
	  eeprom_write_config(EEADR_MENU_ITEM(SP), profile_next_step_sp);
	  // Is this the last step (next step is number 9 or next step duration is 0)?
	  if ((curr_step == NO_OF_TT_PAIRS-1) || eeprom_read_config(profile_step_eeaddr + 3) == 0) 
          {   // Switch to thermostat mode.
              eeprom_write_config(EEADR_MENU_ITEM(rn), THERMOSTAT_MODE);
              return; // Fastest way out...
	  } // if
          curr_dur = 0; // Reset duration
	  curr_step++;  // Update step
	  eeprom_write_config(EEADR_MENU_ITEM(St), curr_step);
      } // if
      else if (eeprom_read_config(EEADR_MENU_ITEM(rP))) 
      {  // Is ramping enabled?
         profile_step_sp = eeprom_read_config(profile_step_eeaddr);
	 t  = curr_dur << 6;
	 sp = 32;
	 for (i = 0; i < 64; i++) 
         {   // Linear interpolation of new setpoint (64 substeps)
	     if (t >= profile_step_dur) 
             {
	        t  -= profile_step_dur;
		sp += profile_next_step_sp;
	     } // if
             else 
             {
		sp += profile_step_sp;
	     } // else
	 } // for
	 sp >>= 6;
	 // Update setpoint
	 if (minutes) // is timing-control in minutes?
              setpoint = sp;
         else eeprom_write_config(EEADR_MENU_ITEM(SP), sp);
      } // else if
      if (!minutes)
      {   // Update duration
          eeprom_write_config(EEADR_MENU_ITEM(dh), curr_dur);
      } // if
   } // if
} // update_profile()

/*-----------------------------------------------------------------------------
  Purpose  : This routine checks if a value is within a minimum and maximul value.
             If the value is larger than the maximum, the minimum value is 
             returned (roll-over). If the value is smaller than the minimum, 
             the maximum value is returned (roll-over).
  Variables: x  : the value to check
             min: the minimum allowed value         
             max: the maximum allowed value         
  Returns  : the value itself, or the roll-over value in case of a max./min.
  ---------------------------------------------------------------------------*/
int16_t range(int16_t x, int16_t min, int16_t max)
{
    if (x > max) return min;
    if (x < min) return max;
    return x;
} // range()

/*-----------------------------------------------------------------------------
  Purpose  : This routine checks a parameter value and constrains it to a 
             maximum/minimum value.
  Variables: config_value : the value to check for
             eeadr        : the number of a 16-bit variable within the EEPROM.         
  Returns  : the value itself, or the roll-over value in case of a max./min.
  ---------------------------------------------------------------------------*/
int16_t check_config_value(int16_t config_value, uint8_t eeadr)
{
    int16_t t_min = 0, t_max = 999;
    uint8_t type;
    
    if (eeadr < EEADR_MENU)
    {   // One of the Profiles
	while (eeadr >= PROFILE_SIZE)
        {   // Find the eeprom address within a profile
            eeadr -= PROFILE_SIZE;
	} // while
	if (!(eeadr & 0x1))
        {   // Only constrain a temperature
	    t_min = (fahrenheit ? TEMP_MIN_F : TEMP_MIN_C);
	    t_max = (fahrenheit ? TEMP_MAX_F : TEMP_MAX_C);
	} // if
    } else { // Parameter menu
        type = menu[eeadr - EEADR_MENU].type;
	if (type == t_temperature)
        {
	    t_min = (fahrenheit ? TEMP_MIN_F : TEMP_MIN_C);
	    t_max = (fahrenheit ? TEMP_MAX_F : TEMP_MAX_C);
	} else if (type == t_tempdiff)
        {   // the temperature correction variables
	    t_min = (fahrenheit ? TEMP_CORR_MIN_F : TEMP_CORR_MIN_C);
	    t_max = (fahrenheit ? TEMP_CORR_MAX_F : TEMP_CORR_MAX_C);
	} else if (type == t_parameter)
	    {
		t_max = 9999;
                if (eeadr == EEADR_MENU_ITEM(Hc)) 
                {   // Kc parameter for PID: enable heating and cooling-loop
                    t_min = -9999; 
                } // if
	} else if (type == t_boolean)
        {   // the control variables
	    t_max = 1;
	} else if (type == t_hyst_1)
        {
	    t_max = (fahrenheit ? TEMP_HYST_1_MAX_F : TEMP_HYST_1_MAX_C);
	} else if (type == t_hyst_2)
        {
	    t_max = (fahrenheit ? TEMP_HYST_2_MAX_F : TEMP_HYST_2_MAX_C);
	} else if (type == t_sp_alarm)
        {
	    t_min = (fahrenheit ? SP_ALARM_MIN_F : SP_ALARM_MIN_C);
	    t_max = (fahrenheit ? SP_ALARM_MAX_F : SP_ALARM_MAX_C);
	} else if(type == t_step)
        {
	    t_max = NO_OF_TT_PAIRS;
	} else if (type == t_delay)
        {
	    t_max = 60;
	} else if (type == t_runmode)
        {
	    t_max = NO_OF_PROFILES;
	} // else if
    } // else
    return range(config_value, t_min, t_max);
} // check_config_value()

/*-----------------------------------------------------------------------------
  Purpose  : This routine reads the values of the buttons and returns the
             result. Routine should be called every 100 msec.
             The result is returned in the global variable _buttons. 
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void read_buttons(void)
{
    uint8_t b;
    
    // Save registers that interferes with LED's and disable common-cathodes
    __disable_interrupt();     // Disable interrups while reading buttons
    save_display_state();      // Save current state of 7-segment displays 

    PC_DDR &= ~BUTTONS;        // Set PC6..PC3 as inputs
    PC_CR1 |=  BUTTONS;        // Enable pull-ups for PC6..PC3 (Rpu is approx 45k)
    for (b = 0; b < 10; b++) ; // give port a bit of time
    _buttons <<= 4;            // make room for new values of buttons
    b          = ((PC_IDR & BUTTONS) >> 3); // 3..0: UP, DOWN, PWR, S
    b          = (b ^ 0x0F) & 0x0F;         // Invert buttons (0 = pressed)
    _buttons  |= b;            // add buttons
    PC_DDR    |= BUTTONS;      // Set PC6..PC3 to outputs again
    PC_CR1    |= BUTTONS;      // Set PC6..PC3 to Push-Pull again
        
    restore_display_state();   // Restore state of 7-segment displays
    __enable_interrupt();      // Re-enable Interrupts
} // read_buttons()

/*-----------------------------------------------------------------------------
  Purpose  : This routine is the Finite State Machine (FSM) that controls the
             menu for the 7-segment displays and should be called every 100 msec.
             It used a couple of global variables.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void menu_fsm(void)
{
   uint8_t run_mode, adr, type, eeadr_sp;
   
   if (m_countdown) m_countdown--; // countdown counter
    
   switch (menustate)
   {
       //--------------------------------------------------------------------         
       case MENU_IDLE:
	    if(BTN_PRESSED(BTN_PWR))
            {
                m_countdown = TMR_POWERDOWN;
                menustate   = MENU_POWER_DOWN_WAIT;
	    } else if(_buttons && eeprom_read_config(EEADR_POWER_ON))
            {
                if (BTN_PRESSED(BTN_UP | BTN_DOWN)) 
                {   // UP and DOWN button pressed
                    menustate = MENU_SHOW_VERSION;
                } else if(BTN_PRESSED(BTN_UP))
                {   // UP button pressed
                    menustate = MENU_SHOW_STATE_UP;
                } else if(BTN_PRESSED(BTN_DOWN))
                {   // DOWN button pressed
                    m_countdown = TMR_SHOW_PROFILE_ITEM;
                    menustate   = MENU_SHOW_STATE_DOWN;
                } else if(BTN_RELEASED(BTN_S))
                {   // S button pressed
                    menustate = MENU_SHOW_MENU_ITEM;
                } // else if
	    } // else
	    break;
       //--------------------------------------------------------------------         
       case MENU_POWER_DOWN_WAIT:
            if (m_countdown == 0)
            {
                pwr_on = eeprom_read_config(EEADR_POWER_ON);
                pwr_on = !pwr_on;
                eeprom_write_config(EEADR_POWER_ON, pwr_on);
                if (pwr_on)
                {
                    heating_delay = 60; // 60 sec.
                    cooling_delay = 60; // 60 sec.
                } // else
                menustate = MENU_IDLE;
            } else if(!BTN_HELD(BTN_PWR))
            {   // 0 = temp_ntc1, 1 = temp_ntc2, 2 = pid-output
                if (++sensor2_selected > 1 + (ts > 0)) sensor2_selected = 0;
                menustate = MENU_IDLE;
            } // else if
            break; // MENU_POWER_DOWN_WAIT
       //--------------------------------------------------------------------         
       case MENU_SHOW_VERSION: // Show STC1000p version number
            value_to_led(STC1000P_VERSION,LEDS_INT);
	    led_10 |= LED_DECIMAL;
            led_1  |= LED_DECIMAL;
	    led_e  &= ~(LED_DEGR | LED_CELS); // clear ° and Celsius symbols
	    if(!BTN_HELD(BTN_UP | BTN_DOWN)) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_UP: // Show setpoint value
	    if (minutes) // is timing-control in minutes?
                 value_to_led(setpoint,LEDS_TEMP);
	    else value_to_led(eeprom_read_config(EEADR_MENU_ITEM(SP)),LEDS_TEMP);
	    if(!BTN_HELD(BTN_UP)) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_DOWN: // Show Profile-number
	    run_mode = eeprom_read_config(EEADR_MENU_ITEM(rn));
            prx_to_led(run_mode,LEDS_RUN_MODE);
            if ((run_mode < THERMOSTAT_MODE) && (m_countdown == 0))
            {
                m_countdown = TMR_SHOW_PROFILE_ITEM;
                menustate   = MENU_SHOW_STATE_DOWN_2;
            } // if
	    if(!BTN_HELD(BTN_DOWN)) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_DOWN_2: // Show current step number within profile
	    value_to_led(eeprom_read_config(EEADR_MENU_ITEM(St)),LEDS_INT);
	    if(m_countdown == 0)
            {
                m_countdown = TMR_SHOW_PROFILE_ITEM;
                menustate   = MENU_SHOW_STATE_DOWN_3;
	    }
	    if(!BTN_HELD(BTN_DOWN)) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_DOWN_3: // Show current duration of running profile
            if (minutes) // is timing-control in minutes?
                 value_to_led(curr_dur,LEDS_INT);
            else value_to_led(eeprom_read_config(EEADR_MENU_ITEM(dh)),LEDS_INT);
            if(m_countdown == 0)
            {   // Time-Out
                m_countdown = TMR_SHOW_PROFILE_ITEM;
                menustate   = MENU_SHOW_STATE_DOWN;
            } // if
            if(!BTN_HELD(BTN_DOWN))
            {   // Down button is released again
                menustate = MENU_IDLE;
            } // if
            break; // MENU_SHOW_STATE_DOWN_3
       //--------------------------------------------------------------------         
       case MENU_SHOW_MENU_ITEM: // S-button was pressed
            prx_to_led(menu_item, LEDS_MENU);
            m_countdown = TMR_NO_KEY_TIMEOUT;
            menustate   = MENU_SET_MENU_ITEM;
            break; // MENU_SHOW_MENU_ITEM
       //--------------------------------------------------------------------         
       case MENU_SET_MENU_ITEM:
            if(m_countdown == 0 || BTN_RELEASED(BTN_PWR))
            {   // On Time-out of S-button released, go back
                menustate = MENU_IDLE;
            } else if(BTN_RELEASED(BTN_UP))
            {
                if(++menu_item > MENU_ITEM_NO) menu_item = 0;
                menustate = MENU_SHOW_MENU_ITEM;
            } else if(BTN_RELEASED(BTN_DOWN))
            {
                if(--menu_item > MENU_ITEM_NO) menu_item = MENU_ITEM_NO;
                menustate = MENU_SHOW_MENU_ITEM;
            } else if(BTN_RELEASED(BTN_S))
            {   // only go to next state if S-button is released
                config_item = 0;
                menustate   = MENU_SHOW_CONFIG_ITEM;
            } // else if
            break; // MENU_SET_MENU_ITEM
       //--------------------------------------------------------------------         
       case MENU_SHOW_CONFIG_ITEM: // S-button is released
	    led_e &= ~(LED_NEG | LED_DEGR | LED_CELS); // clear negative, ° and Celsius symbols

	    if(menu_item < MENU_ITEM_NO)
            {
                if(config_item & 0x1) 
                {   
                    led_10 = LED_d; // duration: 2nd value of a profile-step
                    led_1  = LED_h;
                } else {
                    led_10 = LED_S; // setpoint: 1st value of a profile-step
                    led_1  = LED_P;
                } // else
                led_01 = led_lookup[(config_item >> 1)];
	    } else /* if (menu_item == 6) */
            {   // show parameter name
                led_10 = menu[config_item].led_c_10;
                led_1  = menu[config_item].led_c_1;
                led_01 = menu[config_item].led_c_01;
	    } // else
	    m_countdown = TMR_NO_KEY_TIMEOUT;
	    menustate   = MENU_SET_CONFIG_ITEM;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SET_CONFIG_ITEM:
	    if(m_countdown == 0)
            {   // Timeout, go back to idle state
                menustate = MENU_IDLE;
	    } else if(BTN_RELEASED(BTN_PWR))
            {   // Go back
                menustate = MENU_SHOW_MENU_ITEM;
            } else if(BTN_RELEASED(BTN_UP))
            {
                config_item++;
                if(menu_item < MENU_ITEM_NO)
                {
                    if(config_item >= PROFILE_SIZE)
                    {
                        config_item = 0;
                    } // if
                } else {
                    if(config_item >= MENU_SIZE)
                    {
                        config_item = 0;
                    }
                    /* Jump to exit code shared with BTN_DOWN case */
                    /* GOTO's are frowned upon, but avoiding code duplication saves precious code space */
                    goto chk_skip_menu_item;
                } // else
                menustate = MENU_SHOW_CONFIG_ITEM;
            } else if(BTN_RELEASED(BTN_DOWN))
            {
                config_item--;
                if(menu_item < MENU_ITEM_NO)
                {   // One of the profiles
                    if(config_item >= PROFILE_SIZE)
                    {
                        config_item = PROFILE_SIZE-1;
                    } // if
                } else { // Menu with parameters
                    if(config_item > MENU_SIZE-1)
                    {
                        config_item = MENU_SIZE-1;
                    } // if
            chk_skip_menu_item: // label for goto
                    if (!minutes && ((uint8_t)eeprom_read_config(EEADR_MENU_ITEM(rn)) >= THERMOSTAT_MODE))
                    {
                        if (config_item == St)
                        {   // Skip current profile-step and duration
                            config_item += 2;
                        }else if (config_item == dh)
                        {   // Skip current profile-step and duration
                            config_item -= 2;
                        } // else if
                    } // if
                } // else
                menustate = MENU_SHOW_CONFIG_ITEM;
            } else if(BTN_RELEASED(BTN_S))
            {   // S-button is released again
                adr          = MI_CI_TO_EEADR(menu_item, config_item);
                config_value = eeprom_read_config(adr);
                config_value = check_config_value(config_value, adr);
                m_countdown  = TMR_NO_KEY_TIMEOUT;
                menustate    = MENU_SHOW_CONFIG_VALUE;
            } // else if
       break; // MENU_SET_CONFIG_ITEM
       //--------------------------------------------------------------------         
       case MENU_SHOW_CONFIG_VALUE:
            if(menu_item < MENU_ITEM_NO)
            {   // Display duration as integer, temperature in 0.1
                value_to_led(config_value, (config_item & 0x1) ? LEDS_INT : LEDS_TEMP);
            } else 
            {   // menu_item == MENU_ITEM_NO
                type = menu[config_item].type;
                if(MENU_TYPE_IS_TEMPERATURE(type))
                {   // temperature, display in 0.1
                    value_to_led(config_value,LEDS_TEMP);
                } else if (type == t_runmode)
                {
                    prx_to_led(config_value,LEDS_RUN_MODE);
                } else { // others, display as integer
                    value_to_led(config_value,LEDS_INT);
                } // else
            } // else
            m_countdown  = TMR_NO_KEY_TIMEOUT;
            menustate    = MENU_SET_CONFIG_VALUE;
            break;
       //--------------------------------------------------------------------         
       case MENU_SET_CONFIG_VALUE:
            adr = MI_CI_TO_EEADR(menu_item, config_item);
            if (m_countdown == 0)
            {
                menustate = MENU_IDLE;
            } else if (BTN_RELEASED(BTN_PWR))
            {
                menustate = MENU_SHOW_CONFIG_ITEM;
            } else if(BTN_HELD_OR_RELEASED(BTN_UP)) 
            {
                config_value++;
                if ((config_value > 1000) || (--key_held_tmr < 0))
                {
                    config_value += 9;
                } // if
                /* Jump to exit code shared with BTN_DOWN case */
                goto chk_cfg_acc_label;
            } else if(BTN_HELD_OR_RELEASED(BTN_DOWN)) 
            {
                config_value--;
                if ((config_value > 1000) || (--key_held_tmr < 0))
                {
                    config_value -= 9;
                } // if
            chk_cfg_acc_label: // label for goto
                config_value = check_config_value(config_value, adr);
                menustate    = MENU_SHOW_CONFIG_VALUE;
            } else if(BTN_RELEASED(BTN_S))
            {
                if(menu_item == MENU_ITEM_NO)
                {   // We are in the parameter menu
                    if(config_item == rn)
                    {   // When setting run-mode, clear current step & duration
                        eeprom_write_config(EEADR_MENU_ITEM(St), 0);
                        if (minutes)
                             curr_dur = 0;
                        else eeprom_write_config(EEADR_MENU_ITEM(dh), 0);
                        if(config_value < THERMOSTAT_MODE)
                        {
                            eeadr_sp = EEADR_PROFILE_SETPOINT(((uint8_t)config_value), 0);
                            // Set initial value for SP
                            setpoint = eeprom_read_config(eeadr_sp);
                            eeprom_write_config(EEADR_MENU_ITEM(SP), setpoint);
                            // Hack in case inital step duration is '0'
                            if(eeprom_read_config(eeadr_sp+1) == 0)
                            {   // Set to thermostat mode
                                config_value = THERMOSTAT_MODE;
                            } // if
                        } // if
                    } // if
                } // if
                eeprom_write_config(adr, config_value);
                menustate = MENU_SHOW_CONFIG_ITEM;
            } else 
            {   // reset timer to default value
                key_held_tmr = TMR_KEY_ACC; 
            } // else
            break; // MENU_SET_CONFIG_VALUE
       //--------------------------------------------------------------------         
       default:
            menustate = MENU_IDLE;
            break;
   } /* switch(menustate) */
   menu_is_idle = (menustate == MENU_IDLE); // needed for ctrl_task()
} // button_menu_fsm()

/*-----------------------------------------------------------------------------
  Purpose  : This routine converts a menu item in minutes to a value in seconds.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
uint16_t min_to_sec(enum menu_enum x)
{
    uint16_t retv;
   
    retv = eeprom_read_config(EEADR_MENU_ITEM(x)) << 6; // * 64
    retv = retv - (retv >> 4); // 64 - 4 = 60
    return retv;
} // min_to_sec()

/*-----------------------------------------------------------------------------
  Purpose  : This routine is called whenever Pb2 == 2. This mode only deals
             with cooling where the fan of the compressor is controlled by
             the second temperature probe. The fan is switched on/off with a
             hysteresis around 30 °C controlled by parameter Hy2.
             Example: Hy2 is set to 100 E-1 °C => hysteresis is 25-35 °C.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void fan_control(void)
{
        if (temp_ntc2 >= 300 + hysteresis2)
        {
            HEAT_ON;
            led_e |= LED_HEAT;  // Heating LED on
        }
        else if (temp_ntc2 < 300 - hysteresis2)
        {
            HEAT_OFF;
            led_e &= ~LED_HEAT; // Heating LED off
        } // else
} // fan_control()

/*-----------------------------------------------------------------------------
  Purpose  : This routine controls the temperature setpoints. It should be 
             called once every second by ctrl_task().
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void temperature_control(void)
{
    static uint8_t std_x = 0;
    
    switch (std_x)
    {
        case STD_OFF: // OFF
            hysteresis  = eeprom_read_config(EEADR_MENU_ITEM(hy));
            hysteresis2 = eeprom_read_config(EEADR_MENU_ITEM(hy2)) >> 1;
            cooling_delay = min_to_sec(cd);
            heating_delay = min_to_sec(hd);
            RELAYS_OFF; // Disable Cooling and Heating relays
            led_e &= ~(LED_HEAT | LED_COOL); // disable both LEDs
            if (probe2 < 2)
            {
                if ((temp_ntc1 > setpoint + hysteresis) && (!probe2 || (temp_ntc2 >= setpoint - hysteresis2))) 
                    std_x = STD_DLY_COOL; // COOLING DELAY
                else if ((temp_ntc1 < setpoint - hysteresis) && (!probe2 || (temp_ntc2 <= setpoint + hysteresis2)))
                    std_x = STD_DLY_HEAT; // HEATING_DELAY
            } // if
            else
            {   // Probe2 >= 2, cooling with compressor fan control
                fan_control(); // controls fan of cooling compressor
                if (temp_ntc1 > setpoint + hysteresis)
                    std_x = STD_DLY_COOL; // COOLING_DELAY
            } // else
            break;
        case STD_DLY_HEAT: // HEATING DELAY
            led_e ^= LED_HEAT; // Flash to indicate heating delay
            if ((temp_ntc1 > setpoint - hysteresis) ||
                (probe2 && (temp_ntc2 > setpoint + hysteresis2))) std_x = STD_OFF;     // OFF
            else if (--heating_delay == 0)                        std_x = STD_HEATING; // HEATING
            break;
        case STD_DLY_COOL: // COOLING DELAY
            if (probe2 == 2) fan_control(); // controls fan of cooling compressor
            if ((temp_ntc1 < setpoint + hysteresis) ||
                ((probe2 == 1) && (temp_ntc2 < setpoint - hysteresis2))) 
                                            std_x = STD_OFF;     // OFF
            else if (--cooling_delay == 0)  std_x = STD_COOLING; // COOLING
            led_e ^= LED_COOL; // Flash to indicate cooling delay
            break;
        case STD_HEATING: // HEATING
            led_e |= LED_HEAT; // Heating LED on
            HEAT_ON;           // Enable Heating
            if ((temp_ntc1 >= setpoint) || (probe2 && (temp_ntc2 > (setpoint + hysteresis2))))
                std_x = STD_OFF; // OFF
            break;
        case STD_COOLING: // COOLING
            if (probe2 == 2) fan_control(); // controls fan of cooling compressor
            led_e |= LED_COOL; // Cooling LED on
            COOL_ON;           // Enable Cooling
            if ((temp_ntc1 <= setpoint) || ((probe2 == 1) && (temp_ntc2 < (setpoint - hysteresis2))))
                std_x = STD_OFF; // OFF
            break;
    } // switch
} // std_temp_control()

/*-----------------------------------------------------------------------------
  Purpose  : This routine controls the PID controller. It should be 
             called once every second by ctrl_task() as long as TS is not 0. 
             The PID controller itself is called every TS seconds.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void pid_control(void)
{
    static uint8_t pid_tmr = 0;
    
    if (kc != eeprom_read_config(EEADR_MENU_ITEM(Hc)) ||
        ti != eeprom_read_config(EEADR_MENU_ITEM(Ti)) ||
        td != eeprom_read_config(EEADR_MENU_ITEM(Td)))
    {   // One or more PID parameters have changed
       kc = eeprom_read_config(EEADR_MENU_ITEM(Hc));
       ti = eeprom_read_config(EEADR_MENU_ITEM(Ti));
       td = eeprom_read_config(EEADR_MENU_ITEM(Td));
       init_pid(kc,ti,td,ts,temp_ntc1); // Init PID controller
    } // if
    
    if (++pid_tmr >= ts) 
    {   // Call PID controller every TS seconds
        pid_ctrl(temp_ntc1,&pid_out,setpoint);
        pid_tmr = 0;
    } // if
} // pid_control()
