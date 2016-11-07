/*==================================================================
  File Name    : scheduler.c
  Author       : Emile
  ------------------------------------------------------------------
  Purpose : This files contains all the functions for adding and
            executing tasks in a cooperative (non pre-emptive) way.
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
#include "scheduler.h"

task_struct task_list[MAX_TASKS]; // struct with all tasks
uint8_t     max_tasks = 0;

/*-----------------------------------------------------------------------------
  Purpose  : Run-time function for scheduler. Should be called from within
             an ISR. This function goes through the task-list and decrements
             eacht task counter. On time-out, the ready flag is set.
  Variables: task_list[] structure
  Returns  : -
  ---------------------------------------------------------------------------*/
void scheduler_isr(void)
{
	uint8_t index = 0; // index in task_list struct

	while(task_list[index].pFunction)
	{
		//First go through the initial delay
		if(task_list[index].Delay > 0)
		{
			task_list[index].Delay--;
		} // if
		else
		{	//now we decrement the actual period counter 
			task_list[index].Counter--;
			if(task_list[index].Counter == 0)
			{
				//Set the flag and reset the counter;
				task_list[index].Status |= TASK_READY;
			} // if
		} // else
		index++;
	} // while
} // scheduler_isr()

/*-----------------------------------------------------------------------------
  Purpose  : Run all tasks for which the ready flag is set. Should be called 
             from within the main() function, not from an interrupt routine!
  Variables: task_list[] structure
  Returns  : -
  ---------------------------------------------------------------------------*/
void dispatch_tasks(void)
{
	uint8_t  index = 0;

	//go through the active tasks
	while(task_list[index].pFunction)
	{
		if((task_list[index].Status & (TASK_READY | TASK_ENABLED)) == (TASK_READY | TASK_ENABLED))
		{
			task_list[index].pFunction(); // run the task
			task_list[index].Status  &= ~TASK_READY; // reset the task when finished
			task_list[index].Counter  = task_list[index].Period; // reset counter
		} // if
		index++;
	} // while
	//go to sleep till next tick!
} // dispatch_tasks()

/*-----------------------------------------------------------------------------
  Purpose  : Add a function to the task-list struct. Should be called upon
  		     initialization.
  Variables: task_ptr: pointer to function
             delay   : initial delay in msec.
             period  : period between two calls in msec.
  Returns  : [NO_ERR, ERR_MAX_TASKS]
  ---------------------------------------------------------------------------*/
uint8_t add_task(void (*task_ptr)(), char *Name, uint16_t delay, uint16_t period)
{
	uint8_t  index = 0;
	uint16_t temp1 = (uint16_t)(delay  * TICKS_PER_SEC / 1000);
	uint16_t temp2 = (uint16_t)(period * TICKS_PER_SEC / 1000);

	if (max_tasks >= MAX_TASKS)
		return ERR_MAX_TASKS;
		
	//go through the active tasks
	if(task_list[index].Period != 0)
	{
		while(task_list[++index].Period != 0) ;
	} // if

	if(task_list[index].Period == 0)
	{
		task_list[index].pFunction    = task_ptr;       // Pointer to Function
		task_list[index].Period       = temp2;          // Period in msec.
		task_list[index].Counter      = temp2;	        // Countdown timer
		task_list[index].Delay        = temp1;          // Initial delay before start
		task_list[index].Status      |= TASK_ENABLED;   // Enable task by default
		task_list[index].Status      &= ~TASK_READY;    // Task not ready to run
		strncpy(task_list[index].Name, Name, NAME_LEN); // Name of Task
		max_tasks++; // increase number of tasks
	} // if
	return NO_ERR;
} // add_task()

/*-----------------------------------------------------------------------------
  Purpose  : Enable a task.
  Variables: Name: Name of task to enable
  Returns  : error [NO_ERR, ERR_NAME, ERR_EMPTY]
  ---------------------------------------------------------------------------*/
uint8_t enable_task(char *Name)
{
	uint8_t index = 0;
	bool    found = false;
	
	//go through the active tasks
	if(task_list[index].Period != 0)
	{
		while ((task_list[index].Period != 0) && !found)
		{
			if (!strcmp(task_list[index].Name,Name))
			{
				task_list[index].Status |= TASK_ENABLED;
				found = true;
			} // if
			index++;
		} // while
	} // if
	else return ERR_EMPTY;
	if (!found)
	     return ERR_NAME;
	else return NO_ERR;	
} // enable_task()

/*-----------------------------------------------------------------------------
  Purpose  : Disable a task.
  Variables: Name: Name of task to disable
  Returns  : error [NO_ERR, ERR_NAME, ERR_EMPTY]
  ---------------------------------------------------------------------------*/
uint8_t disable_task(char *Name)
{
	uint8_t index = 0;
	bool    found = false;
	
	//go through the active tasks
	if(task_list[index].Period != 0)
	{
		while ((task_list[index].Period != 0) && !found)
		{
			if (!strcmp(task_list[index].Name,Name))
			{
				task_list[index].Status &= ~TASK_ENABLED;
				found = true;
			} // if
			index++;
		} // while
	} // if
	else return ERR_EMPTY;
	if (!found)
	     return ERR_NAME;
	else return NO_ERR;	
} // disable_task()

/*-----------------------------------------------------------------------------
  Purpose  : Set the time-period (msec.) of a task.
  Variables: msec: the time in milliseconds
             name: the name of the task to set the time for
  Returns  : error [NO_ERR, ERR_NAME, ERR_EMPTY]
  ---------------------------------------------------------------------------*/
uint8_t set_task_time_period(uint16_t Period, char *Name)
{
	uint8_t index = 0;
	bool    found = false;
	
	//go through the active tasks
	if(task_list[index].Period != 0)
	{
		while ((task_list[index].Period != 0) && !found)
		{
			if (!strcmp(task_list[index].Name,Name))
			{
				task_list[index].Period = (uint16_t)(Period * TICKS_PER_SEC / 1000);
				found = true;
			} // if
			index++;
		} // while
	} // if
	else return ERR_EMPTY;
	if (!found)
	     return ERR_NAME;
	else return NO_ERR;	
} // set_task_time_period()

