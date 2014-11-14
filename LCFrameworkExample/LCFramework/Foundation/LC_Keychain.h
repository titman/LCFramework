//
//  LC_Keychain.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_Keychain : NSObject

+ (BOOL)setObject:(id<NSCopying>)object forKey:(id<NSCopying>)key;

+ (id)objectForKey:(id)key;

+ (BOOL)removeObjectForKey:(id)key;

@end
