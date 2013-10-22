//
//  LC_UIApplicationSkeleton.m
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
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

#import "LC_UIApplicationSkeleton.h"

LC_NOTIFICATION_DF(LC_UIApplicationDidRegisterRemoteNotification,@"LC_UIApplicationDidRegisterRemoteNotification");
LC_NOTIFICATION_DF(LC_UIApplicationDidRegisterRemoteFailNotification,@"LC_UIApplicationDidRegisterRemoteFailNotification");

LC_NOTIFICATION_DF(LC_UIApplicationDidReceiveRemoteNotification, @"LC_UIApplicationDidReceiveRemoteNotification");
LC_NOTIFICATION_DF(LC_UIApplicationDidReceiveLocalNotification, @"LC_UIApplicationDidReceiveLocalNotification");


static LC_UIApplicationSkeleton * __skeleton = nil;

@implementation LC_UIApplicationSkeleton

+ (LC_UIApplicationSkeleton *)sharedInstance
{
	return __skeleton;
}

- (void)dealloc
{
	[_window release];
	_window = nil;
	
    [super dealloc];
}

- (void) load
{
    ;
}

#pragma mark -

- (void)initializeWindow
{
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
	[self.window makeKeyAndVisible];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	NSLog( @"applicationDidFinishLaunching" );
	
	[self application:application didFinishLaunchingWithOptions:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	__skeleton = self;
    
	[self initializeWindow];
	[self load];
	
	if ( self.window.rootViewController )
	{
		UIView * rootView = self.window.rootViewController.view;
        
		if ( rootView )
		{
			[self.window makeKeyAndVisible];
		}
	}
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}

#pragma mark -

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	NSLog( @"applicationDidBecomeActive" );
    
	[self.window.rootViewController viewWillAppear:NO];
	[self.window.rootViewController viewDidAppear:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	NSLog( @"applicationWillResignActive" );
    
	[self.window.rootViewController viewWillDisappear:NO];
	[self.window.rootViewController viewDidDisappear:NO];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	NSLog( @"applicationDidReceiveMemoryWarning" );
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	NSLog( @"applicationWillTerminate" );
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSLog( @"applicationDidEnterBackground" );
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	NSLog( @"applicationWillEnterForeground" );
}

#pragma mark -

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
	
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
	
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
	
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
	
}

#pragma mark -


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	NSString * token = [deviceToken description];
	token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self postNotification:LC_UIApplicationDidRegisterRemoteNotification withObject:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self postNotification:LC_UIApplicationDidRegisterRemoteFailNotification withObject:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	UIApplicationState state = [UIApplication sharedApplication].applicationState;
	if ( UIApplicationStateInactive == state || UIApplicationStateBackground == state )
	{
		NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userInfo, @"userInfo", [NSNumber numberWithBool:NO], @"inApp", nil];
        [self postNotification:LC_UIApplicationDidReceiveRemoteNotification withObject:dict];
	}
	else
	{
		NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:userInfo, @"userInfo", [NSNumber numberWithBool:YES], @"inApp", nil];
        [self postNotification:LC_UIApplicationDidReceiveRemoteNotification withObject:dict];
	}
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
	UIApplicationState state = [UIApplication sharedApplication].applicationState;
	if ( UIApplicationStateInactive == state || UIApplicationStateBackground == state )
	{
		NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:notification.userInfo, @"userInfo", [NSNumber numberWithBool:NO], @"inApp", nil];
        [self postNotification:LC_UIApplicationDidReceiveLocalNotification withObject:dict];
	}
	else
	{
		NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:notification.userInfo, @"userInfo", [NSNumber numberWithBool:YES], @"inApp", nil];
        [self postNotification:LC_UIApplicationDidReceiveLocalNotification withObject:dict];
	}
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
}



@end
