//
//  NSObject+LCTimer.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "NSObject+LCTimer.h"

#define KEY_TIMERNAME @"NSTimer.name"
#define KEY_TIMES @"NSObject.times"


@implementation NSTimer (LCTimer)

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
	if ( obj && [obj isKindOfClass:[NSMutableDictionary class]] )
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
