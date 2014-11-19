//
//  LC_Model+LCUISignal.m
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_Model+LCUISignal.h"

@implementation LC_Model (LCUISignal)

- (LC_UISignal *)sendUISignal:(NSString *)name
{
    return [self sendUISignal:name withObject:nil from:self];
}

- (LC_UISignal *)sendUISignal:(NSString *)name withObject:(NSObject *)object
{
    return [self sendUISignal:name withObject:object from:self];
}

- (LC_UISignal *)sendUISignal:(NSString *)name withObject:(NSObject *)object from:(id)source
{
    LC_UISignal * signal = [LC_UISignal signal];
    
    if ( signal )
    {
        signal.source = source ? source : self;
        signal.name = name;
        signal.object = object;
        
        for (id observer in self.observers) {
            
            [signal forward:observer];
        }
    }
    return signal;
}

@end
