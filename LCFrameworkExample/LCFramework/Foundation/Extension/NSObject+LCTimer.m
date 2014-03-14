//
//  NSObject+LCTimer.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCTimer.h"

#define KEY_TIMERNAME @"NSTimer.name"
#define KEY_TIMES @"NSObject.times"


@implementation NSTimer (LCTimer)

-(BOOL) is:(NSString *)timerName
{
    if ([self.timerName isEqualToString:timerName]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)timerName
{
	NSObject * obj = objc_getAssociatedObject( self, KEY_TIMERNAME );
	if ( obj && [obj isKindOfClass:[NSString class]] )
		return (NSString *)obj;
	
	return nil;
}

- (void)setTimerName:(NSString *)timerName
{
	objc_setAssociatedObject( self, KEY_TIMERNAME, timerName, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

@end

@implementation NSObject (LCTimer)


- (NSMutableDictionary *) timers
{
	NSObject * obj = objc_getAssociatedObject( self, KEY_TIMES );
    
    if (!obj) {
        NSMutableDictionary * timers = [NSMutableDictionary dictionary];
        [self setTimers:timers];
        return timers;
    }else if ( obj && [obj isKindOfClass:[NSMutableDictionary class]] )
		return (NSMutableDictionary *)obj;
	
	return nil;
}

- (void)setTimers:(NSMutableDictionary *)timers
{
	objc_setAssociatedObject( self, KEY_TIMES, timers, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}


- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat
{
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:repeat];
}

- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat name:(NSString *)name
{
    if ([self.timers objectForKey:name]) {
        return [self.timers objectForKey:name];
    }
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:repeat];
    timer.timerName = name;
    [self.timers setObject:timer forKey:name];
    return timer;
}

- (void)cancelTimer:(NSString *)name
{
    NSTimer * timer = [self.timers objectForKey:name];
    
    if (timer) {
        [timer invalidate];
        [self.timers removeObjectForKey:name];
    }
}

- (void)cancelAllTimers
{
    for (NSString * key in self.timers.allKeys) {
        
        NSTimer * timer = [self.timers objectForKey:key];
        [timer invalidate];
        
        [self.timers removeObjectForKey:key];
    }
}

- (void)handleTimer:(NSTimer *)timer
{
    ;
}

@end
