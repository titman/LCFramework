//
//  LC_Localized.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Localized.h"

@implementation LC_Localized



+ (NSString *) localizedStringForKey:(NSString *)key
{
    return [LC_Localized localizedStringForKey:key defaultString:key];
}

+ (NSString *)localizedStringForKey:(NSString *)key defaultString:(NSString *)defaultString
{
    static NSBundle * bundle = nil;
    if (bundle == nil)
    {
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"LCInternationalization" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle mainBundle];
        
        for (NSString * language in [NSLocale preferredLanguages])
        {
            if ([[bundle localizations] containsObject:language])
            {
                bundlePath = [bundle pathForResource:language ofType:@"lproj"];
                bundle = [NSBundle bundleWithPath:bundlePath];
                break;
            }
        }
    }
    
    defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
    
    return [[NSBundle mainBundle] localizedStringForKey:key value:defaultString table:nil];
}

@end
