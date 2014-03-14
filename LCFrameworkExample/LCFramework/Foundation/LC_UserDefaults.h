//
//  LC_UserDefaults.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_UserDefaults : NSUserDefaults

+ (BOOL)setObject:(id)object forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

@end
