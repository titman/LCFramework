//
//  LC_CrashReport.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#if __cplusplus
extern "C" {
#endif
    
	void LCCrashReport( NSException * exception );
    
#if __cplusplus
};
#endif

#import "NSObject+LCNotification.h"

LC_NOTIFICATION_SET(LCCrashReportNotification,@"LCCrashReportNotification")

@interface LC_CrashReport : NSObject

+(void) printfCrashLog;
+(void) cleanCrashLog;

+(NSMutableArray *) crashLog;

@end
