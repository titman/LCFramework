//
//  LC_CrashReport.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_CrashReport.h"
#import "LC_Precompile.h"

#define LC_CRASH_REPORT_CACHE_FILE [NSString stringWithFormat:@"%@/crash.list",[LC_Sanbox libCachePath]]

extern "C" void LCCrashReport( NSException * exception )
{
#if defined(LC_CRASH_REPORT) && LC_CRASH_REPORT
    
    if (![LC_FileManager fileExistsAtPath:LC_CRASH_REPORT_CACHE_FILE]) {
        
        NSMutableArray * array = [[NSMutableArray alloc] init];
        [array writeToFile:LC_CRASH_REPORT_CACHE_FILE atomically:YES];
        [array release];
    }
    
    NSString * exc = [NSString stringWithFormat:@"%@",exception];
    NSString * css = [NSString stringWithFormat:@"%@",[exception callStackSymbols]];
    NSString * date = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSDictionary * crashData = @{@"exception":exc,@"callStackSymbols":css,@"date":date};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LCCrashReportNotification object:crashData];
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithContentsOfFile:LC_CRASH_REPORT_CACHE_FILE];
    [array addObject:crashData];
        
    [array writeToFile:LC_CRASH_REPORT_CACHE_FILE atomically:YES];
    [array release];
    
#endif
}

@implementation LC_CrashReport

+(void) load
{
#if defined(LC_CRASH_REPORT) && LC_CRASH_REPORT    
        NSSetUncaughtExceptionHandler(&LCCrashReport);
#endif
}

+(void) printfCrashLog
{
    NSLog(@"----------Crash Log----------");
    
    for (NSDictionary * dic in [LC_CrashReport crashLog]) {
        
        NSLog(@">>> crash date : %@",[dic objectForKey:@"date"]);
        NSLog(@">>> callStackSymbols : \n%@ ",[dic objectForKey:@"callStackSymbols"]);
        NSLog(@">>> exception : \n%@",[dic objectForKey:@"exception"]);
        NSLog(@"///////////////////////////////////////\n");

    }
}

+(NSMutableArray *) crashLog
{
    return [NSMutableArray arrayWithContentsOfFile:LC_CRASH_REPORT_CACHE_FILE];
}

+(void) cleanCrashLog
{
    [[NSMutableArray array] writeToFile:LC_CRASH_REPORT_CACHE_FILE atomically:YES];
}


@end

