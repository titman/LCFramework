//
//  LC_UIApplicationSkeleton.h
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>


LC_NOTIFICATION_SET(LC_UIApplicationDidRegisterRemoteNotification,@"LC_UIApplicationDidRegisterRemoteNotification");
LC_NOTIFICATION_SET(LC_UIApplicationDidRegisterRemoteFailNotification,@"LC_UIApplicationDidRegisterRemoteFailNotification");
LC_NOTIFICATION_SET(LC_UIApplicationDidReceiveRemoteNotification,@"LC_UIApplicationDidReceiveRemoteNotification");
LC_NOTIFICATION_SET(LC_UIApplicationDidReceiveLocalNotification,@"LC_UIApplicationDidReceiveLocalNotification");


@interface LC_UIApplication : UIResponder < UIApplicationDelegate >

@property (nonatomic, retain) UIWindow * window;

+ (LC_UIApplication *) sharedInstance;

- (void) load;


@end
