/*==================================================================
  File Name    : adc.c
  Author       : Emile
  ------------------------------------------------------------------
  Purpose : This files contains the ADC related functions 
            for the STM8 uC.
            It is meant for the STC1000 thermostat hardware WR-032.
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
#include "adc.h"

extern bool fahrenheit; // false = Celsius, true = Fahrenheit

/* Temperature lookup table  */
const int ad_lookup_f[] = {0,-555,-319,-167,-49,48,134,211,282,348,412,474,534,593,652,711,770,831,893,957,1025,1096,1172,1253,1343,1444,1559,1694,1860,2078,2397,2987};
const int ad_lookup_c[] = {0,-486,-355,-270,-205,-151,-104,-61,-21,16,51,85,119,152,184,217,250,284,318,354,391,431,473,519,569,624,688,763,856,977,1154,1482};

/*-----------------------------------------------------------------------------
  Purpose  : This routine reads a value from an ADC channel
 Variables : ch: channel number [AIN3,AIN4]
  Returns  : the value read from the ADC
  ---------------------------------------------------------------------------*/
uint16_t read_adc(uint8_t ch)
{
    uint16_t result1 = 0; // conversion result
    uint16_t result2 = 0; // sum of results
    uint8_t  i,resultL;
    
    // From the STM8 Reference Manual:
    // When the ADC is powered on, the digital input and output stages of the selected channel
    // are disabled independently on the GPIO pin configuration. It is therefore recommended to
    // select the analog input channel before powering on the ADC
    // Time needed: tSTAB = 7 us, tCONV = 3.5 us (fADC = 4 MHz). Total = 10.5 us)
    ADC_CSR_CH    = ch;         // Select ADC channel
    ADC_TDRL      = 0x18;       // Disable Schmitt-Trigger of ADC channels 3 and 4
    ADC_CR1_ADON  = 1;          // Turn ADC on, note a 2nd set is required to start the conversion.
    ADC_CR3_DBUF  = 0;
    ADC_CR2_ALIGN = 1;          // Data is right aligned.
    while (ADC_CR1_ADON == 0) ; // wait until ADC is turned on

    for (i = 0; i < ADC_AVG; i++)
    {
        ADC_CR1_ADON  = 1;          // This 2nd write starts the conversion.
        while (ADC_CSR_EOC == 0) ;  // wait until conversion is complete
        resultL      = ADC_DRL;     // With right-alignment, LSB must be read first
        result1      = ADC_DRH;	    // read MSB of conversion result
        result1    <<= 8;
        result1     |= resultL;     // Add LSB and MSB together
        result2     += result1;     // Add results together
        ADC_CSR_EOC  = 0;	    // Reset conversion complete flag
    } // for
    ADC_CR1_ADON = 0;               // Disable the ADC
    result2     /= ADC_AVG;         // Calculate average of samples
    return result2;
} // read_adc()

/*-----------------------------------------------------------------------------
  Purpose  : This routine converts the result from the ADC into a temperature.
             Since the NTC resistance is highly non-linear, a lookup table is
             used to make calculations less intensive.
 Variables : adfilter: the value read from the ADC
                 *err: true = the ADC value is out-of-limits
  Returns  : the value read from the ADC
  ---------------------------------------------------------------------------*/
int16_t ad_to_temp(uint16_t adfilter, bool *err)
{
	uint8_t i;
	long    temp = 32;
	uint8_t a = ((adfilter >> (FILTER_SHIFT-1)) & 0x3f); // Lower 6 bits
	uint8_t b = ((adfilter >> (FILTER_SHIFT+5)) & 0x1f); // Upper 5 bits
	uint8_t adfilter_l = adfilter >> 8;

	if ((adfilter_l >= 248) || (adfilter_l <= 8)) 
	     *err = true;
        else *err = false;
	// Interpolate between lookup table points
	for (i = 0; i < 64; i++) 
        {
            if(a <= i) temp += (fahrenheit ? ad_lookup_f[b]   : ad_lookup_c[b]);
	    else       temp += (fahrenheit ? ad_lookup_f[b+1] : ad_lookup_c[b+1]);
	} // for
	return (temp >> 6); // Divide by 64 to get back to normal temperature
} // ad_to_temp()
