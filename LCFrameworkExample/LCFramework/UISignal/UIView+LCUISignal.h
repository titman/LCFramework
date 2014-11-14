//
//  UIView+LCUISignal.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

@class LC_UISignal;

@interface UIView (LCUISignal)

- (LC_UISignal *)sendUISignal:(NSString *)name;

@end
