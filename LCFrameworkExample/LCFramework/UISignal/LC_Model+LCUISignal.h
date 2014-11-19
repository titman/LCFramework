//
//  LC_Model+LCUISignal.h
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_Model.h"

@interface LC_Model (LCUISignal)

- (LC_UISignal *)sendUISignal:(NSString *)name;

- (LC_UISignal *)sendUISignal:(NSString *)name withObject:(NSObject *)object;

@end
