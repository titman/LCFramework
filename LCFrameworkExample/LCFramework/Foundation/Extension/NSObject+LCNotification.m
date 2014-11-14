//
//  NSObject+LCNotification.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCNotification.h"

#pragma mark -

@implementation NSNotification(LCNotification)

- (BOOL)is:(NSString *)name
{
	return [self.name isEqualToString:name];
}

- (BOOL)isKindOf:(NSString *)prefix
{
    
	return [self.name hasPrefix:prefix];
}

@end

#pragma mark -

@implementation NSObject (LCNotification)

- (void)handleNotification:(NSNotification *)notification
{
    
}

- (void)observeNotification:(NSString *)notificationName
{
    INFO(@"[LCNotification] observe : %@ receiver : %@",notificationName,[self class]);
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotification:)
												 name:notificationName
											   object:nil];
}

- (void)unobserveNotification:(NSString *)name
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:name
												  object:nil];
}

- (void)observeNotification:(NSString *)notificationName object:(id)object
{
    INFO(@"[LCNotification] observe : %@ receiver : %@",notificationName,[self class]);
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotification:)
												 name:notificationName
											   object:object];
}

- (void)unobserveAllNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)postNotification:(NSString *)name
{
    INFO(@"[LCNotification] post : %@ sponsor : %@",name,[self class]);

	[[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
	return YES;
}

+ (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object
{
    INFO(@"[LCNotification] post : %@ sponsor : %@",name,[self class]);
    
	[[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
	return YES;
}

- (BOOL) postNotification:(NSString *)name
{
	return [[self class] postNotification:name withObject:self];
}

- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object
{
	return [[self class] postNotification:name withObject:object];
}

@end
