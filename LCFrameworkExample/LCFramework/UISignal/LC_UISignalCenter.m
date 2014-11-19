//
//  LC_UISignalCenter.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//
//

#import "LC_UISignalCenter.h"

@implementation LC_UISignalCenter

+ (BOOL)send:(LC_UISignal *)signal
{
	return [[LC_UISignalCenter LCInstance] send:signal];
}

+(BOOL) forward:(id)object signal:(LC_UISignal *)signal
{
    return [[LC_UISignalCenter LCInstance] forward:object signal:signal];
}


- (BOOL)send:(LC_UISignal *)signal
{
    INFO(@"[LC_UISignal] send [Signal name : %@ from : %@ ]",signal.name,[signal.source class]);
    
    return [self routes:signal];
}

-(BOOL) forward:(id)object signal:(LC_UISignal *)signal
{
    INFO(@"[LC_UISignal] forward [Signal name : %@ from : %@ to : %@ ]",signal.name,[signal.source class],[object class]);

    NSString * selectorName = [NSString stringWithFormat:@"handleUISignal_%@:", signal.name];
    SEL selector = NSSelectorFromString( selectorName );
    
    [self performSelector:selector target:object object:signal];
    
    return YES;
}

- (BOOL)routes:(LC_UISignal *)signal
{
    if ([[signal.source signalTarget] isKindOfClass:[UIView class]]) {
        
        BOOL result = NO;;
        
        UIView * sourceView = signal.source;
        UIView * superView = sourceView;
        
        NSString * selectorName = [NSString stringWithFormat:@"handleUISignal_%@:", signal.name];
        SEL selector = NSSelectorFromString( selectorName );
        
        UIViewController * viewController = superView.viewController;

        if (viewController) {
            
            [self performSelector:selector target:viewController object:signal];

            return result = YES;
        }
        
        while (superView) {
            
            [self performSelector:selector target:superView object:signal];
            
            UIView * tmp = superView.superview;
            
            viewController = tmp.viewController;
            
            if (viewController) {
                [self performSelector:selector target:viewController object:signal];
                return result = YES;
            }
            
            superView = tmp;
            
            result = YES;
        }
        
        return result;
        
    }
    else{
        
        return NO;
    }
}

-(void) performSelector:(SEL)aSelector target:(id)target object:(id)object
{
    if ([target respondsToSelector:aSelector]) {
        
        [target performSelector:aSelector withObject:object];
    }
}

@end
