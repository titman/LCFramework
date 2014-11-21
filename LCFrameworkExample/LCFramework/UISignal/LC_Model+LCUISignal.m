//
//  LC_Model+LCUISignal.m
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
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
