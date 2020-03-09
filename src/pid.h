/*==================================================================
  File name    : pid.h
  Author       : Emile
  ------------------------------------------------------------------
  Purpose : This file contains the defines for the PID controller.
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
#ifndef PID_REG_H
#define PID_REG_H
#include <stdint.h>
#include <stdbool.h>

// PID controller upper & lower limit [E-1 %]
#define GMA_HLIM (1000)
#define GMA_LLIM (0)

//--------------------
// Function Prototypes
//--------------------
void init_pid(int16_t kc, uint16_t ti, uint16_t td, uint8_t ts, int16_t yk);
void pid_ctrl(int16_t yk, int16_t *uk, int16_t tset, bool pid_on);

#endif
