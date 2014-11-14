//
//  LC_UISignal.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UISignal.h"

#pragma mark -

@implementation NSObject (LCUISignalResponder)

- (BOOL)isUISignalResponder
{
	return NO;
}

- (NSObject *)signalTarget
{
	return nil;
}

@end

#pragma mark -

@implementation UIViewController (LCUISignalResponder)

- (BOOL)isUISignalResponder
{
	return YES;
}

- (NSObject *)signalTarget
{
	return self;
}

@end

#pragma mark -

@implementation UIView (LCUISignalResponder)

- (BOOL)isUISignalResponder
{
	return YES;
}

- (NSObject *)signalTarget
{
	return self;
}

@end

#pragma mark -

@implementation LC_UISignal

+(LC_UISignal *)signal
{
    return [[[LC_UISignal alloc] init] autorelease];
}

-(BOOL) send
{
    return [LC_UISignalCenter send:self];
}

-(BOOL) forward:(id)object
{
    return [LC_UISignalCenter forward:object signal:self];
}

-(void) dealloc
{
    [_name release];
    [_object release];
    
    [super dealloc];
}

@end
