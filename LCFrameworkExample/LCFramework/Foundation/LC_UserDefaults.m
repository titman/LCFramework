//
//  LC_UserDefaults.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UserDefaults.h"

#define STANDAR_USER_DEFAULTS [NSUserDefaults standardUserDefaults]

@implementation LC_UserDefaults

+(BOOL) setObject:(id)object forKey:(NSString *)key
{
    [STANDAR_USER_DEFAULTS setObject:object forKey:key];
    return [STANDAR_USER_DEFAULTS synchronize];
}

+(id) objectForKey:(NSString *)key
{
    return [STANDAR_USER_DEFAULTS objectForKey:key];
}

@end
