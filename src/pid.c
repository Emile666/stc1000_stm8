/*==================================================================
  File name    : pid.c
  Author       : Emile
  ------------------------------------------------------------------
  Purpose : This file contains the main body of the PID controller.

            For design details, please check the website:
            http://www.vandelogt.nl/uk_regelen_pid.php

            With the GUI, the following parameters can be changed:
            Kc: The controller gain in %/°C
            Ti: Time-constant for the Integral Gain in seconds
            Td: Time-constant for the Derivative Gain in seconds
            Ts: The sample period in seconds
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
#include "pid.h"

uint16_t kc = 0;   // Parameter value for Kc value in %/°C
uint16_t ti = 0;   // Parameter value for I action in seconds
uint16_t td = 0;   // Parameter value for D action in seconds
// Init ts to 0 to disable pid-control and enable thermostat control
uint8_t  ts = 0;   // Parameter value for sample time [sec.]
uint32_t ki;       // Internal value for I action
uint32_t kd;       // Internal value for D action
int32_t  pp;       // debug
int16_t  xk_1;     // x[k-1]
int16_t  xk_2;     // x[k-2]

void init_pid(uint16_t kc, uint16_t ti, uint16_t td, uint8_t ts, uint16_t xk)
/*------------------------------------------------------------------
  Purpose  : This function initialises the Takahashi Type C PID
             controller.
  Variables: kc: Kc parameter value in %/°C    ; controls P-action
             ti: Ti parameter value in seconds ; controls I-action
             td: Td parameter value in seconds ; controls D-action
             ts: Ts parameter sample-time of pid-controller in seconds
             xk: actual temperature value

                   Kc.Ts
             ki =  -----   (for I-term)
                    Ti

                       Td
             kd = Kc . --  (for D-term)
                       Ts

  Returns  : No values are returned
  ------------------------------------------------------------------*/
{
   if (ti == 0) ki = 0;
   else         ki = (((uint32_t)kc * ts) / ti);
   if (ts == 0) kd = 0;
   else         kd = (((uint32_t)kc * td) / ts);
   
   xk_2 = xk_1 = xk; // init. previous samples to current temperature
} // init_pid()

void pid_reg(int16_t xk, int16_t *yk, uint16_t tset)
/*------------------------------------------------------------------
  Purpose  : This function implements the Takahashi Type C PID
             controller: the P and D term are no longer dependent
             on the set-point, only on PV.
             The D term is NOT low-pass filtered.
             This function should be called once every TS seconds.
  Variables:
        xk : The input variable x[k] (= measured temperature in E-1 °C)
       *yk : The output variable y[k] [-1000..+1000] in E-1 %
      tset : The setpoint value for the temperature in E-1 °C
  Returns  : No values are returned
  ------------------------------------------------------------------*/
{
    //--------------------------------------------------------------------------------
    // Takahashi Type C PID controller:
    //
    // e[k] = w[k] - x[k]
    //                                    Kc.Ts        Kc.Td
    // y[k] = y[k-1] + Kc.(x[k-1]-x[k]) + -----.e[k] + -----.(2.x[k-1]-x[k]-x[k-2])
    //                                      Ti           Ts
    //
    //--------------------------------------------------------------------------------
    pp   = (uint32_t)kc * (xk_1 - xk);     // Kc.(x[k-1]-x[k])
    pp  += ki * (tset - xk);               // (Kc.Ts/Ti).e[k]
    pp  += kd * ((xk_1 << 1) - xk - xk_2); // (Kc.Td/Ts).(2.x[k-1]-x[k]-x[k-2])
    *yk += (int16_t)pp;
    // limit y[k] to GMA_HLIM and GMA_LLIM
    if (*yk > GMA_HLIM)      *yk = GMA_HLIM;
    else if (*yk < GMA_LLIM) *yk = GMA_LLIM;

    xk_2  = xk_1; // x[k-2] = x[k-1]
    xk_1  = xk;   // x[k-1] = x[k]
} // pid_reg()


