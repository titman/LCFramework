//
//  LC_Localized.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

#define LC_LO(key) LC_LOCALED_STRING(key)
#define LC_LOCALED_STRING(key) [LC_Localized localizedStringForKey:key]

@interface LC_Localized : NSObject

+ (NSString *) localizedStringForKey:(NSString *)key;
+ (NSString *) localizedStringForKey:(NSString *)key defaultString:(NSString *)defaultString;

@end
