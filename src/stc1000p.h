/*==================================================================
  File Name    : stc1000p.h
  Author       : Mats Staffansson / Emile
  ------------------------------------------------------------------
  This is the header file stc1000p.c, which is the main-body of the
  STC1000+, improved firmware for the STC-1000 dual stage thermostat.
 
  Copyright 2014 Mats Staffansson, updated for STM8 uC by Emile
 
  This file is part of STC1000+.
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
  Schematic of the connections to the MCU.
 
                                      STM8S003F3
                                     ------------
       LED Common Cathode extras PD4 | 1     20 | PD3/AIN4 LED A / NTC 1
  LED Common Cathode 0.1's digit PD5 | 2     19 | PD2/AIN3 LED B / NTC 2
                    Piezo Buzzer PD6 | 3     18 | PD1      LED C / S4 / SWIM
                                nRST | 4     17 | PC7      LED D
                      Relay Heat PA1 | 5     16 | PC6      LED E  / UP   key
                      Relay Cool PA2 | 6     15 | PC5      LED F  / DOWN key
                                 GND | 7     14 | PC4      LED G  / PWR  key
                                VCAP | 8     13 | PC3      LED dp / S    key
                                 VCC | 9     12 | PB4      S1 / LED Common Cathode 1's digit
          Slow PWM pid-output S3 PA3 | 10    11 | PB5      S2 / LED Common Cathode 10' digit
                                     ------------
  ------------------------------------------------------------------
  Schematic of the bit numbers for the display LED's. Useful if custom characters are needed.
 
            * a * b   --------    *    --------       * C
                     /   a   /    g   /   a   /       e f
             d    f /       / b    f /       / b    ----
            ---     -------          -------     f / a / b
            *     /   g   /        /   g   /       ---
            c  e /       / c    e /       / c  e / g / c
                 --------    *    --------   *   ----  *
                   d         dp     d        dp   d    dp
  ------------------------------------------------------------------
  $Log: $
  ==================================================================
*/
#ifndef __STC1000P_H__
#define __STC1000P_H__

// #include <iostm8s003f3.h> for stock STC1000 PCB
#include <iostm8s003f3.h>
//#include <iostm8s103f3.h>
#include <stdint.h>
     
/* Define STC-1000+ version number (XYY, X=major, YY=minor) */
/* Also, keep track of last version that has changes in EEPROM layout */
#define STC1000P_VERSION	(200)
#define STC1000P_EEPROM_VERSION	 (20)

// Common-Cathode bits on PB5, PB4, PD5 and PD4
#define CC_10      (0x20)
#define CC_1       (0x10)
#define CC_01      (0x20)
#define CC_e       (0x10)
#define PORTC_LEDS (0xF8)

// ADC-channels AIN4 (PD3) and AIN3 (PD2) are used on PORTD
#define AD_CHANNELS (0x0C)
     
// For SWIM Debugging use 0x0C, for Production use 0x0E (PD1 = SWIM)
#define PORTD_LEDS_SWIM (0x0C)
#define PORTD_LEDS      (0x0E)

// Defines for outputs: Alarm = PD6, S3 = PA3, Cool = PA2, Heat = PA1
#define ALARM    (0x40)
#define S3       (0x08)
#define COOL     (0x04)
#define HEAT     (0x02)

#define ALARM_ON    (PA_ODR |=  ALARM)
#define ALARM_OFF   (PA_ODR &= ~ALARM)
#define COOL_STATUS ((PA_IDR & COOL) == COOL)
#define S3_ON       (PA_ODR |=  S3)
#define S3_OFF      (PA_ODR &= ~S3)
#define COOL_ON     (PA_ODR |=  COOL)
#define COOL_OFF    (PA_ODR &= ~COOL)
#define HEAT_ON     (PA_ODR |=  HEAT)
#define HEAT_OFF    (PA_ODR &= ~HEAT)
#define HEAT_STATUS ((PA_IDR & HEAT) == HEAT)
#define RELAYS_OFF  (PA_ODR &= ~(HEAT | COOL))
     
// PC7 PC6 PC5 PC4 PC3 PD3 PD2 PD1
//  D   E   F   G   dp  A   B   C
#define LED_OFF	(0x00)
#define LED_ON  (0xFF)
#define LED_0	(0xE7)
#define LED_1	(0x03)
#define LED_2	(0xD6)
#define LED_3	(0x97)
#define LED_4	(0x33)
#define LED_5	(0xB5)
#define LED_6	(0xF5)
#define LED_7	(0x07)
#define LED_8	(0xF7)
#define LED_9	(0xB7)
#define LED_A	(0x77)
#define LED_a	(0xD7)
#define LED_b	(0xF1)
#define LED_C	(0xE4)
#define LED_c	(0xD0)
#define LED_d	(0xD3)
#define LED_e	(0xF6)
#define LED_E	(0xF4)
#define LED_F	(0x74)
#define LED_H	(0x73)
#define LED_h	(0x71)
#define LED_I	(0x03)
#define LED_J	(0xC3)
#define LED_L	(0xE0)
#define LED_n	(0x51)	
#define LED_O	(0xE7)
#define LED_o	(0xD1)
#define LED_P	(0x76)
#define LED_r	(0x50)	
#define LED_S	(0xB5)
#define LED_t	(0xF0)
#define LED_U	(0xE3)
#define LED_u	(0xC1)
#define LED_y	(0xB3)

#define LED_HEAT    (0x01)
#define LED_SET     (0x02)
#define LED_COOL    (0x04)
#define LED_DECIMAL (0x08)
#define LED_POINT   (0x10)
#define LED_CELS    (0x20)
#define LED_DEGR    (0x40)
#define LED_NEG     (0x80)

// Function prototypes
void save_display_state(void);
void restore_display_state(void);
void multiplexer(void);
void initialise_system_clock(void);
void initialise_timer2(void);
void setup_timer2(void);
void setup_output_ports(void);
void adc_task(void);
void std_task(void);
void ctrl_task(void);
void prfl_task(void);

#endif // __STC1000P_H__
