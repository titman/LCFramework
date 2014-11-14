//
//  NSObject+LCTimer.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCTimer.h"

#define KEY_TIMERNAME @"NSTimer.name"
#define KEY_TIMES @"NSObject.timers"

static NSMutableDictionary * __allTimers;

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

#pragma mark -

+ (NSString *) runningTimerInfo
{
    if (!__allTimers) {
        return @"No running timer, or no use NSObject+LCTimer.";
    }
    
    NSMutableString * info = [NSMutableString string];
    
    for (NSString * key in __allTimers.allKeys) {
        
        NSString * oneInfo = __allTimers[key];
        
        [info appendFormat:@"%@\n",oneInfo];
    }
    
    return info;
}

+(void) setTimerInfo:(NSString *)timerInfo key:(NSString *)key
{
    if (!__allTimers) {
        __allTimers = [[NSMutableDictionary dictionary] retain];
    }
    
    [__allTimers setObject:timerInfo forKey:key];
}

+(void) removeTimerInfo:(NSString *)key
{
    [__allTimers removeObjectForKey:key];
}

#pragma mark -

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


// Create timer.
- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat
{
    NSString * key = [NSString stringWithFormat:@"Noname-%p",self];
    
    if ([self.timers objectForKey:key]) {
        return [self.timers objectForKey:key];
    }
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:repeat];
    
    timer.timerName = key;
    [self.timers setObject:timer forKey:key];
    
    INFO(@"[LCTimer] init in %@, name is %@.",[self class],key);
    
    // Add info to static dic.
    
    NSString * timerInfo = [NSString stringWithFormat:@"  * TimeInterval : %f Target : %@ Repeat : %d",interval,[self class],repeat];
    NSString * infoKey = [NSString stringWithFormat:@"Static-%p-%@",self,key];
    
    [[self class] setTimerInfo:timerInfo key:infoKey];
    
    return timer;
}


// Create timer.
- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat name:(NSString *)name
{
    if ([self.timers objectForKey:name]) {
        return [self.timers objectForKey:name];
    }
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:repeat];
    timer.timerName = name;
    [self.timers setObject:timer forKey:name];
    
    INFO(@"[LCTimer] init in %@, name is %@.",[self class],name);
    
    // Add info to static dic.
    
    NSString * timerInfo = [NSString stringWithFormat:@"  * TimeInterval : %f Target : %@ Repeat : %d",interval,[self class],repeat];
    NSString * infoKey = [NSString stringWithFormat:@"Static-%p-%@",self,name];
    
    [[self class] setTimerInfo:timerInfo key:infoKey];
    
    return timer;
}


// Cancel timer.
- (void)cancelTimer:(NSString *)name
{
    NSTimer * timer = [self.timers objectForKey:name];
    
    if (timer) {
        [timer invalidate];
        [self.timers removeObjectForKey:name];
        
        // Remove info from static dic.
        INFO(@"[LCTimer] remove in %@, name is %@.",[self class],name);
        
        NSString * infoKey = [NSString stringWithFormat:@"Static-%p-%@",self,name];
        
        [[self class] removeTimerInfo:infoKey];
    }
}

// Cancel timers.
- (void)cancelAllTimers
{
    for (NSString * key in self.timers.allKeys) {
        
        NSTimer * timer = [self.timers objectForKey:key];
        [timer invalidate];
        
        [self.timers removeObjectForKey:key];
        
        // Remove info from static dic.
        INFO(@"[LCTimer] remove in %@, name is %@.",[self class],key);

        NSString * infoKey = [NSString stringWithFormat:@"Static-%p-%@",self,key];
        
        [[self class] removeTimerInfo:infoKey];
    }
}

- (void)handleTimer:(NSTimer *)timer
{
    ;
}

@end
