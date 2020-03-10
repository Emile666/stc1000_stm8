#line 1 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
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
#line 1 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
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



#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"
/* stdint.h standard header */
/* Copyright 2003-2010 IAR Systems AB.  */




  #pragma system_include


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"
/* ycheck.h internal checking header file. */
/* Copyright 2005-2010 IAR Systems AB. */

/* Note that there is no include guard for this header. This is intentional. */


  #pragma system_include


/* __INTRINSIC
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that intrinsic support could be turned off
 * individually for each file.
 */










/* __STM8ABI_PORTABILITY_INTERNAL_LEVEL
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that ABI support could be turned off/on
 * individually for each file.
 *
 * Possible values for this preprocessor symbol:
 *
 * 0 - ABI portability mode is disabled.
 *
 * 1 - ABI portability mode (version 1) is enabled.
 *
 * All other values are reserved for future use.
 */






#line 67 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"




/* A definiton for a function of what effects it has.
   NS  = no_state, errno, i.e. it uses no internal or external state. It may
         write to errno though
   NE  = no_state, i.e. it uses no internal or external state, not even
         writing to errno. 
   NRx = no_read(x), i.e. it doesn't read through pointer parameter x.
   NWx = no_write(x), i.e. it doesn't write through pointer parameter x.
   Rx  = returns x, i.e. the function will return parameter x.
   
   All the functions with effects also has "always_returns", 
   i.e. the function will always return.
*/

#line 103 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"









#line 11 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"
/* yvals.h internal configuration header file. */
/* Copyright 2001-2010 IAR Systems AB. */





  #pragma system_include


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"
/* ycheck.h internal checking header file. */
/* Copyright 2005-2010 IAR Systems AB. */

/* Note that there is no include guard for this header. This is intentional. */


  #pragma system_include


/* __INTRINSIC
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that intrinsic support could be turned off
 * individually for each file.
 */










/* __STM8ABI_PORTABILITY_INTERNAL_LEVEL
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that ABI support could be turned off/on
 * individually for each file.
 *
 * Possible values for this preprocessor symbol:
 *
 * 0 - ABI portability mode is disabled.
 *
 * 1 - ABI portability mode (version 1) is enabled.
 *
 * All other values are reserved for future use.
 */






#line 67 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"

#line 12 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* Convenience macros */









/* Used to refer to '__stm8abi' symbols in the library. */ 


                /* Versions */










/*
 * Support for some C99 or other symbols
 *
 * This setting makes available some macros, functions, etc that are
 * beneficial.
 *
 * Default is to include them.
 *
 * Disabling this in C++ mode will not compile (some C++ functions uses C99
 * functionality).
 */


  /* Default turned on when compiling C++, EC++, or C99. */
#line 59 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"





#line 70 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* Configuration */
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"
/***************************************************
 *
 * DLib_Defaults.h is the library configuration manager.
 *
 * Copyright 2003-2010 IAR Systems AB.  
 *
 * This configuration header file performs the following tasks:
 *
 * 1. Includes the configuration header file, defined by _DLIB_CONFIG_FILE,
 *    that sets up a particular runtime environment.
 *
 * 2. Includes the product configuration header file, DLib_Product.h, that
 *    specifies default values for the product and makes sure that the
 *    configuration is valid.
 *
 * 3. Sets up default values for all remaining configuration symbols.
 *
 * This configuration header file, the one defined by _DLIB_CONFIG_FILE, and
 * DLib_Product.h configures how the runtime environment should behave. This
 * includes all system headers and the library itself, i.e. all system headers
 * includes this configuration header file, and the library has been built
 * using this configuration header file.
 *
 ***************************************************
 *
 * DO NOT MODIFY THIS FILE!
 *
 ***************************************************/





  #pragma system_include


/* Include the main configuration header file. */
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\LIB\\dlstm8smn.h"
/* Customer-specific DLib configuration. */
/* Copyright (C) 2003 IAR Systems.  All rights reserved. */





  #pragma system_include


/* No changes to the defaults. */

#line 40 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"
  /* _DLIB_CONFIG_FILE_STRING is the quoted variant of above */
#line 47 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"

/* Include the product specific header file. */
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Product.h"
/* STM8-specific DLib configuration. */
/* Copyright 2010 IAR Systems AB.    */
/* $Revision: 3172 $                  */






  #pragma system_include


/*
 * Avoid large data structures and too much precision...
 */


/*
 * Use function pointers directly in difunct table instead of offsets.
 */


/*
 * Use hand coded floating point support functions
 */


/*
 * Use short pointers in float helper funcitons
 */


/*
 * No weak calls in the library
 */


/*
 * Uncomment the following line to enable thread support
 */
/*
#define _DLIB_THREAD_SUPPORT 3
*/



#line 51 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"



/*
 * The remainder of the file sets up defaults for a number of
 * configuration symbols, each corresponds to a feature in the
 * libary.
 *
 * The value of the symbols should either be 1, if the feature should
 * be supported, or 0 if it shouldn't. (Except where otherwise
 * noted.)
 */


/*
 * Small or Large target
 *
 * This define determines whether the target is large or small. It must be 
 * setup in the DLib_Product header or in the compiler itself.
 *
 * For a small target some functionality in the library will not deliver 
 * the best available results. For instance the _accurate variants will not use
 * the extra precision packet for large arguments.
 * 
 */







/*
 * File handling
 *
 * Determines whether FILE descriptors and related functions exists or not.
 * When this feature is selected, i.e. set to 1, then FILE descriptors and
 * related functions (e.g. fprintf, fopen) exist. All files, even stdin,
 * stdout, and stderr will then be handled with a file system mechanism that
 * buffers files before accessing the lowlevel I/O interface (__open, __read,
 * __write, etc).
 *
 * If not selected, i.e. set to 0, then FILE descriptors and related functions
 * (e.g. fprintf, fopen) does not exist. All functions that normally uses
 * stderr will use stdout instead. Functions that uses stdout and stdin (like
 * printf and scanf) will access the lowlevel I/O interface directly (__open,
 * __read, __write, etc), i.e. there will not be any buffering.
 *
 * The default is not to have support for FILE descriptors.
 */





/*
 * Use static buffers for stdout
 *
 * This setting controls whether the stream stdout uses a static 80 bytes
 * buffer or uses a one byte buffer allocated in the file descriptor. This
 * setting is only applicable if the FILE descriptors are enabled above.
 *
 * Default is to use a static 80 byte buffer.
 */





/*
 * Support of locale interface
 *
 * "Locale" is the system in C that support language- and
 * contry-specific settings for a number of areas, including currency
 * symbols, date and time, and multibyte encodings.
 *
 * This setting determines whether the locale interface exist or not.
 * When this feature is selected, i.e. set to 1, the locale interface exist
 * (setlocale, etc). A number of preselected locales can be activated during
 * runtime. The preselected locales and encodings is choosen by defining any
 * number of _LOCALE_USE_xxx and _ENCODING_USE_xxx symbols. The application
 * will start with the "C" locale choosen. (Single byte encoding is always
 * supported in this mode.)
 *
 *
 * If not selected, i.e. set to 0, the locale interface (setlocale, etc) does
 * not exist. One preselected locale and one preselected encoding is then used
 * directly. That locale can not be changed during runtime. The preselected
 * locale and encoding is choosen by defining at most one of _LOCALE_USE_xxx
 * and at most one of _ENCODING_USE_xxx. The default is to use the "C" locale
 * and the single byte encoding, respectively.
 *
 * The default is not to have support for the locale interface with the "C"
 * locale and the single byte encoding.
 *
 * Supported locales
 * -----------------
 * _LOCALE_USE_C                  C standard locale (the default)
 * _LOCALE_USE_POSIX ISO-8859-1   Posix locale
 * _LOCALE_USE_CS_CZ ISO-8859-2   Czech language locale for Czech Republic
 * _LOCALE_USE_DA_DK ISO-8859-1   Danish language locale for Denmark
 * _LOCALE_USE_DA_EU ISO-8859-15  Danish language locale for Europe
 * _LOCALE_USE_DE_AT ISO-8859-1   German language locale for Austria
 * _LOCALE_USE_DE_BE ISO-8859-1   German language locale for Belgium
 * _LOCALE_USE_DE_CH ISO-8859-1   German language locale for Switzerland
 * _LOCALE_USE_DE_DE ISO-8859-1   German language locale for Germany
 * _LOCALE_USE_DE_EU ISO-8859-15  German language locale for Europe
 * _LOCALE_USE_DE_LU ISO-8859-1   German language locale for Luxemburg
 * _LOCALE_USE_EL_EU ISO-8859-7x  Greek language locale for Europe
 *                                (Euro symbol added)
 * _LOCALE_USE_EL_GR ISO-8859-7   Greek language locale for Greece
 * _LOCALE_USE_EN_AU ISO-8859-1   English language locale for Australia
 * _LOCALE_USE_EN_CA ISO-8859-1   English language locale for Canada
 * _LOCALE_USE_EN_DK ISO_8859-1   English language locale for Denmark
 * _LOCALE_USE_EN_EU ISO-8859-15  English language locale for Europe
 * _LOCALE_USE_EN_GB ISO-8859-1   English language locale for United Kingdom
 * _LOCALE_USE_EN_IE ISO-8859-1   English language locale for Ireland
 * _LOCALE_USE_EN_NZ ISO-8859-1   English language locale for New Zealand
 * _LOCALE_USE_EN_US ISO-8859-1   English language locale for USA
 * _LOCALE_USE_ES_AR ISO-8859-1   Spanish language locale for Argentina
 * _LOCALE_USE_ES_BO ISO-8859-1   Spanish language locale for Bolivia
 * _LOCALE_USE_ES_CL ISO-8859-1   Spanish language locale for Chile
 * _LOCALE_USE_ES_CO ISO-8859-1   Spanish language locale for Colombia
 * _LOCALE_USE_ES_DO ISO-8859-1   Spanish language locale for Dominican Republic
 * _LOCALE_USE_ES_EC ISO-8859-1   Spanish language locale for Equador
 * _LOCALE_USE_ES_ES ISO-8859-1   Spanish language locale for Spain
 * _LOCALE_USE_ES_EU ISO-8859-15  Spanish language locale for Europe
 * _LOCALE_USE_ES_GT ISO-8859-1   Spanish language locale for Guatemala
 * _LOCALE_USE_ES_HN ISO-8859-1   Spanish language locale for Honduras
 * _LOCALE_USE_ES_MX ISO-8859-1   Spanish language locale for Mexico
 * _LOCALE_USE_ES_PA ISO-8859-1   Spanish language locale for Panama
 * _LOCALE_USE_ES_PE ISO-8859-1   Spanish language locale for Peru
 * _LOCALE_USE_ES_PY ISO-8859-1   Spanish language locale for Paraguay
 * _LOCALE_USE_ES_SV ISO-8859-1   Spanish language locale for Salvador
 * _LOCALE_USE_ES_US ISO-8859-1   Spanish language locale for USA
 * _LOCALE_USE_ES_UY ISO-8859-1   Spanish language locale for Uruguay
 * _LOCALE_USE_ES_VE ISO-8859-1   Spanish language locale for Venezuela
 * _LOCALE_USE_ET_EE ISO-8859-1   Estonian language for Estonia
 * _LOCALE_USE_EU_ES ISO-8859-1   Basque language locale for Spain
 * _LOCALE_USE_FI_EU ISO-8859-15  Finnish language locale for Europe
 * _LOCALE_USE_FI_FI ISO-8859-1   Finnish language locale for Finland
 * _LOCALE_USE_FO_FO ISO-8859-1   Faroese language locale for Faroe Islands
 * _LOCALE_USE_FR_BE ISO-8859-1   French language locale for Belgium
 * _LOCALE_USE_FR_CA ISO-8859-1   French language locale for Canada
 * _LOCALE_USE_FR_CH ISO-8859-1   French language locale for Switzerland
 * _LOCALE_USE_FR_EU ISO-8859-15  French language locale for Europe
 * _LOCALE_USE_FR_FR ISO-8859-1   French language locale for France
 * _LOCALE_USE_FR_LU ISO-8859-1   French language locale for Luxemburg
 * _LOCALE_USE_GA_EU ISO-8859-15  Irish language locale for Europe
 * _LOCALE_USE_GA_IE ISO-8859-1   Irish language locale for Ireland
 * _LOCALE_USE_GL_ES ISO-8859-1   Galician language locale for Spain
 * _LOCALE_USE_HR_HR ISO-8859-2   Croatian language locale for Croatia
 * _LOCALE_USE_HU_HU ISO-8859-2   Hungarian language locale for Hungary
 * _LOCALE_USE_ID_ID ISO-8859-1   Indonesian language locale for Indonesia
 * _LOCALE_USE_IS_EU ISO-8859-15  Icelandic language locale for Europe
 * _LOCALE_USE_IS_IS ISO-8859-1   Icelandic language locale for Iceland
 * _LOCALE_USE_IT_EU ISO-8859-15  Italian language locale for Europe
 * _LOCALE_USE_IT_IT ISO-8859-1   Italian language locale for Italy
 * _LOCALE_USE_IW_IL ISO-8859-8   Hebrew language locale for Israel
 * _LOCALE_USE_KL_GL ISO-8859-1   Greenlandic language locale for Greenland
 * _LOCALE_USE_LT_LT   BALTIC     Lithuanian languagelocale for Lithuania
 * _LOCALE_USE_LV_LV   BALTIC     Latvian languagelocale for Latvia
 * _LOCALE_USE_NL_BE ISO-8859-1   Dutch language locale for Belgium
 * _LOCALE_USE_NL_EU ISO-8859-15  Dutch language locale for Europe
 * _LOCALE_USE_NL_NL ISO-8859-9   Dutch language locale for Netherlands
 * _LOCALE_USE_NO_EU ISO-8859-15  Norwegian language locale for Europe
 * _LOCALE_USE_NO_NO ISO-8859-1   Norwegian language locale for Norway
 * _LOCALE_USE_PL_PL ISO-8859-2   Polish language locale for Poland
 * _LOCALE_USE_PT_BR ISO-8859-1   Portugese language locale for Brazil
 * _LOCALE_USE_PT_EU ISO-8859-15  Portugese language locale for Europe
 * _LOCALE_USE_PT_PT ISO-8859-1   Portugese language locale for Portugal
 * _LOCALE_USE_RO_RO ISO-8859-2   Romanian language locale for Romania
 * _LOCALE_USE_RU_RU ISO-8859-5   Russian language locale for Russia
 * _LOCALE_USE_SL_SI ISO-8859-2   Slovenian language locale for Slovenia
 * _LOCALE_USE_SV_EU ISO-8859-15  Swedish language locale for Europe
 * _LOCALE_USE_SV_FI ISO-8859-1   Swedish language locale for Finland
 * _LOCALE_USE_SV_SE ISO-8859-1   Swedish language locale for Sweden
 * _LOCALE_USE_TR_TR ISO-8859-9   Turkish language locale for Turkey
 *
 *  Supported encodings
 *  -------------------
 * n/a                            Single byte (used if no other is defined).
 * _ENCODING_USE_UTF8             UTF8 encoding.
 */






/* We need to have the "C" locale if we have full locale support. */






/*
 * Support of multibytes in printf- and scanf-like functions
 *
 * This is the default value for _DLIB_PRINTF_MULTIBYTE and
 * _DLIB_SCANF_MULTIBYTE. See them for a description.
 *
 * Default is to not have support for multibytes in printf- and scanf-like
 * functions.
 */






/*
 * Throw handling in the EC++ library
 *
 * This setting determines what happens when the EC++ part of the library
 * fails (where a normal C++ library 'throws').
 *
 * The following alternatives exists (setting of the symbol):
 * 0                - The application does nothing, i.e. continues with the
 *                    next statement.
 * 1                - The application terminates by calling the 'abort'
 *                    function directly.
 * <anything else>  - An object of class "exception" is created.  This
 *                    object contains a string describing the problem.
 *                    This string is later emitted on "stderr" before
 *                    the application terminates by calling the 'abort'
 *                    function directly.
 *
 * Default is to do nothing.
 */






/*
 * Hexadecimal floating-point numbers in strtod
 *
 * If selected, i.e. set to 1, strtod supports C99 hexadecimal floating-point
 * numbers. This also enables hexadecimal floating-points in internal functions
 * used for converting strings and wide strings to float, double, and long
 * double.
 *
 * If not selected, i.e. set to 0, C99 hexadecimal floating-point numbers
 * aren't supported.
 *
 * Default is not to support hexadecimal floating-point numbers.
 */






/*
 * Printf configuration symbols.
 *
 * All the configuration symbols described further on controls the behaviour
 * of printf, sprintf, and the other printf variants.
 *
 * The library proves four formatters for printf: 'tiny', 'small',
 * 'large', and 'default'.  The setup in this file controls all except
 * 'tiny'.  Note that both small' and 'large' explicitly removes
 * some features.
 */

/*
 * Handle multibytes in printf
 *
 * This setting controls whether multibytes and wchar_ts are supported in
 * printf. Set to 1 to support them, otherwise set to 0.
 *
 * See _DLIB_FORMATTED_MULTIBYTE for the default setting.
 */





/*
 * Long long formatting in printf
 *
 * This setting controls long long support (%lld) in printf. Set to 1 to
 * support it, otherwise set to 0.

 * Note, if long long should not be supported and 'intmax_t' is larger than
 * an ordinary 'long', then %jd and %jn will not be supported.
 *
 * Default is to support long long formatting.
 */

#line 351 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"






/*
 * Floating-point formatting in printf
 *
 * This setting controls whether printf supports floating-point formatting.
 * Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support floating-point formatting.
 */





/*
 * Hexadecimal floating-point formatting in printf
 *
 * This setting controls whether the %a format, i.e. the output of
 * floating-point numbers in the C99 hexadecimal format. Set to 1 to support
 * it, otherwise set to 0.
 *
 * Default is to support %a in printf.
 */





/*
 * Output count formatting in printf
 *
 * This setting controls whether the output count specifier (%n) is supported
 * or not in printf. Set to 1 to support it, otherwise set to 0.
 *
 * Default is to support %n in printf.
 */





/*
 * Support of qualifiers in printf
 *
 * This setting controls whether qualifiers that enlarges the input value
 * [hlLjtz] is supported in printf or not. Set to 1 to support them, otherwise
 * set to 0. See also _DLIB_PRINTF_INT_TYPE_IS_INT and
 * _DLIB_PRINTF_INT_TYPE_IS_LONG.
 *
 * Default is to support [hlLjtz] qualifiers in printf.
 */





/*
 * Support of flags in printf
 *
 * This setting controls whether flags (-+ #0) is supported in printf or not.
 * Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support flags in printf.
 */





/*
 * Support widths and precisions in printf
 *
 * This setting controls whether widths and precisions are supported in printf.
 * Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support widths and precisions in printf.
 */





/*
 * Support of unsigned integer formatting in printf
 *
 * This setting controls whether unsigned integer formatting is supported in
 * printf. Set to 1 to support it, otherwise set to 0.
 *
 * Default is to support unsigned integer formatting in printf.
 */





/*
 * Support of signed integer formatting in printf
 *
 * This setting controls whether signed integer formatting is supported in
 * printf. Set to 1 to support it, otherwise set to 0.
 *
 * Default is to support signed integer formatting in printf.
 */





/*
 * Support of formatting anything larger than int in printf
 *
 * This setting controls if 'int' should be used internally in printf, rather
 * than the largest existing integer type. If 'int' is used, any integer or
 * pointer type formatting use 'int' as internal type even though the
 * formatted type is larger. Set to 1 to use 'int' as internal type, otherwise
 * set to 0.
 *
 * See also next configuration.
 *
 * Default is to internally use largest existing internally type.
 */





/*
 * Support of formatting anything larger than long in printf
 *
 * This setting controls if 'long' should be used internally in printf, rather
 * than the largest existing integer type. If 'long' is used, any integer or
 * pointer type formatting use 'long' as internal type even though the
 * formatted type is larger. Set to 1 to use 'long' as internal type,
 * otherwise set to 0.
 *
 * See also previous configuration.
 *
 * Default is to internally use largest existing internally type.
 */









/*
 * Emit a char a time in printf
 *
 * This setting controls internal output handling. If selected, i.e. set to 1,
 * then printf emits one character at a time, which requires less code but
 * can be slightly slower for some types of output.
 *
 * If not selected, i.e. set to 0, then printf buffers some outputs.
 *
 * Note that it is recommended to either use full file support (see
 * _DLIB_FILE_DESCRIPTOR) or -- for debug output -- use the linker
 * option "-e__write_buffered=__write" to enable buffered I/O rather
 * than deselecting this feature.
 */






/*
 * Scanf configuration symbols.
 *
 * All the configuration symbols described here controls the
 * behaviour of scanf, sscanf, and the other scanf variants.
 *
 * The library proves three formatters for scanf: 'small', 'large',
 * and 'default'.  The setup in this file controls all, however both
 * 'small' and 'large' explicitly removes some features.
 */

/*
 * Handle multibytes in scanf
 *
 * This setting controls whether multibytes and wchar_t:s are supported in
 * scanf. Set to 1 to support them, otherwise set to 0.
 *
 * See _DLIB_FORMATTED_MULTIBYTE for the default.
 */





/*
 * Long long formatting in scanf
 *
 * This setting controls whether scanf supports long long support (%lld). It
 * also controls, if 'intmax_t' is larger than an ordinary 'long', i.e. how
 * the %jd and %jn specifiers behaves. Set to 1 to support them, otherwise set
 * to 0.
 *
 * Default is to support long long formatting in scanf.
 */

#line 566 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"





/*
 * Support widths in scanf
 *
 * This controls whether scanf supports widths. Set to 1 to support them,
 * otherwise set to 0.
 *
 * Default is to support widths in scanf.
 */





/*
 * Support qualifiers [hjltzL] in scanf
 *
 * This setting controls whether scanf supports qualifiers [hjltzL] or not. Set
 * to 1 to support them, otherwise set to 0.
 *
 * Default is to support qualifiers in scanf.
 */





/*
 * Support floating-point formatting in scanf
 *
 * This setting controls whether scanf supports floating-point formatting. Set
 * to 1 to support them, otherwise set to 0.
 *
 * Default is to support floating-point formatting in scanf.
 */





/*
 * Support output count formatting (%n)
 *
 * This setting controls whether scanf supports output count formatting (%n).
 * Set to 1 to support it, otherwise set to 0.
 *
 * Default is to support output count formatting in scanf.
 */





/*
 * Support scansets ([]) in scanf
 *
 * This setting controls whether scanf supports scansets ([]) or not. Set to 1
 * to support them, otherwise set to 0.
 *
 * Default is to support scansets in scanf.
 */





/*
 * Support signed integer formatting in scanf
 *
 * This setting controls whether scanf supports signed integer formatting or
 * not. Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support signed integer formatting in scanf.
 */





/*
 * Support unsigned integer formatting in scanf
 *
 * This setting controls whether scanf supports unsigned integer formatting or
 * not. Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support unsigned integer formatting in scanf.
 */





/*
 * Support assignment suppressing [*] in scanf
 *
 * This setting controls whether scanf supports assignment suppressing [*] or
 * not. Set to 1 to support them, otherwise set to 0.
 *
 * Default is to support assignment suppressing in scanf.
 */





/*
 * Handle multibytes in asctime and strftime.
 *
 * This setting controls whether multibytes and wchar_ts are
 * supported.Set to 1 to support them, otherwise set to 0.
 *
 * See _DLIB_FORMATTED_MULTIBYTE for the default setting.
 */





/*
 * True if "qsort" should be implemented using bubble sort.
 *
 * Bubble sort is less efficient than quick sort but requires less RAM
 * and ROM resources.
 */





/*
 * Set Buffert size used in qsort
 */





/*
 * The default "rand" function uses an array of 32 long:s of memory to
 * store the current state.
 *
 * The simple "rand" function uses only a single long. However, the
 * quality of the generated psuedo-random numbers are not as good as
 * the default implementation.
 */





/*
 * Wide character and multi byte character support in library.
 */





/*
 * Set attributes on the function used by the C-SPY debug interface to set a
 * breakpoint in.
 */





/*
 * Support threading in the library
 *
 * 0    No thread support
 * 1    Thread support with a, b, and d.
 * 2    Thread support with a, b, and e.
 * 3    Thread support with all thread-local storage in a dynamically allocated
 *        memory area and a, and b.
 *      a. Lock on heap accesses
 *      b. Optional lock on file accesses (see _DLIB_FILE_OP_LOCKS below)
 *      d. Use an external thread-local storage interface for all the
 *         libraries static and global variables.
 *      e. Static and global variables aren't safe for access from several
 *         threads.
 *
 * Note that if locks are used the following symbols must be defined:
 *
 *   _DLIB_THREAD_LOCK_ONCE_TYPE
 *   _DLIB_THREAD_LOCK_ONCE_MACRO(control_variable, init_function)
 *   _DLIB_THREAD_LOCK_ONCE_TYPE_INIT
 *
 * They will be used to initialize the needed locks only once. TYPE is the
 * type for the static control variable, MACRO is the expression that will be
 * evaluated at each usage of a lock, and INIT is the initializer for the
 * control variable.
 *
 * Note that if thread model 3 is used the symbol _DLIB_TLS_POINTER must be
 * defined. It is a thread local pointer to a dynamic memory area that
 * contains all used TLS variables for the library. Optionally the following
 * symbols can be defined as well (default is to use the default const data
 * and data memories):
 *
 *   _DLIB_TLS_INITIALIZER_MEMORY The memory to place the initializers for the
 *                                TLS memory area
 *   _DLIB_TLS_MEMORY             The memory to use for the TLS memory area. A
 *                                pointer to this memory must be castable to a
 *                                default pointer and back.
 *   _DLIB_TLS_REQUIRE_INIT       Set to 1 to require __cstart_init_tls
 *                                when needed to initialize the TLS data
 *                                segment for the main thread.
 *   _DLIB_TLS_SEGMENT_DATA       The name of the TLS RAM data segment
 *   _DLIB_TLS_SEGMENT_INIT       The name of the used to initialize the
 *                                TLS data segment.
 *
 * See DLib_Threads.h for a description of what interfaces needs to be
 * defined for thread support.
 */





/*
 * Used by products where one runtime library can be used by applications
 * with different data models, in order to reduce the total number of
 * libraries required. Typically, this is used when the pointer types does
 * not change over the data models used, but the placement of data variables
 * or/and constant variables do.
 *
 * If defined, this symbol is typically defined to the memory attribute that
 * is used by the runtime library. The actual define must use a
 * _Pragma("type_attribute = xxx") construct. In the header files, it is used
 * on all statically linked data objects seen by the application.
 */




#line 812 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"


/*
 * Turn on support for the Target-specific ABI. The ABI is based on the
 * ARM AEABI. A target, except ARM, may deviate from it.
 */

#line 826 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"


  /* Possible AEABI deviations */
#line 836 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"

#line 844 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"
  /*
   * The "difunc" table contains information about C++ objects that
   * should be dynamically initialized, where each entry in the table
   * represents an initialization function that should be called. When
   * the symbol _DLIB_STM8ABI_DIFUNC_CONTAINS_OFFSETS is true, each
   * entry in the table is encoded as an offset from the entry
   * location. When false, the entries contain the actual addresses to
   * call.
   */






/*
 * Turn on usage of a pragma to tell the linker the number of elements used
 * in a setjmp jmp_buf.
 */





/*
 * If true, the product supplies a "DLib_Product_string.h" file that
 * is included from "string.h".
 */





/*
 * Determine whether the math fma routines are fast or not.
 */




/*
 * Rtti support.
 */

#line 899 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"

/*
 * Use the "pointers to short" or "pointers to long" implementation of 
 * the basic floating point routines (like Dnorm, Dtest, Dscale, and Dunscale).
 */




/*
 * Use 64-bit long long as intermediary type in Dtest, and fabs.
 * Default is to do this if long long is 64-bits.
 */




/*
 * Favor speed versus some size enlargements in floating point functions.
 */




/*
 * Include dlmalloc as an alternative heap manager in product.
 *
 * Typically, an application will use a "malloc" heap manager that is
 * relatively small but not that efficient. An application can
 * optionally use the "dlmalloc" package, which provides a more
 * effective "malloc" heap manager, if it is included in the product
 * and supported by the settings.
 *
 * See the product documentation on how to use it, and whether or not
 * it is included in the product.
 */

  /* size_t/ptrdiff_t must be a 4 bytes unsigned integer. */
#line 943 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"





/*
 * Allow the 64-bit time_t interface?
 *
 * Default is yes if long long is 64 bits.
 */

  #pragma language = save 
  #pragma language = extended





  #pragma language = restore






/*
 * Is time_t 64 or 32 bits?
 *
 * Default is 32 bits.
 */




/*
 * Do we include math functions that demands lots of constant bytes?
 * (like erf, erfc, expm1, fma, lgamma, tgamma, and *_accurate)
 *
 */




/*
 * Set this to __weak, if supported.
 *
 */
#line 997 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Defaults.h"


/*
 * Deleted options
 *
 */







#line 73 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"











                /* Floating-point */

/*
 * Whenever a floating-point type is equal to another, we try to fold those
 * two types into one. This means that if float == double then we fold float to
 * use double internally. Example sinf(float) will use _Sin(double, uint).
 *
 * _X_FNAME is a redirector for internal support routines. The X can be
 *          D (double), F (float), or L (long double). It redirects by using
 *          another prefix. Example calls to Dtest will be __iar_Dtest,
 *          __iar_FDtest, or __iarLDtest.
 * _X_FUN   is a redirector for functions visible to the customer. As above, the
 *          X can be D, F, or L. It redirects by using another suffix. Example
 *          calls to sin will be sin, sinf, or sinl.
 * _X_TYPE  The type that one type is folded to.
 * _X_PTRCAST is a redirector for a cast operation involving a pointer.
 * _X_CAST  is a redirector for a cast involving the float type.
 *
 * _FLOAT_IS_DOUBLE signals that all internal float routines aren't needed.
 * _LONG_DOUBLE_IS_DOUBLE signals that all internal long double routines
 *                        aren't needed.
 */
#line 147 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"





                /* NAMING PROPERTIES */


/* Has support for fixed point types */




/* Has support for secure functions (printf_s, scanf_s, etc) */
/* Will not compile if enabled */
#line 170 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

/* Has support for complex C types */




/* If is Embedded C++ language */






/* If is true C++ language */






/* True C++ language setup */
#line 233 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"











                /* NAMESPACE CONTROL */
#line 292 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"









#line 308 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"








#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\xencoding_limits.h"
/* xencoding_limits.h internal header file */
/* Copyright 2003-2010 IAR Systems AB.  */





  #pragma system_include


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"
/* ycheck.h internal checking header file. */
/* Copyright 2005-2010 IAR Systems AB. */

/* Note that there is no include guard for this header. This is intentional. */


  #pragma system_include


/* __INTRINSIC
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that intrinsic support could be turned off
 * individually for each file.
 */










/* __STM8ABI_PORTABILITY_INTERNAL_LEVEL
 *
 * Note: Redefined each time ycheck.h is included, i.e. for each
 * system header, to ensure that ABI support could be turned off/on
 * individually for each file.
 *
 * Possible values for this preprocessor symbol:
 *
 * 0 - ABI portability mode is disabled.
 *
 * 1 - ABI portability mode (version 1) is enabled.
 *
 * All other values are reserved for future use.
 */






#line 67 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\ycheck.h"

#line 12 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\xencoding_limits.h"
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"
/* yvals.h internal configuration header file. */
/* Copyright 2001-2010 IAR Systems AB. */

#line 711 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 13 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\xencoding_limits.h"

                                /* Multibyte encoding length. */


#line 24 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\xencoding_limits.h"




#line 42 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\xencoding_limits.h"

                                /* Utility macro */














#line 317 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"



                /* FLOATING-POINT PROPERTIES */

                /* float properties */
#line 335 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* double properties */
#line 360 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* long double properties */
                /* (must be same as double) */




#line 382 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"


                /* INTEGER PROPERTIES */

                                /* MB_LEN_MAX */







  #pragma language=save
  #pragma language=extended
  typedef long long _Longlong;
  typedef unsigned long long _ULonglong;
  #pragma language=restore
#line 405 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"






  typedef unsigned short int _Wchart;
  typedef unsigned short int _Wintt;


#line 424 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

#line 432 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* POINTER PROPERTIES */


typedef signed short int  _Ptrdifft;
typedef unsigned short int     _Sizet;

/* IAR doesn't support restrict  */


                /* stdarg PROPERTIES */






/* This struct definition must not be inside namespace std, or
   overloading will be wrong in full C++ */
  typedef struct __va_list
  {
    char  *_Ap;
  } __va_list;

  typedef __va_list __Va_list;





__intrinsic __nounwind void __iar_Atexit(void (*)(void));


#line 475 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"
  typedef struct
  {       /* state of a multibyte translation */
    unsigned long _Wchar;      /* Used as an intermediary value (up to 32-bits) */
    unsigned long _State;      /* Used as a state value (only some bits used) */
  } _Mbstatet;











typedef struct
{       /* file position */

  _Longlong _Off;    /* can be system dependent */



  _Mbstatet _Wstate;
} _Fpost;







                /* THREAD AND LOCALE CONTROL */

#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Threads.h"
/***************************************************
 *
 * DLib_Threads.h is the library threads manager.
 *
 * Copyright 2004-2010 IAR Systems AB.  
 *
 * This configuration header file sets up how the thread support in the library
 * should work.
 *
 ***************************************************
 *
 * DO NOT MODIFY THIS FILE!
 *
 ***************************************************/





  #pragma system_include


/*
 * DLib can support a multithreaded environment. The preprocessor symbol 
 * _DLIB_THREAD_SUPPORT governs the support. It can be 0 (no support), 
 * 1 (currently not supported), 2 (locks only), and 3 (simulated TLS and locks).
 */

/*
 * This header sets the following symbols that governs the rest of the
 * library:
 * ------------------------------------------
 * _DLIB_MULTI_THREAD     0 No thread support
 *                        1 Multithread support
 * _DLIB_GLOBAL_VARIABLES 0 Use external TLS interface for the libraries global
 *                          and static variables
 *                        1 Use a lock for accesses to the locale and no 
 *                          security for accesses to other global and static
 *                          variables in the library
 * _DLIB_FILE_OP_LOCKS    0 No file-atomic locks
 *                        1 File-atomic locks

 * _DLIB_COMPILER_TLS     0 No Thread-Local-Storage support in the compiler
 *                        1 Thread-Local-Storage support in the compiler
 * _DLIB_TLS_QUAL         The TLS qualifier, define only if _COMPILER_TLS == 1
 *
 * _DLIB_THREAD_MACRO_SETUP_DONE Whether to use the standard definitions of
 *                               TLS macros defined in xtls.h or the definitions
 *                               are provided here.
 *                        0 Use default macros
 *                        1 Macros defined for xtls.h
 *
 * _DLIB_THREAD_LOCK_ONCE_TYPE
 *                        type for control variable in once-initialization of 
 *                        locks
 * _DLIB_THREAD_LOCK_ONCE_MACRO(control_variable, init_function)
 *                        expression that will be evaluated at each lock access
 *                        to determine if an initialization must be done
 * _DLIB_THREAD_LOCK_ONCE_TYPE_INIT
 *                        initial value for the control variable
 *
 ****************************************************************************
 * Description
 * -----------
 *
 * If locks are to be used (_DLIB_MULTI_THREAD != 0), the following options
 * has to be used in ilink: 
 *   --redirect __iar_Locksyslock=__iar_Locksyslock_mtx
 *   --redirect __iar_Unlocksyslock=__iar_Unlocksyslock_mtx
 *   --redirect __iar_Lockfilelock=__iar_Lockfilelock_mtx
 *   --redirect __iar_Unlockfilelock=__iar_Unlockfilelock_mtx
 *   --keep     __iar_Locksyslock_mtx
 * and, if C++ is used, also:
 *   --redirect __iar_Initdynamicfilelock=__iar_Initdynamicfilelock_mtx
 *   --redirect __iar_Dstdynamicfilelock=__iar_Dstdynamicfilelock_mtx
 *   --redirect __iar_Lockdynamicfilelock=__iar_Lockdynamicfilelock_mtx
 *   --redirect __iar_Unlockdynamicfilelock=__iar_Unlockdynamicfilelock_mtx
 * Xlink uses similar options (-e and -g). The following lock interface must
 * also be implemented: 
 *   typedef void *__iar_Rmtx;                   // Lock info object
 *
 *   void __iar_system_Mtxinit(__iar_Rmtx *);    // Initialize a system lock
 *   void __iar_system_Mtxdst(__iar_Rmtx *);     // Destroy a system lock
 *   void __iar_system_Mtxlock(__iar_Rmtx *);    // Lock a system lock
 *   void __iar_system_Mtxunlock(__iar_Rmtx *);  // Unlock a system lock
 * The interface handles locks for the heap, the locale, the file system
 * structure, the initialization of statics in functions, etc. 
 *
 * The following lock interface is optional to be implemented:
 *   void __iar_file_Mtxinit(__iar_Rmtx *);    // Initialize a file lock
 *   void __iar_file_Mtxdst(__iar_Rmtx *);     // Destroy a file lock
 *   void __iar_file_Mtxlock(__iar_Rmtx *);    // Lock a file lock
 *   void __iar_file_Mtxunlock(__iar_Rmtx *);  // Unlock a file lock
 * The interface handles locks for each file stream.
 * 
 * These three once-initialization symbols must also be defined, if the 
 * default initialization later on in this file doesn't work (done in 
 * DLib_product.h):
 *
 *   _DLIB_THREAD_LOCK_ONCE_TYPE
 *   _DLIB_THREAD_LOCK_ONCE_MACRO(control_variable, init_function)
 *   _DLIB_THREAD_LOCK_ONCE_TYPE_INIT
 *
 * If an external TLS interface is used, the following must
 * be defined:
 *   typedef int __iar_Tlskey_t;
 *   typedef void (*__iar_Tlsdtor_t)(void *);
 *   int __iar_Tlsalloc(__iar_Tlskey_t *, __iar_Tlsdtor_t); 
 *                                                    // Allocate a TLS element
 *   int __iar_Tlsfree(__iar_Tlskey_t);               // Free a TLS element
 *   int __iar_Tlsset(__iar_Tlskey_t, void *);        // Set a TLS element
 *   void *__iar_Tlsget(__iar_Tlskey_t);              // Get a TLS element
 *
 */

/* We don't have a compiler that supports tls declarations */





  /* No support for threading. */





#line 296 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Threads.h"

  
  typedef void *__iar_Rmtx;
  
#line 326 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Threads.h"



#line 348 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\DLib_Threads.h"












#line 510 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

#line 520 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* THREAD-LOCAL STORAGE */
#line 528 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"


                /* MULTITHREAD PROPERTIES */
#line 568 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* LOCK MACROS */
#line 576 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

#line 694 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"

                /* MISCELLANEOUS MACROS AND FUNCTIONS*/





#line 709 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\yvals.h"



/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 12 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"


/* Fixed size types. These are all optional. */

  typedef signed char   int8_t;
  typedef unsigned char uint8_t;



  typedef signed int   int16_t;
  typedef unsigned int uint16_t;



  typedef signed long int   int32_t;
  typedef unsigned long int uint32_t;


#line 37 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/* Types capable of holding at least a certain number of bits.
   These are not optional for the sizes 8, 16, 32, 64. */
typedef signed char   int_least8_t;
typedef unsigned char uint_least8_t;

typedef signed int   int_least16_t;
typedef unsigned int uint_least16_t;

typedef signed long int   int_least32_t;
typedef unsigned long int uint_least32_t;

/* This isn't really optional, but make it so for now. */
#line 62 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/* The fastest type holding at least a certain number of bits.
   These are not optional for the size 8, 16, 32, 64.
   For now, the 64 bit size is optional in IAR compilers. */
typedef signed char   int_fast8_t;
typedef unsigned char uint_fast8_t;

typedef signed int   int_fast16_t;
typedef unsigned int uint_fast16_t;

typedef signed long int   int_fast32_t;
typedef unsigned long int uint_fast32_t;

#line 87 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/* The integer type capable of holding the largest number of bits. */
#pragma language=save
#pragma language=extended
typedef signed long int   intmax_t;
typedef unsigned long int uintmax_t;
#pragma language=restore

/* An integer type large enough to be able to hold a pointer.
   This is optional, but always supported in IAR compilers. */
typedef signed short int   intptr_t;
typedef unsigned short int uintptr_t;

/* An integer capable of holding a pointer to a specific memory type. */



typedef signed char __tiny_intptr_t; typedef unsigned char __tiny_uintptr_t; typedef short int __near_intptr_t; typedef unsigned short int __near_uintptr_t; typedef long int __far_intptr_t; typedef unsigned long int __far_uintptr_t; typedef long int __huge_intptr_t; typedef unsigned long int __huge_uintptr_t; typedef short int __eeprom_intptr_t; typedef unsigned short int __eeprom_uintptr_t;


/* Minimum and maximum limits. */






























































































/* Macros expanding to integer constants. */

































#line 258 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 33 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdbool.h"
/* stdbool.h header */
/* Copyright 2003-2010 IAR Systems AB.  */

/* NOTE: IAR Extensions must be enabled in order to use the bool type! */





  #pragma system_include















/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 34 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\intrinsics.h"
/**************************************************
 *
 * Intrinsic functions.
 *
 * Copyright 2010 IAR Systems AB.
 *
 * $Revision: 2677 $
 *
 **************************************************/





  #pragma system_include


#pragma language=save
#pragma language=extended


/*
 * The return type of "__get_interrupt_state".
 */

typedef unsigned char __istate_t;






  __intrinsic void __enable_interrupt(void);     /* RIM */
  __intrinsic void __disable_interrupt(void);    /* SIM */

  __intrinsic __istate_t __get_interrupt_state(void);
  __intrinsic void       __set_interrupt_state(__istate_t);

  /* Special instruction intrinsics */
  __intrinsic void __no_operation(void);         /* NOP */
  __intrinsic void __halt(void);                 /* HALT */
  __intrinsic void __trap(void);                 /* TRAP */
  __intrinsic void __wait_for_event(void);       /* WFE */
  __intrinsic void __wait_for_interrupt(void);   /* WFI */

  /* Bit manipulation */
  __intrinsic void __BCPL(unsigned char __near *, unsigned char);
  __intrinsic void __BRES(unsigned char __near *, unsigned char);
  __intrinsic void __BSET(unsigned char __near *, unsigned char);






#pragma language=restore

#line 35 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
#line 1 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"
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



// #include <iostm8s003f3.h> for stock STC1000 PCB
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"
/*-------------------------------------------------------------------------
 *      STM8 definitions of SFR registers
 *
 *      Used with STM8 IAR C/C++ Compiler and Assembler.
 *
 *      Copyright 2017 IAR Systems AB.
 *
 *-----------------------------------------------------------------------*/








/*-------------------------------------------------------------------------
 *      I/O register macros
 *-----------------------------------------------------------------------*/

#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\io_macros.h"
/*-------------------------------------------------------------------------
 *      Common SFR macro declarations used for
 *      STM8 IAR C/C++ Compiler and Assembler.
 *
 *      Copyright 2012 IAR Systems AB.
 *
 *
 *-------------------------------------------------------------------------*/




#pragma system_include

/*---------------------------------------------
 *          C/EC++ specific macros
 *--------------------------------------------*/



/*---------------------------------------------
 *          I/O reg attributes
 *--------------------------------------------*/
#line 31 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\io_macros.h"

/*---------------------------------------------
 * Define NAME as an I/O 8 bit reg
 * Access of 8 bit reg:  NAME
 *--------------------------------------------*/



/*---------------------------------------------
 * Define NAME as an I/O reg with bit access
 * Access of 8 bit reg:  NAME
 * Access of bit(s):     NAME_bit.noXX
 *--------------------------------------------*/
#line 50 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\io_macros.h"



/*---------------------------------------------
 *          Assembler specific macros
 *--------------------------------------------*/

#line 79 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\io_macros.h"

#line 22 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



#pragma system_include
#pragma language=save
#pragma language=extended


/*-------------------------------------------------------------------------
 *      Option byte attribute define
 *-----------------------------------------------------------------------*/
 

 
/*-------------------------------------------------------------------------
 *      Option bytes register definitions
 *-----------------------------------------------------------------------*/

/*-------------------------------------------------------------------------
 *      Option bytes addresses
 *-----------------------------------------------------------------------*/
#line 54 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 66 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port A register definitions
 *-----------------------------------------------------------------------*/
/* Port A data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PA_ODR;

__near __no_init volatile  union { unsigned char PA_ODR; __BITS_PA_ODR PA_ODR_bit; } @ 0x5000;;

/* Port A input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PA_IDR;

__near __no_init volatile const union { unsigned char PA_IDR; __BITS_PA_IDR PA_IDR_bit; } @ 0x5001;;

/* Port A data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PA_DDR;

__near __no_init volatile  union { unsigned char PA_DDR; __BITS_PA_DDR PA_DDR_bit; } @ 0x5002;;

/* Port A control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PA_CR1;

__near __no_init volatile  union { unsigned char PA_CR1; __BITS_PA_CR1 PA_CR1_bit; } @ 0x5003;;

/* Port A control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PA_CR2;

__near __no_init volatile  union { unsigned char PA_CR2; __BITS_PA_CR2 PA_CR2_bit; } @ 0x5004;;


/*-------------------------------------------------------------------------
 *      Port A bit fields
 *-----------------------------------------------------------------------*/


#line 165 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 174 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 183 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 192 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 201 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port A bit masks
 *-----------------------------------------------------------------------*/
#line 215 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 224 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 233 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 242 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 251 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port B register definitions
 *-----------------------------------------------------------------------*/
/* Port B data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PB_ODR;

__near __no_init volatile  union { unsigned char PB_ODR; __BITS_PB_ODR PB_ODR_bit; } @ 0x5005;;

/* Port B input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PB_IDR;

__near __no_init volatile const union { unsigned char PB_IDR; __BITS_PB_IDR PB_IDR_bit; } @ 0x5006;;

/* Port B data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PB_DDR;

__near __no_init volatile  union { unsigned char PB_DDR; __BITS_PB_DDR PB_DDR_bit; } @ 0x5007;;

/* Port B control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PB_CR1;

__near __no_init volatile  union { unsigned char PB_CR1; __BITS_PB_CR1 PB_CR1_bit; } @ 0x5008;;

/* Port B control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PB_CR2;

__near __no_init volatile  union { unsigned char PB_CR2; __BITS_PB_CR2 PB_CR2_bit; } @ 0x5009;;


/*-------------------------------------------------------------------------
 *      Port B bit fields
 *-----------------------------------------------------------------------*/


#line 350 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 359 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 368 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 377 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 386 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port B bit masks
 *-----------------------------------------------------------------------*/
#line 400 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 409 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 418 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 427 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 436 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port C register definitions
 *-----------------------------------------------------------------------*/
/* Port C data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PC_ODR;

__near __no_init volatile  union { unsigned char PC_ODR; __BITS_PC_ODR PC_ODR_bit; } @ 0x500A;;

/* Port C input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PC_IDR;

__near __no_init volatile const union { unsigned char PC_IDR; __BITS_PC_IDR PC_IDR_bit; } @ 0x500B;;

/* Port C data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PC_DDR;

__near __no_init volatile  union { unsigned char PC_DDR; __BITS_PC_DDR PC_DDR_bit; } @ 0x500C;;

/* Port C control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PC_CR1;

__near __no_init volatile  union { unsigned char PC_CR1; __BITS_PC_CR1 PC_CR1_bit; } @ 0x500D;;

/* Port C control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PC_CR2;

__near __no_init volatile  union { unsigned char PC_CR2; __BITS_PC_CR2 PC_CR2_bit; } @ 0x500E;;


/*-------------------------------------------------------------------------
 *      Port C bit fields
 *-----------------------------------------------------------------------*/


#line 535 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 544 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 553 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 562 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 571 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port C bit masks
 *-----------------------------------------------------------------------*/
#line 585 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 594 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 603 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 612 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 621 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port D register definitions
 *-----------------------------------------------------------------------*/
/* Port D data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PD_ODR;

__near __no_init volatile  union { unsigned char PD_ODR; __BITS_PD_ODR PD_ODR_bit; } @ 0x500F;;

/* Port D input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PD_IDR;

__near __no_init volatile const union { unsigned char PD_IDR; __BITS_PD_IDR PD_IDR_bit; } @ 0x5010;;

/* Port D data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PD_DDR;

__near __no_init volatile  union { unsigned char PD_DDR; __BITS_PD_DDR PD_DDR_bit; } @ 0x5011;;

/* Port D control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PD_CR1;

__near __no_init volatile  union { unsigned char PD_CR1; __BITS_PD_CR1 PD_CR1_bit; } @ 0x5012;;

/* Port D control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PD_CR2;

__near __no_init volatile  union { unsigned char PD_CR2; __BITS_PD_CR2 PD_CR2_bit; } @ 0x5013;;


/*-------------------------------------------------------------------------
 *      Port D bit fields
 *-----------------------------------------------------------------------*/


#line 720 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 729 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 738 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 747 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 756 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port D bit masks
 *-----------------------------------------------------------------------*/
#line 770 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 779 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 788 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 797 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 806 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port E register definitions
 *-----------------------------------------------------------------------*/
/* Port E data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PE_ODR;

__near __no_init volatile  union { unsigned char PE_ODR; __BITS_PE_ODR PE_ODR_bit; } @ 0x5014;;

/* Port E input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PE_IDR;

__near __no_init volatile const union { unsigned char PE_IDR; __BITS_PE_IDR PE_IDR_bit; } @ 0x5015;;

/* Port E data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PE_DDR;

__near __no_init volatile  union { unsigned char PE_DDR; __BITS_PE_DDR PE_DDR_bit; } @ 0x5016;;

/* Port E control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PE_CR1;

__near __no_init volatile  union { unsigned char PE_CR1; __BITS_PE_CR1 PE_CR1_bit; } @ 0x5017;;

/* Port E control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PE_CR2;

__near __no_init volatile  union { unsigned char PE_CR2; __BITS_PE_CR2 PE_CR2_bit; } @ 0x5018;;


/*-------------------------------------------------------------------------
 *      Port E bit fields
 *-----------------------------------------------------------------------*/


#line 905 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 914 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 923 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 932 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 941 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port E bit masks
 *-----------------------------------------------------------------------*/
#line 955 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 964 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 973 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 982 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 991 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Port F register definitions
 *-----------------------------------------------------------------------*/
/* Port F data output latch register */

typedef struct
{
  unsigned char ODR0        : 1;
  unsigned char ODR1        : 1;
  unsigned char ODR2        : 1;
  unsigned char ODR3        : 1;
  unsigned char ODR4        : 1;
  unsigned char ODR5        : 1;
  unsigned char ODR6        : 1;
  unsigned char ODR7        : 1;
} __BITS_PF_ODR;

__near __no_init volatile  union { unsigned char PF_ODR; __BITS_PF_ODR PF_ODR_bit; } @ 0x5019;;

/* Port F input pin value register */

typedef struct
{
  unsigned char IDR0        : 1;
  unsigned char IDR1        : 1;
  unsigned char IDR2        : 1;
  unsigned char IDR3        : 1;
  unsigned char IDR4        : 1;
  unsigned char IDR5        : 1;
  unsigned char IDR6        : 1;
  unsigned char IDR7        : 1;
} __BITS_PF_IDR;

__near __no_init volatile const union { unsigned char PF_IDR; __BITS_PF_IDR PF_IDR_bit; } @ 0x501A;;

/* Port F data direction register */

typedef struct
{
  unsigned char DDR0        : 1;
  unsigned char DDR1        : 1;
  unsigned char DDR2        : 1;
  unsigned char DDR3        : 1;
  unsigned char DDR4        : 1;
  unsigned char DDR5        : 1;
  unsigned char DDR6        : 1;
  unsigned char DDR7        : 1;
} __BITS_PF_DDR;

__near __no_init volatile  union { unsigned char PF_DDR; __BITS_PF_DDR PF_DDR_bit; } @ 0x501B;;

/* Port F control register 1 */

typedef struct
{
  unsigned char C10         : 1;
  unsigned char C11         : 1;
  unsigned char C12         : 1;
  unsigned char C13         : 1;
  unsigned char C14         : 1;
  unsigned char C15         : 1;
  unsigned char C16         : 1;
  unsigned char C17         : 1;
} __BITS_PF_CR1;

__near __no_init volatile  union { unsigned char PF_CR1; __BITS_PF_CR1 PF_CR1_bit; } @ 0x501C;;

/* Port F control register 2 */

typedef struct
{
  unsigned char C20         : 1;
  unsigned char C21         : 1;
  unsigned char C22         : 1;
  unsigned char C23         : 1;
  unsigned char C24         : 1;
  unsigned char C25         : 1;
  unsigned char C26         : 1;
  unsigned char C27         : 1;
} __BITS_PF_CR2;

__near __no_init volatile  union { unsigned char PF_CR2; __BITS_PF_CR2 PF_CR2_bit; } @ 0x501D;;


/*-------------------------------------------------------------------------
 *      Port F bit fields
 *-----------------------------------------------------------------------*/


#line 1090 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1099 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1108 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1117 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1126 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      Port F bit masks
 *-----------------------------------------------------------------------*/
#line 1140 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1149 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1158 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1167 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1176 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      Flash register definitions
 *-----------------------------------------------------------------------*/
/* Flash control register 1 */

typedef struct
{
  unsigned char FIX         : 1;
  unsigned char IE          : 1;
  unsigned char AHALT       : 1;
  unsigned char HALT        : 1;
} __BITS_FLASH_CR1;

__near __no_init volatile  union { unsigned char FLASH_CR1; __BITS_FLASH_CR1 FLASH_CR1_bit; } @ 0x505A;;

/* Flash control register 2 */

typedef struct
{
  unsigned char PRG         : 1;
  unsigned char             : 3;
  unsigned char FPRG        : 1;
  unsigned char ERASE       : 1;
  unsigned char WPRG        : 1;
  unsigned char OPT         : 1;
} __BITS_FLASH_CR2;

__near __no_init volatile  union { unsigned char FLASH_CR2; __BITS_FLASH_CR2 FLASH_CR2_bit; } @ 0x505B;;

/* Flash complementary control register 2 */

typedef struct
{
  unsigned char NPRG        : 1;
  unsigned char             : 3;
  unsigned char NFPRG       : 1;
  unsigned char NERASE      : 1;
  unsigned char NWPRG       : 1;
  unsigned char NOPT        : 1;
} __BITS_FLASH_NCR2;

__near __no_init volatile  union { unsigned char FLASH_NCR2; __BITS_FLASH_NCR2 FLASH_NCR2_bit; } @ 0x505C;;

/* Flash protection register */

typedef struct
{
  unsigned char WPB0        : 1;
  unsigned char WPB1        : 1;
  unsigned char WPB2        : 1;
  unsigned char WPB3        : 1;
  unsigned char WPB4        : 1;
  unsigned char WPB5        : 1;
} __BITS_FLASH_FPR;

__near __no_init volatile const union { unsigned char FLASH_FPR; __BITS_FLASH_FPR FLASH_FPR_bit; } @ 0x505D;;

/* Flash complementary protection register */

typedef struct
{
  unsigned char NWPB0       : 1;
  unsigned char NWPB1       : 1;
  unsigned char NWPB2       : 1;
  unsigned char NWPB3       : 1;
  unsigned char NWPB4       : 1;
  unsigned char NWPB5       : 1;
} __BITS_FLASH_NFPR;

__near __no_init volatile const union { unsigned char FLASH_NFPR; __BITS_FLASH_NFPR FLASH_NFPR_bit; } @ 0x505E;;

/* Flash in-application programming status register */

typedef struct
{
  unsigned char WR_PG_DIS   : 1;
  unsigned char PUL         : 1;
  unsigned char EOP         : 1;
  unsigned char DUL         : 1;
  unsigned char             : 2;
  unsigned char HVOFF       : 1;
} __BITS_FLASH_IAPSR;

__near __no_init volatile  union { unsigned char FLASH_IAPSR; __BITS_FLASH_IAPSR FLASH_IAPSR_bit; } @ 0x505F;;

/* Flash program memory unprotection register */
__near __no_init volatile  unsigned char FLASH_PUKR @ 0x5062;;
/* Data EEPROM unprotection register */
__near __no_init volatile  unsigned char FLASH_DUKR @ 0x5064;;

/*-------------------------------------------------------------------------
 *      Flash bit fields
 *-----------------------------------------------------------------------*/



















#line 1296 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1303 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"









/*-------------------------------------------------------------------------
 *      Flash bit masks
 *-----------------------------------------------------------------------*/

















#line 1338 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1345 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"








/*-------------------------------------------------------------------------
 *      ITC register definitions
 *-----------------------------------------------------------------------*/
/* External interrupt control register 1 */

typedef struct
{
  unsigned char PAIS        : 2;
  unsigned char PBIS        : 2;
  unsigned char PCIS        : 2;
  unsigned char PDIS        : 2;
} __BITS_EXTI_CR1;

__near __no_init volatile  union { unsigned char EXTI_CR1; __BITS_EXTI_CR1 EXTI_CR1_bit; } @ 0x50A0;;

/* External interrupt control register 2 */

typedef struct
{
  unsigned char PEIS        : 2;
  unsigned char TLIS        : 1;
} __BITS_EXTI_CR2;

__near __no_init volatile  union { unsigned char EXTI_CR2; __BITS_EXTI_CR2 EXTI_CR2_bit; } @ 0x50A1;;

/* Reset status register */

typedef struct
{
  unsigned char WWDGF       : 1;
  unsigned char IWDGF       : 1;
  unsigned char ILLOPF      : 1;
  unsigned char SWIMF       : 1;
  unsigned char EMCF        : 1;
} __BITS_RST_SR;

__near __no_init volatile  union { unsigned char RST_SR; __BITS_RST_SR RST_SR_bit; } @ 0x50B3;;

/* Interrupt software priority register 1 */

typedef struct
{
  unsigned char VECT0SPR    : 2;
  unsigned char VECT1SPR    : 2;
  unsigned char VECT2SPR    : 2;
  unsigned char VECT3SPR    : 2;
} __BITS_ITC_SPR1;

__near __no_init volatile  union { unsigned char ITC_SPR1; __BITS_ITC_SPR1 ITC_SPR1_bit; } @ 0x7F70;;

/* Interrupt software priority register 2 */

typedef struct
{
  unsigned char VECT4SPR    : 2;
  unsigned char VECT5SPR    : 2;
  unsigned char VECT6SPR    : 2;
  unsigned char VECT7SPR    : 2;
} __BITS_ITC_SPR2;

__near __no_init volatile  union { unsigned char ITC_SPR2; __BITS_ITC_SPR2 ITC_SPR2_bit; } @ 0x7F71;;

/* Interrupt software priority register 3 */

typedef struct
{
  unsigned char VECT8SPR    : 2;
  unsigned char VECT9SPR    : 2;
  unsigned char VECT10SPR   : 2;
  unsigned char VECT11SPR   : 2;
} __BITS_ITC_SPR3;

__near __no_init volatile  union { unsigned char ITC_SPR3; __BITS_ITC_SPR3 ITC_SPR3_bit; } @ 0x7F72;;

/* Interrupt software priority register 4 */

typedef struct
{
  unsigned char VECT12SPR   : 2;
  unsigned char VECT13SPR   : 2;
  unsigned char VECT14SPR   : 2;
  unsigned char VECT15SPR   : 2;
} __BITS_ITC_SPR4;

__near __no_init volatile  union { unsigned char ITC_SPR4; __BITS_ITC_SPR4 ITC_SPR4_bit; } @ 0x7F73;;

/* Interrupt software priority register 5 */

typedef struct
{
  unsigned char VECT16SPR   : 2;
  unsigned char VECT17SPR   : 2;
  unsigned char VECT18SPR   : 2;
  unsigned char VECT19SPR   : 2;
} __BITS_ITC_SPR5;

__near __no_init volatile  union { unsigned char ITC_SPR5; __BITS_ITC_SPR5 ITC_SPR5_bit; } @ 0x7F74;;

/* Interrupt software priority register 6 */

typedef struct
{
  unsigned char VECT20SPR   : 2;
  unsigned char VECT21SPR   : 2;
  unsigned char VECT22SPR   : 2;
  unsigned char VECT23SPR   : 2;
} __BITS_ITC_SPR6;

__near __no_init volatile  union { unsigned char ITC_SPR6; __BITS_ITC_SPR6 ITC_SPR6_bit; } @ 0x7F75;;

/* Interrupt software priority register 7 */

typedef struct
{
  unsigned char VECT24SPR   : 2;
  unsigned char VECT25SPR   : 2;
  unsigned char VECT26SPR   : 2;
  unsigned char VECT27SPR   : 2;
} __BITS_ITC_SPR7;

__near __no_init volatile  union { unsigned char ITC_SPR7; __BITS_ITC_SPR7 ITC_SPR7_bit; } @ 0x7F76;;

/* Interrupt software priority register 8 */

typedef struct
{
  unsigned char VECT28SPR   : 2;
  unsigned char VECT29SPR   : 2;
} __BITS_ITC_SPR8;

__near __no_init volatile  union { unsigned char ITC_SPR8; __BITS_ITC_SPR8 ITC_SPR8_bit; } @ 0x7F77;;


/*-------------------------------------------------------------------------
 *      ITC bit fields
 *-----------------------------------------------------------------------*/
























































/*-------------------------------------------------------------------------
 *      ITC bit masks
 *-----------------------------------------------------------------------*/





















































/*-------------------------------------------------------------------------
 *      CLK register definitions
 *-----------------------------------------------------------------------*/
/* Internal clock control register */

typedef struct
{
  unsigned char HSIEN       : 1;
  unsigned char HSIRDY      : 1;
  unsigned char FHW         : 1;
  unsigned char LSIEN       : 1;
  unsigned char LSIRDY      : 1;
  unsigned char REGAH       : 1;
} __BITS_CLK_ICKR;

__near __no_init volatile  union { unsigned char CLK_ICKR; __BITS_CLK_ICKR CLK_ICKR_bit; } @ 0x50C0;;

/* External clock control register */

typedef struct
{
  unsigned char HSEEN       : 1;
  unsigned char HSERDY      : 1;
} __BITS_CLK_ECKR;

__near __no_init volatile  union { unsigned char CLK_ECKR; __BITS_CLK_ECKR CLK_ECKR_bit; } @ 0x50C1;;

/* Clock master status register */
__near __no_init volatile const unsigned char CLK_CMSR @ 0x50C3;;
/* Clock master switch register */
__near __no_init volatile  unsigned char CLK_SWR @ 0x50C4;;
/* Clock switch control register */

typedef struct
{
  unsigned char SWBSY       : 1;
  unsigned char SWEN        : 1;
  unsigned char SWIEN       : 1;
  unsigned char SWIF        : 1;
} __BITS_CLK_SWCR;

__near __no_init volatile  union { unsigned char CLK_SWCR; __BITS_CLK_SWCR CLK_SWCR_bit; } @ 0x50C5;;

/* Clock divider register */

typedef struct
{
  unsigned char CPUDIV      : 3;
  unsigned char HSIDIV      : 2;
} __BITS_CLK_CKDIVR;

__near __no_init volatile  union { unsigned char CLK_CKDIVR; __BITS_CLK_CKDIVR CLK_CKDIVR_bit; } @ 0x50C6;;

/* Peripheral clock gating register 1 */
__near __no_init volatile  unsigned char CLK_PCKENR1 @ 0x50C7;;
/* Clock security system register */

typedef struct
{
  unsigned char CSSEN       : 1;
  unsigned char AUX         : 1;
  unsigned char CSSDIE      : 1;
  unsigned char CSSD        : 1;
} __BITS_CLK_CSSR;

__near __no_init volatile  union { unsigned char CLK_CSSR; __BITS_CLK_CSSR CLK_CSSR_bit; } @ 0x50C8;;

/* Configurable clock control register */

typedef struct
{
  unsigned char CCOEN       : 1;
  unsigned char CCOSEL      : 4;
  unsigned char CCORDY      : 1;
  unsigned char CC0BSY      : 1;
} __BITS_CLK_CCOR;

__near __no_init volatile  union { unsigned char CLK_CCOR; __BITS_CLK_CCOR CLK_CCOR_bit; } @ 0x50C9;;

/* Peripheral clock gating register 2 */
__near __no_init volatile  unsigned char CLK_PCKENR2 @ 0x50CA;;
/* HSI clock calibration trimming register */

typedef struct
{
  unsigned char HSITRIM     : 4;
} __BITS_CLK_HSITRIMR;

__near __no_init volatile  union { unsigned char CLK_HSITRIMR; __BITS_CLK_HSITRIMR CLK_HSITRIMR_bit; } @ 0x50CC;;

/* SWIM clock control register */

typedef struct
{
  unsigned char SWIMCLK     : 1;
} __BITS_CLK_SWIMCCR;

__near __no_init volatile  union { unsigned char CLK_SWIMCCR; __BITS_CLK_SWIMCCR CLK_SWIMCCR_bit; } @ 0x50CD;;


/*-------------------------------------------------------------------------
 *      CLK bit fields
 *-----------------------------------------------------------------------*/


#line 1712 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"




























/*-------------------------------------------------------------------------
 *      CLK bit masks
 *-----------------------------------------------------------------------*/
#line 1749 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



























/*-------------------------------------------------------------------------
 *      WWDG register definitions
 *-----------------------------------------------------------------------*/
/* WWDG control register */

typedef struct
{
  unsigned char T0          : 1;
  unsigned char T1          : 1;
  unsigned char T2          : 1;
  unsigned char T3          : 1;
  unsigned char T4          : 1;
  unsigned char T5          : 1;
  unsigned char T6          : 1;
  unsigned char WDGA        : 1;
} __BITS_WWDG_CR;

__near __no_init volatile  union { unsigned char WWDG_CR; __BITS_WWDG_CR WWDG_CR_bit; } @ 0x50D1;;

/* WWDR window register */

typedef struct
{
  unsigned char W0          : 1;
  unsigned char W1          : 1;
  unsigned char W2          : 1;
  unsigned char W3          : 1;
  unsigned char W4          : 1;
  unsigned char W5          : 1;
  unsigned char W6          : 1;
} __BITS_WWDG_WR;

__near __no_init volatile  union { unsigned char WWDG_WR; __BITS_WWDG_WR WWDG_WR_bit; } @ 0x50D2;;


/*-------------------------------------------------------------------------
 *      WWDG bit fields
 *-----------------------------------------------------------------------*/


#line 1824 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1832 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      WWDG bit masks
 *-----------------------------------------------------------------------*/
#line 1846 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 1854 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      IWDG register definitions
 *-----------------------------------------------------------------------*/
/* IWDG key register */
__near __no_init volatile  unsigned char IWDG_KR @ 0x50E0;;
/* IWDG prescaler register */

typedef struct
{
  unsigned char PR          : 3;
} __BITS_IWDG_PR;

__near __no_init volatile  union { unsigned char IWDG_PR; __BITS_IWDG_PR IWDG_PR_bit; } @ 0x50E1;;

/* IWDG reload register */
__near __no_init volatile  unsigned char IWDG_RLR @ 0x50E2;;

/*-------------------------------------------------------------------------
 *      IWDG bit fields
 *-----------------------------------------------------------------------*/






/*-------------------------------------------------------------------------
 *      IWDG bit masks
 *-----------------------------------------------------------------------*/



/*-------------------------------------------------------------------------
 *      AWU register definitions
 *-----------------------------------------------------------------------*/
/* AWU control/status register 1 */

typedef struct
{
  unsigned char MSR         : 1;
  unsigned char             : 3;
  unsigned char AWUEN       : 1;
  unsigned char AWUF        : 1;
} __BITS_AWU_CSR1;

__near __no_init volatile  union { unsigned char AWU_CSR1; __BITS_AWU_CSR1 AWU_CSR1_bit; } @ 0x50F0;;

/* AWU asynchronous prescaler buffer register */

typedef struct
{
  unsigned char APR         : 6;
} __BITS_AWU_APR;

__near __no_init volatile  union { unsigned char AWU_APR; __BITS_AWU_APR AWU_APR_bit; } @ 0x50F1;;

/* AWU timebase selection register */

typedef struct
{
  unsigned char AWUTB       : 4;
} __BITS_AWU_TBR;

__near __no_init volatile  union { unsigned char AWU_TBR; __BITS_AWU_TBR AWU_TBR_bit; } @ 0x50F2;;


/*-------------------------------------------------------------------------
 *      AWU bit fields
 *-----------------------------------------------------------------------*/












/*-------------------------------------------------------------------------
 *      AWU bit masks
 *-----------------------------------------------------------------------*/









/*-------------------------------------------------------------------------
 *      BEEP register definitions
 *-----------------------------------------------------------------------*/
/* BEEP control/status register */

typedef struct
{
  unsigned char BEEPDIV     : 5;
  unsigned char BEEPEN      : 1;
  unsigned char BEEPSEL     : 2;
} __BITS_BEEP_CSR;

__near __no_init volatile  union { unsigned char BEEP_CSR; __BITS_BEEP_CSR BEEP_CSR_bit; } @ 0x50F3;;


/*-------------------------------------------------------------------------
 *      BEEP bit fields
 *-----------------------------------------------------------------------*/








/*-------------------------------------------------------------------------
 *      BEEP bit masks
 *-----------------------------------------------------------------------*/





/*-------------------------------------------------------------------------
 *      SPI register definitions
 *-----------------------------------------------------------------------*/
/* SPI control register 1 */

typedef struct
{
  unsigned char CPHA        : 1;
  unsigned char CPOL        : 1;
  unsigned char MSTR        : 1;
  unsigned char BR          : 3;
  unsigned char SPE         : 1;
  unsigned char LSBFIRST    : 1;
} __BITS_SPI_CR1;

__near __no_init volatile  union { unsigned char SPI_CR1; __BITS_SPI_CR1 SPI_CR1_bit; } @ 0x5200;;

/* SPI control register 2 */

typedef struct
{
  unsigned char SSI         : 1;
  unsigned char SSM         : 1;
  unsigned char RXONLY      : 1;
  unsigned char             : 1;
  unsigned char CRCNEXT     : 1;
  unsigned char CECEN       : 1;
  unsigned char BDOE        : 1;
  unsigned char BDM         : 1;
} __BITS_SPI_CR2;

__near __no_init volatile  union { unsigned char SPI_CR2; __BITS_SPI_CR2 SPI_CR2_bit; } @ 0x5201;;

/* SPI interrupt control register */

typedef struct
{
  unsigned char             : 4;
  unsigned char WKIE        : 1;
  unsigned char ERRIE       : 1;
  unsigned char RXIE        : 1;
  unsigned char TXIE        : 1;
} __BITS_SPI_ICR;

__near __no_init volatile  union { unsigned char SPI_ICR; __BITS_SPI_ICR SPI_ICR_bit; } @ 0x5202;;

/* SPI status register */

typedef struct
{
  unsigned char RXNE        : 1;
  unsigned char TXE         : 1;
  unsigned char             : 1;
  unsigned char WKUP        : 1;
  unsigned char CRCERR      : 1;
  unsigned char MODF        : 1;
  unsigned char OVR         : 1;
  unsigned char BSY         : 1;
} __BITS_SPI_SR;

__near __no_init volatile  union { unsigned char SPI_SR; __BITS_SPI_SR SPI_SR_bit; } @ 0x5203;;

/* SPI data register */
__near __no_init volatile  unsigned char SPI_DR @ 0x5204;;
/* SPI CRC polynomial register */
__near __no_init volatile  unsigned char SPI_CRCPR @ 0x5205;;
/* SPI Rx CRC register */
__near __no_init volatile const unsigned char SPI_RXCRCR @ 0x5206;;
/* SPI Tx CRC register */
__near __no_init volatile const unsigned char SPI_TXCRCR @ 0x5207;;

/*-------------------------------------------------------------------------
 *      SPI bit fields
 *-----------------------------------------------------------------------*/


#line 2065 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2073 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"






#line 2086 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      SPI bit masks
 *-----------------------------------------------------------------------*/
#line 2098 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2106 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"






#line 2119 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      I2C register definitions
 *-----------------------------------------------------------------------*/
/* I2C control register 1 */

typedef struct
{
  unsigned char PE          : 1;
  unsigned char             : 5;
  unsigned char ENGC        : 1;
  unsigned char NOSTRETCH   : 1;
} __BITS_I2C_CR1;

__near __no_init volatile  union { unsigned char I2C_CR1; __BITS_I2C_CR1 I2C_CR1_bit; } @ 0x5210;;

/* I2C control register 2 */

typedef struct
{
  unsigned char START       : 1;
  unsigned char STOP        : 1;
  unsigned char ACK         : 1;
  unsigned char POS         : 1;
  unsigned char             : 3;
  unsigned char SWRST       : 1;
} __BITS_I2C_CR2;

__near __no_init volatile  union { unsigned char I2C_CR2; __BITS_I2C_CR2 I2C_CR2_bit; } @ 0x5211;;

/* I2C frequency register */

typedef struct
{
  unsigned char FREQ        : 6;
} __BITS_I2C_FREQR;

__near __no_init volatile  union { unsigned char I2C_FREQR; __BITS_I2C_FREQR I2C_FREQR_bit; } @ 0x5212;;

/* I2C Own address register low */

typedef struct
{
  unsigned char ADD0        : 1;
  unsigned char ADD         : 7;
} __BITS_I2C_OARL;

__near __no_init volatile  union { unsigned char I2C_OARL; __BITS_I2C_OARL I2C_OARL_bit; } @ 0x5213;;

/* I2C Own address register high */

typedef struct
{
  unsigned char             : 1;
  unsigned char ADD         : 2;
  unsigned char             : 3;
  unsigned char ADDCONF     : 1;
  unsigned char ADDMODE     : 1;
} __BITS_I2C_OARH;

__near __no_init volatile  union { unsigned char I2C_OARH; __BITS_I2C_OARH I2C_OARH_bit; } @ 0x5214;;

/* I2C data register */
__near __no_init volatile  unsigned char I2C_DR @ 0x5216;;
/* I2C status register 1 */

typedef struct
{
  unsigned char SB          : 1;
  unsigned char ADDR        : 1;
  unsigned char BTF         : 1;
  unsigned char ADD10       : 1;
  unsigned char STOPF       : 1;
  unsigned char             : 1;
  unsigned char RXNE        : 1;
  unsigned char TXE         : 1;
} __BITS_I2C_SR1;

__near __no_init volatile const union { unsigned char I2C_SR1; __BITS_I2C_SR1 I2C_SR1_bit; } @ 0x5217;;

/* I2C status register 2 */

typedef struct
{
  unsigned char BERR        : 1;
  unsigned char ARLO        : 1;
  unsigned char AF          : 1;
  unsigned char OVR         : 1;
  unsigned char             : 1;
  unsigned char WUFH        : 1;
} __BITS_I2C_SR2;

__near __no_init volatile  union { unsigned char I2C_SR2; __BITS_I2C_SR2 I2C_SR2_bit; } @ 0x5218;;

/* I2C status register 3 */

typedef struct
{
  unsigned char MSL         : 1;
  unsigned char BUSY        : 1;
  unsigned char TRA         : 1;
  unsigned char             : 1;
  unsigned char GENCALL     : 1;
} __BITS_I2C_SR3;

__near __no_init volatile const union { unsigned char I2C_SR3; __BITS_I2C_SR3 I2C_SR3_bit; } @ 0x5219;;

/* I2C interrupt control register */

typedef struct
{
  unsigned char ITERREN     : 1;
  unsigned char ITEVTEN     : 1;
  unsigned char ITBUFEN     : 1;
} __BITS_I2C_ITR;

__near __no_init volatile  union { unsigned char I2C_ITR; __BITS_I2C_ITR I2C_ITR_bit; } @ 0x521A;;

/* I2C Clock control register low */
__near __no_init volatile  unsigned char I2C_CCRL @ 0x521B;;
/* I2C Clock control register high */

typedef struct
{
  unsigned char CCR         : 4;
  unsigned char             : 2;
  unsigned char DUTY        : 1;
  unsigned char F_S         : 1;
} __BITS_I2C_CCRH;

__near __no_init volatile  union { unsigned char I2C_CCRH; __BITS_I2C_CCRH I2C_CCRH_bit; } @ 0x521C;;

/* I2C TRISE register */

typedef struct
{
  unsigned char TRISE       : 6;
} __BITS_I2C_TRISER;

__near __no_init volatile  union { unsigned char I2C_TRISER; __BITS_I2C_TRISER I2C_TRISER_bit; } @ 0x521D;;

/* I2C packet error checking register */
__near __no_init volatile  unsigned char I2C_PECR @ 0x521E;;

/*-------------------------------------------------------------------------
 *      I2C bit fields
 *-----------------------------------------------------------------------*/





















#line 2295 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"
























/*-------------------------------------------------------------------------
 *      I2C bit masks
 *-----------------------------------------------------------------------*/



















#line 2348 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"























/*-------------------------------------------------------------------------
 *      UART1 register definitions
 *-----------------------------------------------------------------------*/
/* UART1 status register */

typedef struct
{
  unsigned char PE          : 1;
  unsigned char FE          : 1;
  unsigned char NF          : 1;
  unsigned char OR_LHE      : 1;
  unsigned char IDLE        : 1;
  unsigned char RXNE        : 1;
  unsigned char TC          : 1;
  unsigned char TXE         : 1;
} __BITS_UART1_SR;

__near __no_init volatile  union { unsigned char UART1_SR; __BITS_UART1_SR UART1_SR_bit; } @ 0x5230;;

/* UART1 data register */
__near __no_init volatile  unsigned char UART1_DR @ 0x5231;;
/* UART1 baud rate register 1 */
__near __no_init volatile  unsigned char UART1_BRR1 @ 0x5232;;
/* UART1 baud rate register 2 */
__near __no_init volatile  unsigned char UART1_BRR2 @ 0x5233;;
/* UART1 control register 1 */

typedef struct
{
  unsigned char PIEN        : 1;
  unsigned char PS          : 1;
  unsigned char PCEN        : 1;
  unsigned char WAKE        : 1;
  unsigned char M           : 1;
  unsigned char UART0       : 1;
  unsigned char T8          : 1;
  unsigned char R8          : 1;
} __BITS_UART1_CR1;

__near __no_init volatile  union { unsigned char UART1_CR1; __BITS_UART1_CR1 UART1_CR1_bit; } @ 0x5234;;

/* UART1 control register 2 */

typedef struct
{
  unsigned char SBK         : 1;
  unsigned char RWU         : 1;
  unsigned char REN         : 1;
  unsigned char TEN         : 1;
  unsigned char ILIEN       : 1;
  unsigned char RIEN        : 1;
  unsigned char TCIEN       : 1;
  unsigned char TIEN        : 1;
} __BITS_UART1_CR2;

__near __no_init volatile  union { unsigned char UART1_CR2; __BITS_UART1_CR2 UART1_CR2_bit; } @ 0x5235;;

/* UART1 control register 3 */

typedef struct
{
  unsigned char LBCL        : 1;
  unsigned char CPHA        : 1;
  unsigned char CPOL        : 1;
  unsigned char CKEN        : 1;
  unsigned char STOP        : 2;
  unsigned char             : 1;
  unsigned char LINEN       : 1;
} __BITS_UART1_CR3;

__near __no_init volatile  union { unsigned char UART1_CR3; __BITS_UART1_CR3 UART1_CR3_bit; } @ 0x5236;;

/* UART1 control register 4 */

typedef struct
{
  unsigned char ADD         : 4;
  unsigned char LBDF        : 1;
  unsigned char LBDL        : 1;
  unsigned char LBDIEN      : 1;
} __BITS_UART1_CR4;

__near __no_init volatile  union { unsigned char UART1_CR4; __BITS_UART1_CR4 UART1_CR4_bit; } @ 0x5237;;

/* UART1 control register 5 */

typedef struct
{
  unsigned char             : 1;
  unsigned char IREN        : 1;
  unsigned char IRLP        : 1;
  unsigned char HDSEL       : 1;
  unsigned char NACK        : 1;
  unsigned char SCEN        : 1;
} __BITS_UART1_CR5;

__near __no_init volatile  union { unsigned char UART1_CR5; __BITS_UART1_CR5 UART1_CR5_bit; } @ 0x5238;;

/* UART1 guard time register */
__near __no_init volatile  unsigned char UART1_GTR @ 0x5239;;
/* UART1 prescaler register */
__near __no_init volatile  unsigned char UART1_PSCR @ 0x523A;;

/*-------------------------------------------------------------------------
 *      UART1 bit fields
 *-----------------------------------------------------------------------*/


#line 2487 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2496 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2505 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2512 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"














/*-------------------------------------------------------------------------
 *      UART1 bit masks
 *-----------------------------------------------------------------------*/
#line 2537 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2546 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2555 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2562 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"













/*-------------------------------------------------------------------------
 *      TIM1 register definitions
 *-----------------------------------------------------------------------*/
/* TIM1 control register 1 */

typedef struct
{
  unsigned char CEN         : 1;
  unsigned char UDIS        : 1;
  unsigned char URS         : 1;
  unsigned char OPM         : 1;
  unsigned char DIR         : 1;
  unsigned char CMS         : 2;
  unsigned char ARPE        : 1;
} __BITS_TIM1_CR1;

__near __no_init volatile  union { unsigned char TIM1_CR1; __BITS_TIM1_CR1 TIM1_CR1_bit; } @ 0x5250;;

/* TIM1 control register 2 */

typedef struct
{
  unsigned char CCPG        : 1;
  unsigned char             : 1;
  unsigned char COMS        : 1;
  unsigned char             : 1;
  unsigned char MMS         : 3;
} __BITS_TIM1_CR2;

__near __no_init volatile  union { unsigned char TIM1_CR2; __BITS_TIM1_CR2 TIM1_CR2_bit; } @ 0x5251;;

/* TIM1 slave mode control register */

typedef struct
{
  unsigned char SMS         : 3;
  unsigned char             : 1;
  unsigned char TS          : 3;
  unsigned char MSM         : 1;
} __BITS_TIM1_SMCR;

__near __no_init volatile  union { unsigned char TIM1_SMCR; __BITS_TIM1_SMCR TIM1_SMCR_bit; } @ 0x5252;;

/* TIM1 external trigger register */

typedef struct
{
  unsigned char ETF         : 4;
  unsigned char ETPS        : 2;
  unsigned char ECE         : 1;
  unsigned char ETP         : 1;
} __BITS_TIM1_ETR;

__near __no_init volatile  union { unsigned char TIM1_ETR; __BITS_TIM1_ETR TIM1_ETR_bit; } @ 0x5253;;

/* TIM1 interrupt enable register */

typedef struct
{
  unsigned char UIE         : 1;
  unsigned char CC1IE       : 1;
  unsigned char CC2IE       : 1;
  unsigned char CC3IE       : 1;
  unsigned char CC4IE       : 1;
  unsigned char COMIE       : 1;
  unsigned char TIE         : 1;
  unsigned char BIE         : 1;
} __BITS_TIM1_IER;

__near __no_init volatile  union { unsigned char TIM1_IER; __BITS_TIM1_IER TIM1_IER_bit; } @ 0x5254;;

/* TIM1 status register 1 */

typedef struct
{
  unsigned char UIF         : 1;
  unsigned char CC1IF       : 1;
  unsigned char CC2IF       : 1;
  unsigned char CC3IF       : 1;
  unsigned char CC4IF       : 1;
  unsigned char COMIF       : 1;
  unsigned char TIF         : 1;
  unsigned char BIF         : 1;
} __BITS_TIM1_SR1;

__near __no_init volatile  union { unsigned char TIM1_SR1; __BITS_TIM1_SR1 TIM1_SR1_bit; } @ 0x5255;;

/* TIM1 status register 2 */

typedef struct
{
  unsigned char             : 1;
  unsigned char CC1OF       : 1;
  unsigned char CC2OF       : 1;
  unsigned char CC3OF       : 1;
  unsigned char CC4OF       : 1;
} __BITS_TIM1_SR2;

__near __no_init volatile  union { unsigned char TIM1_SR2; __BITS_TIM1_SR2 TIM1_SR2_bit; } @ 0x5256;;

/* TIM1 event generation register */

typedef struct
{
  unsigned char UG          : 1;
  unsigned char CC1G        : 1;
  unsigned char CC2G        : 1;
  unsigned char CC3G        : 1;
  unsigned char CC4G        : 1;
  unsigned char COMG        : 1;
  unsigned char TG          : 1;
  unsigned char BG          : 1;
} __BITS_TIM1_EGR;

__near __no_init volatile  union { unsigned char TIM1_EGR; __BITS_TIM1_EGR TIM1_EGR_bit; } @ 0x5257;;

/* TIM1 capture/compare mode register 1 */

typedef struct
{
  unsigned char CC1S        : 2;
  unsigned char OC1FE       : 1;
  unsigned char OC1PE       : 1;
  unsigned char OC1M        : 3;
  unsigned char OC1CE       : 1;
} __BITS_TIM1_CCMR1;

__near __no_init volatile  union { unsigned char TIM1_CCMR1; __BITS_TIM1_CCMR1 TIM1_CCMR1_bit; } @ 0x5258;;

/* TIM1 capture/compare mode register 2 */

typedef struct
{
  unsigned char CC2S        : 2;
  unsigned char OC2FE       : 1;
  unsigned char OC2PE       : 1;
  unsigned char OC2M        : 3;
  unsigned char OC2CE       : 1;
} __BITS_TIM1_CCMR2;

__near __no_init volatile  union { unsigned char TIM1_CCMR2; __BITS_TIM1_CCMR2 TIM1_CCMR2_bit; } @ 0x5259;;

/* TIM1 capture/compare mode register 3 */

typedef struct
{
  unsigned char CC3S        : 2;
  unsigned char OC3FE       : 1;
  unsigned char OC3PE       : 1;
  unsigned char OC3M        : 3;
  unsigned char OC3CE       : 1;
} __BITS_TIM1_CCMR3;

__near __no_init volatile  union { unsigned char TIM1_CCMR3; __BITS_TIM1_CCMR3 TIM1_CCMR3_bit; } @ 0x525A;;

/* TIM1 capture/compare mode register 4 */

typedef struct
{
  unsigned char CC4S        : 2;
  unsigned char OC4FE       : 1;
  unsigned char OC4PE       : 1;
  unsigned char OC4M        : 3;
  unsigned char OC4CE       : 1;
} __BITS_TIM1_CCMR4;

__near __no_init volatile  union { unsigned char TIM1_CCMR4; __BITS_TIM1_CCMR4 TIM1_CCMR4_bit; } @ 0x525B;;

/* TIM1 capture/compare enable register 1 */

typedef struct
{
  unsigned char CC1E        : 1;
  unsigned char CC1P        : 1;
  unsigned char CC1NE       : 1;
  unsigned char CC1NP       : 1;
  unsigned char CC2E        : 1;
  unsigned char CC2P        : 1;
  unsigned char CC2NE       : 1;
  unsigned char CC2NP       : 1;
} __BITS_TIM1_CCER1;

__near __no_init volatile  union { unsigned char TIM1_CCER1; __BITS_TIM1_CCER1 TIM1_CCER1_bit; } @ 0x525C;;

/* TIM1 capture/compare enable register 2 */

typedef struct
{
  unsigned char CC3E        : 1;
  unsigned char CC3P        : 1;
  unsigned char CC3NE       : 1;
  unsigned char CC3NP       : 1;
  unsigned char CC4E        : 1;
  unsigned char CC4P        : 1;
} __BITS_TIM1_CCER2;

__near __no_init volatile  union { unsigned char TIM1_CCER2; __BITS_TIM1_CCER2 TIM1_CCER2_bit; } @ 0x525D;;

/* TIM1 counter high */
__near __no_init volatile  unsigned char TIM1_CNTRH @ 0x525E;;
/* TIM1 counter low */
__near __no_init volatile  unsigned char TIM1_CNTRL @ 0x525F;;
/* TIM1 prescaler register high */
__near __no_init volatile  unsigned char TIM1_PSCRH @ 0x5260;;
/* TIM1 prescaler register low */
__near __no_init volatile  unsigned char TIM1_PSCRL @ 0x5261;;
/* TIM1 auto-reload register high */
__near __no_init volatile  unsigned char TIM1_ARRH @ 0x5262;;
/* TIM1 auto-reload register low */
__near __no_init volatile  unsigned char TIM1_ARRL @ 0x5263;;
/* TIM1 repetition counter register */
__near __no_init volatile  unsigned char TIM1_RCR @ 0x5264;;
/* TIM1 capture/compare register 1 high */
__near __no_init volatile  unsigned char TIM1_CCR1H @ 0x5265;;
/* TIM1 capture/compare register 1 low */
__near __no_init volatile  unsigned char TIM1_CCR1L @ 0x5266;;
/* TIM1 capture/compare register 2 high */
__near __no_init volatile  unsigned char TIM1_CCR2H @ 0x5267;;
/* TIM1 capture/compare register 2 low */
__near __no_init volatile  unsigned char TIM1_CCR2L @ 0x5268;;
/* TIM1 capture/compare register 3 high */
__near __no_init volatile  unsigned char TIM1_CCR3H @ 0x5269;;
/* TIM1 capture/compare register 3 low */
__near __no_init volatile  unsigned char TIM1_CCR3L @ 0x526A;;
/* TIM1 capture/compare register 4 high */
__near __no_init volatile  unsigned char TIM1_CCR4H @ 0x526B;;
/* TIM1 capture/compare register 4 low */
__near __no_init volatile  unsigned char TIM1_CCR4L @ 0x526C;;
/* TIM1 break register */

typedef struct
{
  unsigned char LOCK        : 2;
  unsigned char OSSI        : 1;
  unsigned char OSSR        : 1;
  unsigned char BKE         : 1;
  unsigned char BKP         : 1;
  unsigned char AOE         : 1;
  unsigned char MOE         : 1;
} __BITS_TIM1_BKR;

__near __no_init volatile  union { unsigned char TIM1_BKR; __BITS_TIM1_BKR TIM1_BKR_bit; } @ 0x526D;;

/* TIM1 dead-time register */
__near __no_init volatile  unsigned char TIM1_DTR @ 0x526E;;
/* TIM1 output idle state register */

typedef struct
{
  unsigned char OIS1        : 1;
  unsigned char OIS1N       : 1;
  unsigned char OIS2        : 1;
  unsigned char OIS2N       : 1;
  unsigned char OIS3        : 1;
  unsigned char OIS3N       : 1;
  unsigned char OIS4        : 1;
} __BITS_TIM1_OISR;

__near __no_init volatile  union { unsigned char TIM1_OISR; __BITS_TIM1_OISR TIM1_OISR_bit; } @ 0x526F;;


/*-------------------------------------------------------------------------
 *      TIM1 bit fields
 *-----------------------------------------------------------------------*/


#line 2848 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"














#line 2870 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2879 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"






#line 2893 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

























#line 2926 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2933 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2941 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2949 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      TIM1 bit masks
 *-----------------------------------------------------------------------*/
#line 2962 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"














#line 2984 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 2993 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"






#line 3007 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

























#line 3040 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 3047 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 3055 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"

#line 3063 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      TIM2 register definitions
 *-----------------------------------------------------------------------*/
/* TIM2 control register 1 */

typedef struct
{
  unsigned char CEN         : 1;
  unsigned char UDIS        : 1;
  unsigned char URS         : 1;
  unsigned char OPM         : 1;
  unsigned char             : 3;
  unsigned char ARPE        : 1;
} __BITS_TIM2_CR1;

__near __no_init volatile  union { unsigned char TIM2_CR1; __BITS_TIM2_CR1 TIM2_CR1_bit; } @ 0x5300;;

/* TIM2 Interrupt enable register */

typedef struct
{
  unsigned char UIE         : 1;
  unsigned char CC1IE       : 1;
  unsigned char CC2IE       : 1;
  unsigned char CC3IE       : 1;
  unsigned char             : 2;
  unsigned char TIE         : 1;
} __BITS_TIM2_IER;

__near __no_init volatile  union { unsigned char TIM2_IER; __BITS_TIM2_IER TIM2_IER_bit; } @ 0x5303;;

/* TIM2 status register 1 */

typedef struct
{
  unsigned char UIF         : 1;
  unsigned char CC1IF       : 1;
  unsigned char CC2IF       : 1;
  unsigned char CC3IF       : 1;
  unsigned char             : 2;
  unsigned char TIF         : 1;
} __BITS_TIM2_SR1;

__near __no_init volatile  union { unsigned char TIM2_SR1; __BITS_TIM2_SR1 TIM2_SR1_bit; } @ 0x5304;;

/* TIM2 status register 2 */

typedef struct
{
  unsigned char             : 1;
  unsigned char CC1OF       : 1;
  unsigned char CC2OF       : 1;
  unsigned char CC3OF       : 1;
} __BITS_TIM2_SR2;

__near __no_init volatile  union { unsigned char TIM2_SR2; __BITS_TIM2_SR2 TIM2_SR2_bit; } @ 0x5305;;

/* TIM2 event generation register */

typedef struct
{
  unsigned char UG          : 1;
  unsigned char CC1G        : 1;
  unsigned char CC2G        : 1;
  unsigned char CC3G        : 1;
  unsigned char             : 2;
  unsigned char TG          : 1;
} __BITS_TIM2_EGR;

__near __no_init volatile  union { unsigned char TIM2_EGR; __BITS_TIM2_EGR TIM2_EGR_bit; } @ 0x5306;;

/* TIM2 capture/compare mode register 1 */

typedef struct
{
  unsigned char CC1S        : 2;
  unsigned char             : 1;
  unsigned char OC1PE       : 1;
  unsigned char OC1M        : 3;
} __BITS_TIM2_CCMR1;

__near __no_init volatile  union { unsigned char TIM2_CCMR1; __BITS_TIM2_CCMR1 TIM2_CCMR1_bit; } @ 0x5307;;

/* TIM2 capture/compare mode register 2 */

typedef struct
{
  unsigned char CC2S        : 2;
  unsigned char             : 1;
  unsigned char OC2PE       : 1;
  unsigned char OC2M        : 3;
} __BITS_TIM2_CCMR2;

__near __no_init volatile  union { unsigned char TIM2_CCMR2; __BITS_TIM2_CCMR2 TIM2_CCMR2_bit; } @ 0x5308;;

/* TIM2 capture/compare mode register 3 */

typedef struct
{
  unsigned char CC3S        : 2;
  unsigned char             : 1;
  unsigned char OC3PE       : 1;
  unsigned char OC3M        : 3;
} __BITS_TIM2_CCMR3;

__near __no_init volatile  union { unsigned char TIM2_CCMR3; __BITS_TIM2_CCMR3 TIM2_CCMR3_bit; } @ 0x5309;;

/* TIM2 capture/compare enable register 1 */

typedef struct
{
  unsigned char CC1E        : 1;
  unsigned char CC1P        : 1;
  unsigned char             : 2;
  unsigned char CC2E        : 1;
  unsigned char CC2P        : 1;
} __BITS_TIM2_CCER1;

__near __no_init volatile  union { unsigned char TIM2_CCER1; __BITS_TIM2_CCER1 TIM2_CCER1_bit; } @ 0x530A;;

/* TIM2 capture/compare enable register 2 */

typedef struct
{
  unsigned char CC3E        : 1;
  unsigned char CC3P        : 1;
} __BITS_TIM2_CCER2;

__near __no_init volatile  union { unsigned char TIM2_CCER2; __BITS_TIM2_CCER2 TIM2_CCER2_bit; } @ 0x530B;;

/* TIM2 counter high */
__near __no_init volatile  unsigned char TIM2_CNTRH @ 0x530C;;
/* TIM2 counter low */
__near __no_init volatile  unsigned char TIM2_CNTRL @ 0x530D;;
/* TIM2 prescaler register */

typedef struct
{
  unsigned char PSC         : 4;
} __BITS_TIM2_PSCR;

__near __no_init volatile  union { unsigned char TIM2_PSCR; __BITS_TIM2_PSCR TIM2_PSCR_bit; } @ 0x530E;;

/* TIM2 auto-reload register high */
__near __no_init volatile  unsigned char TIM2_ARRH @ 0x530F;;
/* TIM2 auto-reload register low */
__near __no_init volatile  unsigned char TIM2_ARRL @ 0x5310;;
/* TIM2 capture/compare register 1 high */
__near __no_init volatile  unsigned char TIM2_CCR1H @ 0x5311;;
/* TIM2 capture/compare register 1 low */
__near __no_init volatile  unsigned char TIM2_CCR1L @ 0x5312;;
/* TIM2 capture/compare reg */
__near __no_init volatile  unsigned char TIM2_CCR2H @ 0x5313;;
/* TIM2 capture/compare register 2 low */
__near __no_init volatile  unsigned char TIM2_CCR2L @ 0x5314;;
/* TIM2 capture/compare register 3 high */
__near __no_init volatile  unsigned char TIM2_CCR3H @ 0x5315;;
/* TIM2 capture/compare register 3 low */
__near __no_init volatile  unsigned char TIM2_CCR3L @ 0x5316;;

/*-------------------------------------------------------------------------
 *      TIM2 bit fields
 *-----------------------------------------------------------------------*/






















































/*-------------------------------------------------------------------------
 *      TIM2 bit masks
 *-----------------------------------------------------------------------*/



















































/*-------------------------------------------------------------------------
 *      TIM4 register definitions
 *-----------------------------------------------------------------------*/
/* TIM4 control register 1 */

typedef struct
{
  unsigned char CEN         : 1;
  unsigned char UDIS        : 1;
  unsigned char URS         : 1;
  unsigned char OPM         : 1;
  unsigned char             : 3;
  unsigned char ARPE        : 1;
} __BITS_TIM4_CR1;

__near __no_init volatile  union { unsigned char TIM4_CR1; __BITS_TIM4_CR1 TIM4_CR1_bit; } @ 0x5340;;

/* TIM4 interrupt enable register */

typedef struct
{
  unsigned char UIE         : 1;
  unsigned char             : 5;
  unsigned char TIE         : 1;
} __BITS_TIM4_IER;

__near __no_init volatile  union { unsigned char TIM4_IER; __BITS_TIM4_IER TIM4_IER_bit; } @ 0x5343;;

/* TIM4 status register */

typedef struct
{
  unsigned char UIF         : 1;
  unsigned char             : 5;
  unsigned char TIF         : 1;
} __BITS_TIM4_SR;

__near __no_init volatile  union { unsigned char TIM4_SR; __BITS_TIM4_SR TIM4_SR_bit; } @ 0x5344;;

/* TIM4 event generation register */

typedef struct
{
  unsigned char UG          : 1;
  unsigned char             : 5;
  unsigned char TG          : 1;
} __BITS_TIM4_EGR;

__near __no_init volatile  union { unsigned char TIM4_EGR; __BITS_TIM4_EGR TIM4_EGR_bit; } @ 0x5345;;

/* TIM4 counter */
__near __no_init volatile  unsigned char TIM4_CNTR @ 0x5346;;
/* TIM4 prescaler register */

typedef struct
{
  unsigned char PSC         : 3;
} __BITS_TIM4_PSCR;

__near __no_init volatile  union { unsigned char TIM4_PSCR; __BITS_TIM4_PSCR TIM4_PSCR_bit; } @ 0x5347;;

/* TIM4 auto-reload register */
__near __no_init volatile  unsigned char TIM4_ARR @ 0x5348;;

/*-------------------------------------------------------------------------
 *      TIM4 bit fields
 *-----------------------------------------------------------------------*/





















/*-------------------------------------------------------------------------
 *      TIM4 bit masks
 *-----------------------------------------------------------------------*/


















/*-------------------------------------------------------------------------
 *      ADC1 register definitions
 *-----------------------------------------------------------------------*/
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB0RH @ 0x53E0;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB0RL @ 0x53E1;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB1RH @ 0x53E2;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB1RL @ 0x53E3;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB2RH @ 0x53E4;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB2RL @ 0x53E5;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB3RH @ 0x53E6;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB3RL @ 0x53E7;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB4RH @ 0x53E8;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB4RL @ 0x53E9;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB5RH @ 0x53EA;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB5RL @ 0x53EB;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB6RH @ 0x53EC;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB6RL @ 0x53ED;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB7RH @ 0x53EE;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB7RL @ 0x53EF;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB8RH @ 0x53F0;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB8RL @ 0x53F1;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB9RH @ 0x53F2;;
/* ADC data buffer registers */
__near __no_init volatile const unsigned char ADC_DB9RL @ 0x53F3;;
/* ADC control/status register */

typedef struct
{
  unsigned char CH          : 4;
  unsigned char AWDIE       : 1;
  unsigned char EOCIE       : 1;
  unsigned char AWD         : 1;
  unsigned char EOC         : 1;
} __BITS_ADC_CSR;

__near __no_init volatile  union { unsigned char ADC_CSR; __BITS_ADC_CSR ADC_CSR_bit; } @ 0x5400;;

/* ADC configuration register 1 */

typedef struct
{
  unsigned char ADON        : 1;
  unsigned char CONT        : 1;
  unsigned char             : 2;
  unsigned char SPSEL       : 3;
} __BITS_ADC_CR1;

__near __no_init volatile  union { unsigned char ADC_CR1; __BITS_ADC_CR1 ADC_CR1_bit; } @ 0x5401;;

/* ADC configuration register 2 */

typedef struct
{
  unsigned char             : 1;
  unsigned char SCAN        : 1;
  unsigned char             : 1;
  unsigned char ALIGN       : 1;
  unsigned char EXTSEL      : 2;
  unsigned char EXTTRIG     : 1;
} __BITS_ADC_CR2;

__near __no_init volatile  union { unsigned char ADC_CR2; __BITS_ADC_CR2 ADC_CR2_bit; } @ 0x5402;;

/* ADC configuration register 3 */

typedef struct
{
  unsigned char             : 6;
  unsigned char OVR         : 1;
  unsigned char DBUF        : 1;
} __BITS_ADC_CR3;

__near __no_init volatile  union { unsigned char ADC_CR3; __BITS_ADC_CR3 ADC_CR3_bit; } @ 0x5403;;

/* ADC data register high */
__near __no_init volatile const unsigned char ADC_DRH @ 0x5404;;
/* ADC data register low */
__near __no_init volatile const unsigned char ADC_DRL @ 0x5405;;
/* ADC Schmitt trigger disable register high */
__near __no_init volatile  unsigned char ADC_TDRH @ 0x5406;;
/* ADC Schmitt trigger disable register low */
__near __no_init volatile  unsigned char ADC_TDRL @ 0x5407;;
/* ADC high threshold register high */
__near __no_init volatile  unsigned char ADC_HTRH @ 0x5408;;
/* ADC high threshold register low */

typedef struct
{
  unsigned char HT          : 2;
} __BITS_ADC_HTRL;

__near __no_init volatile  union { unsigned char ADC_HTRL; __BITS_ADC_HTRL ADC_HTRL_bit; } @ 0x5409;;

/* ADC low threshold register high */
__near __no_init volatile  unsigned char ADC_LTRH @ 0x540A;;
/* ADC low threshold register low */

typedef struct
{
  unsigned char LT          : 2;
} __BITS_ADC_LTRL;

__near __no_init volatile  union { unsigned char ADC_LTRL; __BITS_ADC_LTRL ADC_LTRL_bit; } @ 0x540B;;

/* ADC analog watchdog status register high */

typedef struct
{
  unsigned char AWS8        : 1;
  unsigned char AWS9        : 1;
} __BITS_ADC_AWSRH;

__near __no_init volatile  union { unsigned char ADC_AWSRH; __BITS_ADC_AWSRH ADC_AWSRH_bit; } @ 0x540C;;

/* ADC analog watchdog status register low */

typedef struct
{
  unsigned char AWS0        : 1;
  unsigned char AWS1        : 1;
  unsigned char AWS2        : 1;
  unsigned char AWS3        : 1;
  unsigned char AWS4        : 1;
  unsigned char AWS5        : 1;
  unsigned char AWS6        : 1;
  unsigned char AWS7        : 1;
} __BITS_ADC_AWSRL;

__near __no_init volatile  union { unsigned char ADC_AWSRL; __BITS_ADC_AWSRL ADC_AWSRL_bit; } @ 0x540D;;

/* ADC analog watchdog control register high */

typedef struct
{
  unsigned char AWEN8       : 1;
  unsigned char AWEN9       : 1;
} __BITS_ADC_AWCRH;

__near __no_init volatile  union { unsigned char ADC_AWCRH; __BITS_ADC_AWCRH ADC_AWCRH_bit; } @ 0x540E;;

/* ADC analog watchdog control register low */

typedef struct
{
  unsigned char AWEN0       : 1;
  unsigned char AWEN1       : 1;
  unsigned char AWEN2       : 1;
  unsigned char AWEN3       : 1;
  unsigned char AWEN4       : 1;
  unsigned char AWEN5       : 1;
  unsigned char AWEN6       : 1;
  unsigned char AWEN7       : 1;
} __BITS_ADC_AWCRL;

__near __no_init volatile  union { unsigned char ADC_AWCRL; __BITS_ADC_AWCRL ADC_AWCRL_bit; } @ 0x540F;;


/*-------------------------------------------------------------------------
 *      ADC1 bit fields
 *-----------------------------------------------------------------------*/



























#line 3659 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"




#line 3671 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"



/*-------------------------------------------------------------------------
 *      ADC1 bit masks
 *-----------------------------------------------------------------------*/

























#line 3710 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"




#line 3722 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


/*-------------------------------------------------------------------------
 *      CPU register definitions
 *-----------------------------------------------------------------------*/
/* Accumulator */
__near __no_init volatile  unsigned char CPU_A @ 0x7F00;;
/* Program counter extended */
__near __no_init volatile  unsigned char CPU_PCE @ 0x7F01;;
/* Program counter high */
__near __no_init volatile  unsigned char CPU_PCH @ 0x7F02;;
/* Program counter low */
__near __no_init volatile  unsigned char CPU_PCL @ 0x7F03;;
/* X index register high */
__near __no_init volatile  unsigned char CPU_XH @ 0x7F04;;
/* X index register low */
__near __no_init volatile  unsigned char CPU_XL @ 0x7F05;;
/* Y index register high */
__near __no_init volatile  unsigned char CPU_YH @ 0x7F06;;
/* Y index register low */
__near __no_init volatile  unsigned char CPU_YL @ 0x7F07;;
/* Stack pointer high */
__near __no_init volatile  unsigned char CPU_SPH @ 0x7F08;;
/* Stack pointer low */
__near __no_init volatile  unsigned char CPU_SPL @ 0x7F09;;
/* Condition code register */

typedef struct
{
  unsigned char C           : 1;
  unsigned char Z           : 1;
  unsigned char NF          : 1;
  unsigned char I0          : 1;
  unsigned char H           : 1;
  unsigned char I1          : 1;
  unsigned char             : 1;
  unsigned char V           : 1;
} __BITS_CPU_CCR;

__near __no_init volatile  union { unsigned char CPU_CCR; __BITS_CPU_CCR CPU_CCR_bit; } @ 0x7F0A;;

/* Global configuration register */

typedef struct
{
  unsigned char SWO         : 1;
  unsigned char AL          : 1;
} __BITS_CPU_CFG_GCR;

__near __no_init volatile  union { unsigned char CPU_CFG_GCR; __BITS_CPU_CFG_GCR CPU_CFG_GCR_bit; } @ 0x7F60;;


/*-------------------------------------------------------------------------
 *      CPU bit fields
 *-----------------------------------------------------------------------*/


#line 3786 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"






/*-------------------------------------------------------------------------
 *      CPU bit masks
 *-----------------------------------------------------------------------*/
#line 3802 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"





/*-------------------------------------------------------------------------
 *      SWIM register definitions
 *-----------------------------------------------------------------------*/
/* SWIM control status register */
__near __no_init volatile  unsigned char SWIM_CSR @ 0x7F80;;


/*-------------------------------------------------------------------------
 *      DM register definitions
 *-----------------------------------------------------------------------*/
/* DM breakpoint 1 register extended byte */
__near __no_init volatile  unsigned char DM_BK1RE @ 0x7F90;;
/* DM breakpoint 1 register high byte */
__near __no_init volatile  unsigned char DM_BK1RH @ 0x7F91;;
/* DM breakpoint 1 register low byte */
__near __no_init volatile  unsigned char DM_BK1RL @ 0x7F92;;
/* DM breakpoint 2 register extended byte */
__near __no_init volatile  unsigned char DM_BK2RE @ 0x7F93;;
/* DM breakpoint 2 register high byte */
__near __no_init volatile  unsigned char DM_BK2RH @ 0x7F94;;
/* DM breakpoint 2 register low byte */
__near __no_init volatile  unsigned char DM_BK2RL @ 0x7F95;;
/* DM debug module control register 1 */
__near __no_init volatile  unsigned char DM_CR1 @ 0x7F96;;
/* DM debug module control register 2 */
__near __no_init volatile  unsigned char DM_CR2 @ 0x7F97;;
/* DM debug module control/status register 1 */
__near __no_init volatile  unsigned char DM_CSR1 @ 0x7F98;;
/* DM debug module control/status register 2 */
__near __no_init volatile  unsigned char DM_CSR2 @ 0x7F99;;
/* DM enable function register */
__near __no_init volatile  unsigned char DM_ENFCTR @ 0x7F9A;;


/*-------------------------------------------------------------------------
 *      Interrupt vector numbers
 *
 *  Note: The vector numbers listed in ST's manuals for STM8 are offset
 *        by 2 compared to the vector numbers used by EWSTM8.
 *-----------------------------------------------------------------------*/
#line 3908 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\iostm8s003f3.h"


#pragma language=restore




/*----------------------------------------------
 *      End of file
 *--------------------------------------------*/
#line 60 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"
//#include <iostm8s103f3.h>
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"
/* stdint.h standard header */
/* Copyright 2003-2010 IAR Systems AB.  */
#line 235 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

#line 258 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 62 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"
     
/* Define STC-1000+ version number (XYY, X=major, YY=minor) */
/* Also, keep track of last version that has changes in EEPROM layout */



// Common-Cathode bits on PB5, PB4, PD5 and PD4






// ADC-channels AIN4 (PD3) and AIN3 (PD2) are used on PORTD

     
// For SWIM Debugging use 0x0C, for Production use 0x0E (PD1 = SWIM)



// Defines for outputs: Alarm = PD6, S3 = PA3, Cool = PA2, Heat = PA1





#line 103 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"

// PC7 PC6 PC5 PC4 PC3 PD3 PD2 PD1
//  D   E   F   G   dp  A   B   C
#line 142 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"

#line 151 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p.h"

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

#line 36 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
#line 1 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\eep.h"
/*==================================================================
  File Name    : eep.h
  Author       : Emile
  ------------------------------------------------------------------
  Purpose : This is the header-file for eep.c
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



#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"
/* stdint.h standard header */
/* Copyright 2003-2010 IAR Systems AB.  */
#line 235 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

#line 258 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 28 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\eep.h"


// EEPROM base address within STM8 uC


// Function prototypes
uint16_t eeprom_read_config(uint8_t eeprom_address);
void     eeprom_write_config(uint8_t eeprom_address,uint16_t data);

#line 37 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
#line 1 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\pid.h"
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
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"
/* stdint.h standard header */
/* Copyright 2003-2010 IAR Systems AB.  */
#line 235 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

#line 258 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 8.0\\stm8\\inc\\c\\stdint.h"

/*
 * Copyright (c) 1992-2009 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.04:0576 */
#line 26 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\pid.h"


// PID controller upper & lower limit [E-1 %]



//--------------------
// Function Prototypes
//--------------------
void init_pid(int16_t kc, uint16_t ti, uint16_t td, uint8_t ts, int16_t yk);
void pid_ctrl(int16_t yk, int16_t *uk, int16_t tset, _Bool pid_on);

#line 38 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"

// Define limits for temperatures in Fahrenheit and Celsius
#line 48 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"

#line 57 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"

// Values for temperature control STD






//---------------------------------------------------------------------------
// Basic defines for EEPROM config addresses
// One profile consists of several temp. time pairs and a final temperature
//
// Do NOT Forget to set:
// 1) proper #include in stc1000p.h: <iostm8s003f3.h> or <iostm8s103f3.h>
// 2) Project -> Options -> Target -> Device to STM8S003F3 or STM8S103F3
//---------------------------------------------------------------------------
#line 83 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"

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

    t_percentage,
    t_period,
    t_apflags,
    t_pumpflags, 

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
// cP   Manual mode Pump                                 0 (off) or 1 (on) 
// cO   Manual mode output                               -200 to +200 % 
// ASd  Safety shutdown timer                            0..999 minutes
// rUn	Run mode	                                 OFF, Pr (run program), 
//                                                       Ct (manual mode thermostat), Co (manual mode constant output)
//-----------------------------------------------------------------------------
#line 248 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"
            



// Generate enum values for each entry int the set menu
enum menu_enum 
{
    Sd, St, Pt1, Pd1, Pt2, Pd2, Pt3, Pd3, Pt4, Pd4, Pt5, Pd5, Pt6, Pd6, Ht, Hd, bt, bd, hd1, hd2, hd3, hd4, CF, tc, Hc, Ti, Td, Ts, APF, PF, Pd, cO, cSP, cP, ASd,
}; // menu_enum

//---------------------------------------------------------------------------
// Macros for calculation of EEPROM addresses
// One profile consists of several temp. time pairs and a final temperature
//---------------------------------------------------------------------------



// Find the parameter word address in EEPROM

// Help to convert menu item number and config item number to an EEPROM config address
#line 276 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.h"

// KEY_UP..KEY_S are the hardware bits on PORTC






// These are the bit-definitions in _buttons





// Helpful defines to handle buttons






// Defines for prx_led() function



// Defines for value_to_led() function




// Timers for state transition diagram. One-tick = 100 msec.






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

        
/* Menu struct */
struct s_menu 
{
   uint8_t led_c_10;
   uint8_t led_c_1;
   uint8_t led_c_01;
   uint8_t type;
}; // s_menu

// Menu struct data generator



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
void     pid_control(_Bool pid_run);
void     ovbsc_fsm(void); // in ovbsc.c
#line 32 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"

// LED character lookup table (0-9)
const uint8_t led_lookup[] = {(0xE7),(0x03),(0xD6),(0x97),(0x33),(0xB5),(0xF5),(0x07),(0xF7),(0xB7)};

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
#line 64 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
   0, 550, 530, 20, 620, 30, 720, 20, 780, 5, 0, 0, 0, 0, 985, 15, 1050, 90, 60, 45, 15, 5, 0, 0, 80, 280, 20, 10, 511, 6, 50, 80, 0, 0, 70, 1 // Last one is for POWER_ON
}; // eedata[]

// Global variables to hold LED data (for multiplexing purposes)
uint8_t led_e = {0x00};         // value of extra LEDs
uint8_t led_10, led_1, led_01;  // values of 10s, 1s and 0.1s

uint16_t cooling_delay = 60;    // Initial cooling delay
uint16_t heating_delay = 60;    // Initial heating delay
uint8_t  menustate     = MENU_IDLE; // Current STD state number for menu_fsm()
_Bool     menu_is_idle  = 1;  // No menu active within STD
_Bool     pwr_on        = 1;  // True = power ON, False = power OFF
_Bool     fahrenheit    = 0; // false = Celsius, true = Fahrenheit
_Bool     minutes       = 0; // timing control: false = hours, true = minutes
uint8_t  menu_item     = 0;     // Current menu-item: [0..NO_OF_PROFILES]
uint8_t  config_item   = 0;     // Current index within profile or parameter menu
uint8_t  m_countdown   = 0;     // Timer used within menu_fsm()
uint8_t  _buttons      = 0;     // Current and previous value of button states
int16_t  config_value;          // Current value of menu-item
int8_t   key_held_tmr;          // Timer for value change acceleration
uint8_t  sensor2_selected = 0;  // DOWN button pressed < 3 sec. shows 2nd temperature / pid_output
int16_t  setpoint;              // Setpoint temperature
uint16_t curr_dur = 0;          // local counter for temperature duration
int16_t  pid_out  = 0;          // Output from PID controller in E-1 %
int16_t  hysteresis;            // th-mode: hysteresis for temp probe ; pid-mode: lower hyst. limit in E-1 %
int16_t  hysteresis2;           // th-mode: hysteresis for 2nd temp probe ; pid-mode: upper hyst. limit in E-1 %

// External variables, defined in other files
extern _Bool     sound_alarm; // true = sound alarm
extern uint8_t  probe2;    // cached flag indicating whether 2nd probe is active
extern int16_t  temp_ntc1; // The temperature in E-1 °C from NTC probe 1
extern int16_t  temp_ntc2; // The temperature in E-1 °C from NTC probe 2
extern int16_t  kc;        // Parameter value for Kc value in %/°C
extern uint16_t ti;        // Parameter value for I action in seconds
extern uint16_t td;        // Parameter value for D action in seconds
extern uint8_t  ts;        // Parameter value for sample time [sec.]


extern _Bool     ovbsc_pause;
extern _Bool     ovbsc_off;
extern _Bool     ovbsc_pump_on;
extern _Bool     ovbsc_run_prg;
extern _Bool     ovbsc_pid_on;
extern _Bool     ovbsc_thermostat;
extern uint8_t  prg_state;
extern uint8_t  mashstep; 
extern uint16_t countdown;


// This contains the definition of the menu-items for the parameters menu
const struct s_menu menu[] = 
{
    { (0xB5), (0xD3), (0x00), t_duration }, { (0xB5), (0xF0), (0x00), t_temperature }, { (0x76), (0xF0), (0x03), t_temperature }, { (0x76), (0xD3), (0x03), t_duration }, { (0x76), (0xF0), (0xD6), t_temperature }, { (0x76), (0xD3), (0xD6), t_duration }, { (0x76), (0xF0), (0x97), t_temperature }, { (0x76), (0xD3), (0x97), t_duration }, { (0x76), (0xF0), (0x33), t_temperature }, { (0x76), (0xD3), (0x33), t_duration }, { (0x76), (0xF0), (0xB5), t_temperature }, { (0x76), (0xD3), (0xB5), t_duration }, { (0x76), (0xF0), (0xF5), t_temperature }, { (0x76), (0xD3), (0xF5), t_duration }, { (0x73), (0xF0), (0x00), t_temperature }, { (0x73), (0xD3), (0x00), t_duration }, { (0xF1), (0xF0), (0x00), t_temperature }, { (0xF1), (0xD3), (0x00), t_duration }, { (0x71), (0xD3), (0x03), t_duration }, { (0x71), (0xD3), (0xD6), t_duration }, { (0x71), (0xD3), (0x97), t_duration }, { (0x71), (0xD3), (0x33), t_duration }, { (0xE4), (0x74), (0x00), t_boolean }, { (0xF0), (0xD0), (0x00), t_tempdiff }, { (0x73), (0xD0), (0x00), t_parameter }, { (0xF0), (0x03), (0x00), t_parameter }, { (0xF0), (0xD3), (0x00), t_parameter }, { (0xF0), (0xB5), (0x00), t_parameter }, { (0x77), (0x76), (0x74), t_apflags }, { (0x76), (0x74), (0x00), t_pumpflags }, { (0x76), (0xD3), (0x00), t_period }, { (0xD0), (0xE7), (0x00), t_percentage }, { (0xD0), (0xB5), (0x76), t_temperature }, { (0xD0), (0x76), (0x00), t_boolean }, { (0x77), (0xB5), (0xD3), t_duration },
}; // menu[]


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
  Variables: mi:
  Returns  : -
  ---------------------------------------------------------------------------*/
void menu_to_led(uint8_t mi)
{
    // clear negative, deg, c and point indicators
    led_e &= ~((0x80) | (0x40) | (0x20) | (0x10));  
    if (mi < (sizeof(menu)/sizeof(menu[0])))
    {   // 
	led_10 = menu[mi].led_c_10;
	led_1  = menu[mi].led_c_1;
	led_01 = menu[mi].led_c_01;
    }
} // menu_to_led()
#line 197 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"

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

	led_e &= ~((0x80) | (0x40) | (0x20)); // clear negative, ° and Celsius symbols
        if (value < 0) 
        {  // Handle negative values
           led_e |= (0x80);
	   value  = -value;
	} // if

        if (mode == (1))
        {  // this is a temperature in E-1 °C
	   led_e |= (0x40);
           if (!fahrenheit) led_e |= (0x20); // Celsius symbol
           decimal = 1;
	} // if
        else if (mode == (2))
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
	   led_10 = (0x00); // Turn off led if zero (loose leading zeros)
	} // else
	if (value >= 10 || decimal || led_10 != (0x00))
        {  // If decimal, we want 1 leading zero
	   for (i = 0; value >= 10; i++)
           {
	      value -= 10;
	   } // for
	   led_1 = led_lookup[i];
	   if (decimal)
           {
	      led_1 |= (0x08);
	   } // if
	} else {
	   led_1 = (0x00); // Turn off led if zero (loose leading zeros)
	} // else
	led_01 = led_lookup[(uint8_t)value];
} // value_to_led()

#line 349 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"

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
    

    if (eeadr == (sizeof(menu)/sizeof(menu[0])))
    {
        t_max = 3;
#line 396 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
    } else { // Parameter menu
        type = menu[eeadr - (0)].type;
	if (type == t_temperature)
        {
	    t_min = (fahrenheit ? (-400) : (-400));
	    t_max = (fahrenheit ? (2500) : (1400));
	} else if (type == t_tempdiff)
        {   // the temperature correction variables
	    t_min = (fahrenheit ? (-100) : ( -50));
	    t_max = (fahrenheit ? ( 100) : ( 50));
	} else if (type == t_parameter)
	    {
		t_max = 9999;
                if (eeadr == ((0) + (Hc))) 
                {   // Kc parameter for PID: enable heating and cooling-loop
                    t_min = -9999; 
                } // if
	} else if (type == t_boolean)
        {   // the control variables
	    t_max = 1;

        } else if (type == t_percentage)
        {
            t_min = -200;
            t_max = 200;
        } else if (type == t_period)
        {
            t_min = 10;
            t_max = 200;
        } else if (type == t_apflags)
        {
            t_max = 511;
        } else if (type == t_pumpflags)
        {
            t_max = 31; 
#line 439 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
	} else if (type == t_sp_alarm)
        {
	    t_min = (fahrenheit ? (-800) : (-400));
	    t_max = (fahrenheit ? ( 800) : ( 400));
	} else if(type == t_step)
        {
	    t_max = (5);
	} else if (type == t_delay)
        {
	    t_max = 60;
	} else if (type == t_runmode)
        {
	    t_max = (4);
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

    PC_DDR &= ~((0x40) | (0x20) | (0x10) | (0x08));        // Set PC6..PC3 as inputs
    PC_CR1 |=  ((0x40) | (0x20) | (0x10) | (0x08));        // Enable pull-ups for PC6..PC3 (Rpu is approx 45k)
    for (b = 0; b < 10; b++) ; // give port a bit of time
    _buttons <<= 4;            // make room for new values of buttons
    b          = ((PC_IDR & ((0x40) | (0x20) | (0x10) | (0x08))) >> 3); // 3..0: UP, DOWN, PWR, S
    b          = (b ^ 0x0F) & 0x0F;         // Invert buttons (0 = pressed)
    _buttons  |= b;            // add buttons
    PC_DDR    |= ((0x40) | (0x20) | (0x10) | (0x08));      // Set PC6..PC3 to outputs again
    PC_CR1    |= ((0x40) | (0x20) | (0x10) | (0x08));      // Set PC6..PC3 to Push-Pull again
        
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



    uint8_t adr, type;
   
   if (m_countdown) m_countdown--; // countdown counter
    
   switch (menustate)
   {
       //--------------------------------------------------------------------         
       case MENU_IDLE:

            if (sound_alarm && ((_buttons & 0x0F) == 0) && ((_buttons & 0xF0) != 0))
            {
                sound_alarm = 0;
            }
            else if (((_buttons & ((0x22))) == (((0x22)) & 0xf0)))
            {
                ovbsc_pause = !ovbsc_pause;
            }
            else
#line 524 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
            {
                if (((_buttons & ((0x88) | (0x44))) == (((0x88) | (0x44)) & 0x0f))) 
                {   // UP and DOWN button pressed
                    menustate = MENU_SHOW_VERSION;
                } else if(((_buttons & ((0x88))) == (((0x88)) & 0x0f)))
                {   // UP button pressed
                    menustate = MENU_SHOW_STATE_UP;
                } else if(((_buttons & ((0x44))) == (((0x44)) & 0x0f)))
                {   // DOWN button pressed
                    m_countdown = (15);
                    menustate   = MENU_SHOW_STATE_DOWN;
                } else if(((_buttons & ((0x11))) == (((0x11)) & 0xf0)))
                {   // S button pressed

                    menustate = MENU_SHOW_CONFIG_ITEM;



                } // else if
	    } // else
	    break;
#line 566 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
       //--------------------------------------------------------------------         
       case MENU_SHOW_VERSION: // Show STC1000p version number
            value_to_led((210),(0));
	    led_10 |= (0x08);
            led_1  |= (0x08);
	    led_e  &= ~((0x40) | (0x20)); // clear ° and Celsius symbols
	    if(!((_buttons & ((0x88) | (0x44))) == ((0x88) | (0x44)))) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_UP: // Show setpoint value

           if (ovbsc_off)
           {
               led_10 = (0xE7);
               led_1  = (0x74);
               led_01 = (0x74);
               led_e  = (0x00); // clear negative, ° and Celsius symbols
           } // if
           else if (ovbsc_pause)
           {
               led_10 = (0x76);
               led_1  = (0xB5);
               led_01 = (0xF4);
               led_e  = (0x00); // clear negative, ° and Celsius symbols
           } // else
           else if (ovbsc_pid_on)
                value_to_led(setpoint,(1));
           else value_to_led(pid_out,(0));





	    if(!((_buttons & ((0x88))) == ((0x88)))) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_DOWN: // Show Profile-number

           if (ovbsc_off)
           {
               led_10 = (0xE7);
               led_1  = (0x74);
               led_01 = (0x74);
               led_e  = (0x00); // clear negative, ° and Celsius symbols
           } // if
           else if(ovbsc_run_prg)
           {
		led_01 = (0x00);
		led_e  = (0x00);
		if (prg_state == PRG_WAIT_STRIKE)
                {
                    led_10 = (0xB5);
                    led_1  = (0xD3);
		} 
                else if (prg_state == PRG_STRIKE)
                {
                    led_10 = (0xB5);
                    led_1  = (0xF0);
		} 
                else if (prg_state == PRG_INIT_MASH_STEP)
                {
                    led_10 = (0x76);
                    led_1  = (0xE3);
                    led_01 = led_lookup[mashstep+1];
		} 
                else if (prg_state == PRG_MASH)
                {
                    led_10 = (0x00);
                    led_1  = (0x76);
                    led_01 = led_lookup[mashstep+1];
		} 
                else if (prg_state == PRG_INIT_BOIL_UP)
                {
                    led_10 = (0xF1);
                    led_1  = (0xE3);
		} 
                else if (prg_state == PRG_HOTBREAK)
                {
                    led_10 = (0x73);
                    led_1  = (0xF1);
		} 
                else if (prg_state == PRG_BOIL)
                {
                    led_10 = (0xF1);
                    led_1  = (0x00);
		}
	   } // if (ovbsc_run_prg)
           else if (ovbsc_thermostat)
           {
                led_10 = (0xE4);
		led_1  = (0xF0);
		led_01 = (0x00);
		led_e  = (0x00);
	   } // else if
           else
           {
		led_10 = (0xE4);
		led_1  = (0xE7);
		led_01 = (0x00);
		led_e  = (0x00);
	   } // else
	   if (m_countdown == 0)
           {
                m_countdown = 20;
		if ((prg_state == PRG_WAIT_STRIKE) || (prg_state == PRG_MASH) || 
                    (prg_state >= PRG_HOTBREAK))
                {
                    menustate = MENU_SHOW_STATE_DOWN_2;
		} // if
	   } // if 
#line 685 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
	    if(!((_buttons & ((0x44))) == ((0x44)))) menustate = MENU_IDLE;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SHOW_STATE_DOWN_2: // Show current step number within profile

           value_to_led(countdown,(0));
           if (m_countdown == 0)
           {
               m_countdown = 20;
               menustate = MENU_SHOW_STATE_DOWN;
#line 702 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
	    } // if
	    if(!((_buttons & ((0x44))) == ((0x44)))) menustate = MENU_IDLE;
	    break;
#line 747 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
       //--------------------------------------------------------------------         
       case MENU_SHOW_CONFIG_ITEM: // S-button is released
	    led_e &= ~((0x80) | (0x40) | (0x20)); // clear negative, ° and Celsius symbols

            value_to_led(config_item,(0));
#line 771 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
	    m_countdown = (150);
	    menustate   = MENU_SET_CONFIG_ITEM;
	    break;
       //--------------------------------------------------------------------         
       case MENU_SET_CONFIG_ITEM:
	    if(m_countdown == 0)
            {   // Timeout, go back to idle state
                menustate = MENU_IDLE;
	    } else if(((_buttons & ((0x22))) == (((0x22)) & 0xf0)))
            {   // Go back

                menustate = MENU_IDLE;
            } 
            else if(((_buttons & ((0x88))) == (((0x88)) & 0xf0)))
            {
                config_item++;
                if (config_item > (sizeof(menu)/sizeof(menu[0])))
                {
                    config_item = 0;
                } // if
                menustate = MENU_SHOW_CONFIG_ITEM;
            } 
            else if (((_buttons & ((0x44))) == (((0x44)) & 0xf0)))
            {
                config_item--;
                if (config_item > (sizeof(menu)/sizeof(menu[0])))
                {
                    config_item = (sizeof(menu)/sizeof(menu[0]));
                } // if
                menustate = MENU_SHOW_CONFIG_ITEM;
            } 
            else if (((_buttons & ((0x11))) == (((0x11)) & 0xf0)))
            {
                if (config_item < (sizeof(menu)/sizeof(menu[0])))
                {
                    config_value = eeprom_read_config(config_item);
                } 
                else 
                {
                    if (ovbsc_off)
                    {
                        config_value = 0;
                    } 
                    else if (ovbsc_run_prg)
                    {
                        config_value = 1;
                    } 
                    else if (ovbsc_thermostat)
                    {
                        config_value = 2;
                    } 
                    else 
                    {
                        config_value = 3;
                    } // else
                } // else
                menustate = MENU_SHOW_CONFIG_VALUE;
            } // else
#line 886 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
            break; // MENU_SET_CONFIG_ITEM
       //--------------------------------------------------------------------         
       case MENU_SHOW_CONFIG_VALUE:

            if (config_item < (sizeof(menu)/sizeof(menu[0])))
            {
                type = menu[config_item].type;
                if (((type) <= t_tempdiff))
                {   // temperature, display in 0.1
                    value_to_led(config_value,(1));
                } 
                else if (type == t_period)
                {
                    value_to_led(config_value,(2));
                } // else 
                else 
                {
                    value_to_led(config_value,(0));
                } // else
            } else {
                    led_e = (0x00); // clear negative, ° and Celsius symbols
                    if (config_value == 0)
                    {
                            led_10 = (0xE7);
                            led_1  = (0x74);
                            led_01 = (0x74);
                    } // if
                    else if (config_value == 1)
                    {
                            led_10 = (0x76);
                            led_1  = (0x50);
                            led_01 = (0x00);
                    } // else if
                    else if (config_value == 2)
                    {
                            led_10 = (0xD0);
                            led_1  = (0xF0);
                            led_01 = (0x00);
                    } // else if
                    else 
                    {
                            led_10 = (0xD0);
                            led_1  = (0xE7);
                            led_01 = (0x00);
                    } // else
            } 
#line 950 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
            m_countdown  = (150);
            menustate    = MENU_SET_CONFIG_VALUE;
            break;
       //--------------------------------------------------------------------         
       case MENU_SET_CONFIG_VALUE:

           adr = config_item;



            if (m_countdown == 0)
            {
                menustate = MENU_IDLE;
            } 
            else if (((_buttons & ((0x22))) == (((0x22)) & 0xf0)))
            {
                menustate = MENU_SHOW_CONFIG_ITEM;
            } 
            else if(((_buttons & ((0x88)) & 0xf0))) 
            {
                config_value++;
                if ((config_value > 1000) || (--key_held_tmr < 0))
                {
                    config_value += 9;
                } // if
                /* Jump to exit code shared with BTN_DOWN case */
                goto chk_cfg_acc_label;
            } 
            else if(((_buttons & ((0x44)) & 0xf0))) 
            {
                config_value--;
                if ((config_value > 1000) || (--key_held_tmr < 0))
                {
                    config_value -= 9;
                } // if
            chk_cfg_acc_label: // label for goto
                config_value = check_config_value(config_value, adr);
                menustate    = MENU_SHOW_CONFIG_VALUE;
            } 
            else if(((_buttons & ((0x11))) == (((0x11)) & 0xf0)))
            {

                if (config_item < (sizeof(menu)/sizeof(menu[0])))
                {
                    eeprom_write_config(config_item, config_value);
                } // if
                else 
                {
                    if (config_value == 0)
                    {   // OFF
                        ovbsc_off        = 1;
                        ovbsc_run_prg    = 0;
                        ovbsc_pump_on    = 0;
                        ovbsc_thermostat = 0;
                    } // if
                    else if (config_value == 1)
                    {    // Pr
                        ovbsc_off        = 0;
                        ovbsc_run_prg    = 1;
                    } // else
                    else if (config_value == 2)
                    {    // Ct
                        ovbsc_off        = 0;
                        ovbsc_run_prg    = 0;
                        ovbsc_thermostat = 1;
                    } // else
                    else 
                    {    // Co
                        ovbsc_off        = 0;
                        ovbsc_run_prg    = 0;
                        ovbsc_thermostat = 0;
                    } // else
                } // else
#line 1048 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"
                menustate = MENU_SHOW_CONFIG_ITEM;
            } else 
            {   // reset timer to default value
                key_held_tmr = (20); 
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
   
    retv = eeprom_read_config(((0) + (x))) << 6; // * 64
    retv = retv - (retv >> 4); // 64 - 4 = 60
    return retv;
} // min_to_sec()

#line 1165 "D:\\ownCloud\\Programming\\stc1000_stm8\\src\\stc1000p_lib.c"

/*-----------------------------------------------------------------------------
  Purpose  : This routine controls the PID controller. It should be 
             called once every second by ctrl_task() as long as TS is not 0. 
             The PID controller itself is called every TS seconds.
  Variables: -
  Returns  : -
  ---------------------------------------------------------------------------*/
void pid_control(_Bool pid_run)
{
    static uint8_t pid_tmr = 0;
    
    if (kc != eeprom_read_config(((0) + (Hc))) ||
        ti != eeprom_read_config(((0) + (Ti))) ||
        td != eeprom_read_config(((0) + (Td))))
    {   // One or more PID parameters have changed
       kc = eeprom_read_config(((0) + (Hc)));
       ti = eeprom_read_config(((0) + (Ti)));
       td = eeprom_read_config(((0) + (Td)));
       init_pid(kc,ti,td,ts,temp_ntc1); // Init PID controller
    } // if
    
    if (++pid_tmr >= ts) 
    {   // Call PID controller every TS seconds
        pid_ctrl(temp_ntc1,&pid_out,setpoint,pid_run);
        pid_tmr = 0;
    } // if
} // pid_control()
