//
//  LC_UISignalCenter.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

@class LC_UISignal;

@interface LC_UISignalCenter : NSObject

+ (BOOL)send:(LC_UISignal *)signal;
+ (BOOL)forward:(id)object signal:(LC_UISignal *)signal;

@end
