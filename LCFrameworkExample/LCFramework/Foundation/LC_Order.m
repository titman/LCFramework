//
//  LC_Order.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-16.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_Order.h"

static NSMutableDictionary * ___ORDER_CENTER = nil;

@implementation LC_Order

+(NSMutableDictionary *) orderCenter
{
    if (!___ORDER_CENTER) {
        
        ___ORDER_CENTER = [[NSMutableDictionary dictionary] retain];
    }
    
    return ___ORDER_CENTER;
}


+(BOOL) addOrder:(NSString *)order toObject:(id)object
{
    LC_Order.orderCenter.APPEND([LC_Order realOder:order object:object],object);
    
    return YES;
}

+(BOOL) removeOrder:(NSString *)order fromObject:(id)object
{
    [LC_Order.orderCenter removeObjectForKey:[LC_Order realOder:order object:object]];
    
    return YES;
}

+(BOOL) impOrder:(NSString *)order toObject:(id)object
{
    NSString * selectorName = [NSString stringWithFormat:@"handleOrder_%@:", [LC_Order realOder:order object:object]];
    SEL selector = NSSelectorFromString( selectorName );
    
    UIViewController * viewController = superView.viewController;
    
    if (object && selector) {
        
        [self performSelector:selector target:viewController object:self];
    }
    
    if (viewController) {
        
        
    }
}

+(NSString *)realOder:(NSString *)order object:(NSString *)object;
{
    return LC_NSSTRING_FORMAT(@"LC-ORDER-%@-%p",order,object);
}

+(void) performSelector:(SEL)aSelector target:(id)target object:(id)object
{
    if ([target respondsToSelector:aSelector]) {
        
        [target performSelector:aSelector withObject:object];
    }
}

@end
