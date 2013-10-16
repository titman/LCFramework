//
//  LC_CrashReport.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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

