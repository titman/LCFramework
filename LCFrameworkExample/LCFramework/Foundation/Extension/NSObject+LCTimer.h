//
//  NSObject+LCTimer.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface NSTimer (LCTimer)

@property (nonatomic,retain) NSString * timerName;

-(BOOL) is:(NSString *)timerName;

@end

@interface NSObject (LCTimer)

@property (nonatomic,retain) NSMutableDictionary * timers;

- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat;

- (NSTimer *)timer:(NSTimeInterval)interval repeat:(BOOL)repeat name:(NSString *)name;

- (void)cancelTimer:(NSString *)name;

- (void)cancelAllTimers;

- (void)handleTimer:(NSTimer *)timer;

@end
