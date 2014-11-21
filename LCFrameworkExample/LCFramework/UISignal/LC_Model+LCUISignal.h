//
//  LC_Model+LCUISignal.h
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Model.h"

@interface LC_Model (LCUISignal)

- (LC_UISignal *)sendUISignal:(NSString *)name;

- (LC_UISignal *)sendUISignal:(NSString *)name withObject:(NSObject *)object;

@end
