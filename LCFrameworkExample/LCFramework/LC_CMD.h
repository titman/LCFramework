//
//  LC_CMD.h
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//


#define LC_CMD_SEE @"see"

    #define LC_CMD_CURRENT_RUNNING_TIMER @"rt"    
        #define LC_CMD_CURRENT_RUNNING_TIMER_DES @"See all running timers."
    #define LC_CMD_CURRENT_WEB_IMAGE_CACHE @"wic" 
        #define LC_CMD_CURRENT_WEB_IMAGE_CACHE_DES @"See all web image cache."
    #define LC_CMD_CURRENT_DATASOURCE @"ds"      
        #define LC_CMD_CURRENT_DATASOURCE_DES @"See all LC_Datasource object."
    #define LC_CMD_CURRENT_INSTENCE @"it"         
        #define LC_CMD_CURRENT_INSTENCE_DES @"See all instence object."


#define LC_CMD_ACTION @"action"

    #define LC_CMD_EXIT @"exit"                
        #define LC_CMD_EXIT_DES @"Exit this application."




#define LC_CMD_HELPER [NSString stringWithFormat:@"%@ : \n \
%@ - %@ \n \
%@ - %@ \n \
%@ - %@ \n \
%@ - %@ \n \
",LC_CMD_SEE,LC_CMD_CURRENT_RUNNING_TIMER,LC_CMD_CURRENT_RUNNING_TIMER_DES,LC_CMD_CURRENT_WEB_IMAGE_CACHE,LC_CMD_CURRENT_WEB_IMAGE_CACHE_DES,LC_CMD_CURRENT_DATASOURCE,LC_CMD_CURRENT_DATASOURCE_DES,LC_CMD_CURRENT_INSTENCE,LC_CMD_CURRENT_INSTENCE_DES]