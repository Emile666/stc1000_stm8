/*==================================================================
  File Name    : stc1000p.c
  Author       : Mats Staffansson / Emile
  ------------------------------------------------------------------
  Purpose : This files contains the main() function and all the 
            hardware related functions for the STM8 uC.
            It is meant for the STC1000 thermostat hardware WR-032.
            
            The original source is created by Mats Staffansson and
            adapted for the STM8S uC by Emile
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
#include <intrinsics.h> 
#include "stc1000p.h"
#include "stc1000p_lib.h"
#include "scheduler.h"
#include "adc.h"
#include "eep.h"

// Global variables
bool      ad_err1 = false; // used for adc range checking
bool      ad_err2 = false; // used for adc range checking
bool      probe2  = false; // cached flag indicating whether 2nd probe is active
bool      show_sa_alarm = false;
bool      ad_ch   = false; // used in adc_task()
uint16_t  ad_ntc1 = (512L << FILTER_SHIFT);
uint16_t  ad_ntc2 = (512L << FILTER_SHIFT);
int16_t   temp_ntc1;         // The temperature in E-1 °C from NTC probe 1
int16_t   temp_ntc2;         // The temperature in E-1 °C from NTC probe 2
uint8_t   mpx_nr = 0;        // Used in multiplexer() function
// When in SWIM Debug Mode, PD1/SWIM needs to be disabled (= no IO)
uint8_t   portd_leds;        // Contains define PORTD_LEDS
uint8_t   portb, portc, portd, b;// Needed for save_display_state() and restore_display_state()
int16_t   pwr_on_tmr = 1000;     // Needed for 7-segment display test

// External variables, defined in other files
extern led_e_t led_e;                 // value of extra LEDs
extern led_t   led_10, led_1, led_01; // values of 10s, 1s and 0.1s
extern bool    pwr_on;           // True = power ON, False = power OFF
extern uint8_t sensor2_selected; // DOWN button pressed < 3 sec. shows 2nd temperature / pid_output
extern bool    minutes;          // timing control: false = hours, true = minutes
extern bool    menu_is_idle;     // No menus in STD active
extern bool    fahrenheit;       // false = Celsius, true = Fahrenheit
extern uint16_t cooling_delay;   // Initial cooling delay
extern uint16_t heating_delay;   // Initial heating delay
extern int16_t  setpoint;        // local copy of SP variable
extern uint8_t  ts;              // Parameter value for sample time [sec.]
extern int16_t  pid_out;         // Output from PID controller in E-1 %

/*-----------------------------------------------------------------------------
  Purpose  : This routine saves the current state of the 7-segment display.
             This is necessary since the buttons, but also the AD-channels,
             share the same GPIO bits.
             It uses the global variables portb, portc and portd.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void save_display_state(void)
{
    // Save registers that interferes with LEDs and AD-channels
    portb   = PB_IDR & (CC_10 | CC_1); // Common-Cathode for 10s and 1s
    portc   = PC_IDR & BUTTONS;        // LEDs connected to buttons 
    // Common-Cathode for 0.1s and extras and AD-channels AIN4 and AIN3
    portd   = PD_IDR & (CC_01 | CC_e | AD_CHANNELS); 
    PB_ODR |= (CC_10 | CC_1);  // Disable common-cathode for 10s and 1s
    PD_ODR |= (CC_01 | CC_e);  // Disable common-cathode for 0.1s and extras
} // save_display_state()

/*-----------------------------------------------------------------------------
  Purpose  : This routine restores the current state of the 7-segment display.
             This is necessary since the buttons, but also the AD-channels,
             share the same GPIO bits.
             It uses the global variables portb, portc and portd.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void restore_display_state(void)
{
    PD_ODR &= ~(CC_01 | CC_e | AD_CHANNELS); // init. CC_01, CC_e and AD-channels
    PD_ODR |= portd;                         // restore values for PORTD
    PC_ODR &= ~BUTTONS;                      // init. buttons
    PC_ODR |= portc;                         // restore values for PORTC
    PB_ODR &= ~(CC_10 | CC_1);               // init. CC_10 and CC_1
    PB_ODR |= portb;                         // restore values for PORTB
} // restore_display_state()

/*-----------------------------------------------------------------------------
  Purpose  : This routine multiplexes the 4 segments of the 7-segment displays.
             It runs at 1 kHz, so there's a full update after every 4 msec.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void multiplexer(void)
{
    PC_ODR    &= ~PORTC_LEDS;    // Clear LEDs
    PD_ODR    &= ~portd_leds;    // Clear LEDs
    PB_ODR    |= (CC_10 | CC_1); // Disable common-cathode for 10s and 1s
    PD_ODR    |= (CC_01 | CC_e); // Disable common-cathode for 0.1s and extras
    
    switch (mpx_nr)
    {
        case 0: // output 10s digit
            PC_ODR |= (led_10.raw & PORTC_LEDS);        // Update PC7..PC3
            PD_ODR |= ((led_10.raw << 1) & portd_leds); // Update PD3..PD1
            PB_ODR &= ~CC_10;    // Enable  common-cathode for 10s
            mpx_nr = 1;
            break;
        case 1: // output 1s digit
            PC_ODR |= (led_1.raw & PORTC_LEDS);        // Update PC7..PC3
            PD_ODR |= ((led_1.raw << 1) & portd_leds); // Update PD3..PD1
            PB_ODR &= ~CC_1;     // Enable  common-cathode for 1s
            mpx_nr = 2;
            break;
        case 2: // output 01s digit
            PC_ODR |= (led_01.raw & PORTC_LEDS);        // Update PC7..PC3
            PD_ODR |= ((led_01.raw << 1) & portd_leds); // Update PD3..PD1
            PD_ODR &= ~CC_01;    // Enable common-cathode for 0.1s
            mpx_nr = 3;
            break;
        case 3: // outputs special digits
            PC_ODR |= (led_e.raw & PORTC_LEDS);        // Update PC7..PC3
            PD_ODR |= ((led_e.raw << 1) & portd_leds); // Update PD3..PD1
            PD_ODR &= ~CC_e;     // Enable common-cathode for extras
        default: // FALL-THROUGH (less code-size)
            mpx_nr = 0;
            break;
            //mpx_nr = 0;
            //break;
    } // switch            
} // multiplexer()

/*-----------------------------------------------------------------------------
  Purpose  : This is the interrupt routine for the Timer 2 Overflow handler.
             It runs at 1 kHz and drives the scheduler and the multiplexer.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
#pragma vector = TIM2_OVR_UIF_vector
__interrupt void TIM2_UPD_OVF_IRQHandler(void)
{
    scheduler_isr();  // Run scheduler interrupt function
    if (!pwr_on)
    {   // Display OFF on dispay
	led_10.raw = LED_O;
	led_1.raw  = led_01.raw = LED_F;
        led_e.raw  = LED_OFF;
        pwr_on_tmr = 1000; // 1 second
    } // if
    else if (pwr_on_tmr > 0)
    {	// 7-segment display test for 1 second
        pwr_on_tmr--;
        led_10.raw = led_1.raw  = led_01.raw = led_e.raw  = LED_ON;
    } // else if
    multiplexer();    // Run multiplexer for Display and Keys
    TIM2_SR1_UIF = 0; // Reset the interrupt otherwise it will fire again straight away.
} // TIM2_UPD_OVF_IRQHandler()

/*-----------------------------------------------------------------------------
  Purpose  : This routine initialises the system clock to run at 16 MHz.
             It uses the internal HSI oscillator.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void initialise_system_clock(void)
{
    CLK_ICKR       = 0;           //  Reset the Internal Clock Register.
    CLK_ICKR_HSIEN = 1;           //  Enable the HSI.
    //CLK_ECKR       = 0;           //  Disable the external clock.
    while (CLK_ICKR_HSIRDY == 0); //  Wait for the HSI to be ready for use.
    CLK_CKDIVR     = 0;           //  Ensure the clocks are running at full speed.
 
    // The datasheet lists that the max. ADC clock is equal to 6 MHz (4 MHz when on 3.3V).
    // Because fMASTER is now at 16 MHz, we need to set the ADC-prescaler to 4.
    ADC_CR1_SPSEL  = 0x02;        //  Set prescaler to 4, fADC = 4 MHz
    
    //CLK_PCKENR1    = 0xff;        //  Enable all peripheral clocks.
    //CLK_PCKENR2    = 0xff;        //  Ditto.
    //CLK_CCOR       = 0;           //  Turn off CCO.
    //CLK_HSITRIMR   = 0;           //  Turn off any HSIU trimming.
    CLK_SWIMCCR    = 0;           //  Set SWIM to run at clock / 2.
    CLK_SWR        = 0xe1;        //  Use HSI as the clock source.
    CLK_SWCR       = 0;           //  Reset the clock switch control register.
    CLK_SWCR_SWEN  = 1;           //  Enable switching.
    while (CLK_SWCR_SWBSY != 0);  //  Pause while the clock switch is busy.
} // initialise_system_clock()

/*-----------------------------------------------------------------------------
  Purpose  : This routine initialises Timer 2 to generate a 1 kHz interrupt.
             16 MHz / (  16 *  1000) = 1000 Hz (1000 = 0x03E8)
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void setup_timer2(void)
{
    TIM2_PSCR    = 0x04;  //  Prescaler = 16
    TIM2_ARRH    = 0x03;  //  High byte of 1000
    TIM2_ARRL    = 0xE8;  //  Low  byte of 1000
    TIM2_IER_UIE = 1;     //  Enable the update interrupts
    TIM2_CR1_CEN = 1;     //  Finally enable the timer
} // setup_timer2()

/*-----------------------------------------------------------------------------
  Purpose  : This routine initialises all the GPIO pins of the STM8 uC.
             See stc1000p.h for a detailed description of all pin-functions.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void setup_output_ports(void)
{
    PA_ODR      = 0x00; // Turn off all pins from Port A
    PA_DDR     |= (S3 | COOL | HEAT); // Set as output
    PA_CR1     |= (S3 | COOL | HEAT); // Set to Push-Pull
    PB_ODR      = 0x30; // Turn off all pins from Port B (CC1 = CC2 = H)
    PB_DDR     |= 0x30; // Set PB5..PB4 as output
    PB_CR1     |= 0x30; // Set PB5..PB4 to Push-Pull
    PC_ODR      = 0x00; // Turn off all pins from Port C
    PC_DDR     |= PORTC_LEDS; // Set PC7..PC3 as outputs
    PC_CR1     |= PORTC_LEDS; // Set PC7..PC3 to Push-Pull
    PD_ODR      = 0x30; // Turn off all pins from Port D (CC3 = CCe = H)
    PD_DDR     |= (0x70 | portd_leds); // Set PD6..PD1 as outputs
    PD_CR1     |= (0x70 | portd_leds); // Set PD6..PD1 to Push-Pull
} // setup_output_ports()

/*-----------------------------------------------------------------------------
  Purpose  : This task is called every 500 msec. and processes the NTC 
             temperature probes from NTC1 (PD3/AIN4) and NTC2 (PD2/AIN3)
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void adc_task(void)
{
  uint16_t temp;
  uint8_t  i;
  
  // Save registers that interferes with LED's and disable common-cathodes
  __disable_interrupt();      // Disable interrups while reading buttons
  save_display_state();       // Save current state of 7-segment displays
  PD_DDR &= ~AD_CHANNELS;     // Set PD3 (AIN4) and PD2 (AIN3) to inputs
  PD_CR1 &= ~AD_CHANNELS;     // Set to floating-inputs (required by ADC)  
  for (i = 0; i < 200; i++) ; // Disable to let input signal settle
  if (ad_ch)
  {  // Process NTC probe 1
     temp       = read_adc(AD_NTC1);
     ad_ntc1    = ((ad_ntc1 - (ad_ntc1 >> FILTER_SHIFT)) + temp);
     temp_ntc1  = ad_to_temp(ad_ntc1,&ad_err1);
     temp_ntc1 += eeprom_read_config(EEADR_MENU_ITEM(tc));
  } // if
  else
  {  // Process NTC probe 2
     temp       = read_adc(AD_NTC2);
     ad_ntc2    = ((ad_ntc2 - (ad_ntc2 >> FILTER_SHIFT)) + temp);
     temp_ntc2  = ad_to_temp(ad_ntc2,&ad_err2);
     temp_ntc2 += eeprom_read_config(EEADR_MENU_ITEM(tc2));
  } // else
  ad_ch = !ad_ch;

  // Since the ADC disables GPIO pins automatically, these need
  // to be set to GPIO output pins again.
  PD_DDR  |= AD_CHANNELS;  // Set PD3 (AIN4) and PD2 (AIN3) as outputs again
  PD_CR1  |= AD_CHANNELS;  // Set PD3 (AIN4) and PD2 (AIN3) to Push-Pull again
  restore_display_state(); // Restore state of 7-segment displays
  __enable_interrupt();    // Re-enable Interrupts
} // adc_task()

/*-----------------------------------------------------------------------------
  Purpose  : This task is called every 100 msec. and creates a slow PWM signal
             from pid_output: T = 12.5 seconds. This signal can be used to
             drive a Solid-State Relay (SSR).
  Variables: pid_out (global) is used
  Returns  : -
  ---------------------------------------------------------------------------*/
void pid_to_time(void)
{
    static uint8_t std_ptt = 1; // state [on, off]
    static uint8_t ltmr    = 0; // #times to set S3 to 0
    static uint8_t htmr    = 0; // #times to set S3 to 1
    uint16_t x;                 // temp. variable
     
    x   = (pid_out < 0) ? -pid_out : pid_out;
    x >>= 3; // divide by 8 to give 1.25 * pid_out
    
    switch (std_ptt)
    {
        case 0: // OFF
            if (ltmr == 0)
            {   // End of low-time
                htmr = (uint8_t)x; // htmr = 1.25 * pid_out
                if ((htmr > 0) && pwr_on) std_ptt = 1;
            } // if
            else ltmr--; // decrease timer
            S3_OFF;      // S3 output = 0
            break;
        case 1: // ON
            if (htmr == 0)
            {   // End of high-time
                ltmr = (uint8_t)(125 - x); // ltmr = 1.25 * (100 - pid_out)
                if ((ltmr > 0) || !pwr_on) std_ptt = 0;
            } // if
            else htmr--; // decrease timer
            S3_ON;       // S3 output = 1
            break;
    } // switch
} // pid_to_time()

/*-----------------------------------------------------------------------------
  Purpose  : This task is called every 100 msec. and reads the buttons, runs
             the STD and updates the 7-segment display.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void std_task(void)
{
    read_buttons(); // reads the buttons keys, result is stored in _buttons
    menu_fsm();     // Finite State Machine menu
    pid_to_time();  // Make Slow-PWM signal and send to S3 output-port
} // std_task()

/*-----------------------------------------------------------------------------
  Purpose  : This task is called every second and contains the main control
             task for the device. It also calls temperature_control().
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void ctrl_task(void)
{
   int16_t sa, diff;
   
    if (eeprom_read_config(EEADR_MENU_ITEM(CF))) // true = Fahrenheit
         fahrenheit = true;
    else fahrenheit = false;
    if (eeprom_read_config(EEADR_MENU_ITEM(HrS))) // true = hours
         minutes = false; // control-timing is in hours 
    else minutes = true;  // control-timing is in minutes

    // Start with updating the alarm
   // cache whether the 2nd probe is enabled or not.
      if (eeprom_read_config(EEADR_MENU_ITEM(Pb2))) 
        probe2 = true;
   else probe2 = false;
   if (ad_err1 || (ad_err2 && probe2))
   {
       ALARM_ON;   // enable the piezo buzzer
       RELAYS_OFF; // disable the output relays
       if (menu_is_idle)
       {  // Make it less anoying to nagivate menu during alarm
          led_10.raw = LED_A;
	  led_1.raw  = LED_L;
	  led_e.raw  = led_01.raw = LED_OFF;
       } // if
       cooling_delay = heating_delay = 60;
   } else {
       ALARM_OFF; // reset the piezo buzzer
       if(((uint8_t)eeprom_read_config(EEADR_MENU_ITEM(rn))) < THERMOSTAT_MODE)
            led_e.e.set = 1; // Indicate profile mode
       else led_e.e.set = 0;

       ts = eeprom_read_config(EEADR_MENU_ITEM(Ts)); // Read Ts [seconds]
       sa = eeprom_read_config(EEADR_MENU_ITEM(SA)); // Show Alarm parameter
       if (sa)
       {
           if (minutes) // is timing-control in minutes?
                diff = temp_ntc1 - setpoint;
	   else diff = temp_ntc1 - eeprom_read_config(EEADR_MENU_ITEM(SP));

	   if (diff < 0) diff = -diff;
	   if (sa < 0)
           {
  	      sa = -sa;
              if (diff <= sa)
                   ALARM_ON;  // enable the piezo buzzer
              else ALARM_OFF; // reset the piezo buzzer
	   } else {
              if (diff >= sa)
                   ALARM_ON;  // enable the piezo buzzer
              else ALARM_OFF; // reset the piezo buzzer
	   } // if
       } // if
       if (ts == 0)                // PID Ts parameter is 0?
       {
           temperature_control();  // Run thermostat
           pid_out = 0;            // Disable PID-output
       } // if
       else pid_control();         // Run PID controller
       if (menu_is_idle)           // show temperature if menu is idle
       {
           if ((PD_IDR & ALARM) && show_sa_alarm)
           {
               led_10.raw = LED_S;
	       led_1.raw  = LED_A;
	       led_01.raw = LED_OFF;
           } else {
               //led_e.e.point  = sensor2_selected; // does not work
               switch (sensor2_selected)
               {
                   case 0: value_to_led(temp_ntc1,LEDS_TEMP); break;
                   case 1: value_to_led(temp_ntc2,LEDS_TEMP); break;
                   case 2: value_to_led(pid_out  ,LEDS_INT) ; break;
               } // switch
           } // else
           show_sa_alarm = !show_sa_alarm;
       } // if
   } // else
} // ctrl_task()

/*-----------------------------------------------------------------------------
  Purpose  : This task is called every minute or every hour and updates the
             current running temperature profile.
  Variables: minutes: timing control: false = hours, true = minutes
  Returns  : -
  ---------------------------------------------------------------------------*/
void prfl_task(void)
{
    static uint8_t min = 0;
    
    if (minutes)
    {   // call every minute
        update_profile();
        min = 0;
    } else {
        if (++min >= 60)
        {   // call every hour
            min = 0;
            update_profile(); 
        } // if
    } // else
} // prfl_task();

/*-----------------------------------------------------------------------------
  Purpose  : This is the main entry-point for the entire program.
             It initialises everything, starts the scheduler and dispatches
             all tasks.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
int main(void)
{
    if (RST_SR_SWIMF) // Check for SWIM Debug Reset
         portd_leds = PORTD_LEDS_SWIM;
    else portd_leds = PORTD_LEDS;
    __disable_interrupt();
    initialise_system_clock(); // Set system-clock to 16 MHz
    setup_output_ports();      // Init. needed output-ports for LED and keys
    setup_timer2();            // Set Timer 2 to 1 kHz
    pwr_on = eeprom_read_config(EEADR_POWER_ON); // check pwr_on flag
    
    // Initialise all tasks for the scheduler
    add_task(adc_task ,"ADC  task",  0,  500); // every 500 msec.
    add_task(std_task ,"STD  task", 50,  100); // every 100 msec.
    add_task(ctrl_task,"CTRL task",200, 1000); // every second
    add_task(prfl_task,"PRFL task",300,60000); // every minute / hour
    __enable_interrupt();

    while (1)
    {   // background-processes
        dispatch_tasks();       // Run task-scheduler()
        __wait_for_interrupt(); // do nothing
    } // while
} // main()
