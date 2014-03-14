//
//  NSObject+Hud.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+Hud.h"

@implementation NSObject (Hud)

- (LC_UIHud *)showMessageHud:(NSString *)message
{
	UIView * container = nil;
	
	if ( [self isKindOfClass:[UIView class]] )
	{
		container = (UIView *)self;
	}
	else if ( [self isKindOfClass:[UIViewController class]] )
	{
		container = ((UIViewController *)self).view;
	}
    else
    {
        container = LC_KEYWINDOW;
    }
    
	return [[LC_UIHudCenter sharedInstance] showMessageHud:message inView:container];
}

- (LC_UIHud *)showSuccessHud:(NSString *)message
{
    UIView * container = nil;
	
	if ( [self isKindOfClass:[UIView class]] )
	{
		container = (UIView *)self;
	}
	else if ( [self isKindOfClass:[UIViewController class]] )
	{
		container = ((UIViewController *)self).view;
	}
    else
    {
        container = LC_KEYWINDOW;
    }
    
	return [[LC_UIHudCenter sharedInstance] showSuccessHud:message inView:container];
}

- (LC_UIHud *)showFailureHud:(NSString *)message
{
    UIView * container = nil;
	
	if ( [self isKindOfClass:[UIView class]] )
	{
		container = (UIView *)self;
	}
	else if ( [self isKindOfClass:[UIViewController class]] )
	{
		container = ((UIViewController *)self).view;
	}
    else
    {
        container = LC_KEYWINDOW;
    }
    
	return [[LC_UIHudCenter sharedInstance] showFailureHud:message inView:container];
}

- (LC_UIHud *)showLoadingHud:(NSString *)message
{
    UIView * container = nil;
	
	if ( [self isKindOfClass:[UIView class]] )
	{
		container = (UIView *)self;
	}
	else if ( [self isKindOfClass:[UIViewController class]] )
	{
		container = ((UIViewController *)self).view;
	}
    else
    {
        container = LC_KEYWINDOW;
    }
    
	return [[LC_UIHudCenter sharedInstance] showLoadingHud:message inView:container];
}

- (LC_UIHud *)showProgressHud:(NSString *)message
{
    UIView * container = nil;
	
	if ( [self isKindOfClass:[UIView class]] )
	{
		container = (UIView *)self;
	}
	else if ( [self isKindOfClass:[UIViewController class]] )
	{
		container = ((UIViewController *)self).view;
	}
    else
    {
        container = LC_KEYWINDOW;
    }
    
	return [[LC_UIHudCenter sharedInstance] showProgressHud:message inView:container];
}

@end
