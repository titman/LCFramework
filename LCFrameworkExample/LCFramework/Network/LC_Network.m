//
//  LC_Network.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Network.h"

@interface LC_Network ()
{
    Reachability * reachabilityObject;
}

@end

@implementation LC_Network

-(void) dealloc
{
    [self unobserveNotification:kReachabilityChangedNotification];
    LC_RELEASE(reachabilityObject);
    LC_SUPER_DEALLOC();
}

+ (LC_Network *)sharedInstance
{
    static dispatch_once_t once;
    static LC_Network * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

+(void) load
{
    [LC_Network sharedInstance];
}

-(id) init
{
    LC_SUPER_INIT({
    
        [self observeNotification:kReachabilityChangedNotification];
        
        reachabilityObject = [[Reachability reachabilityWithHostName:LC_NETWORK_REACHABILITY_HOST_NAME] retain];
        [reachabilityObject startNotifier];

        
    });
}

-(void) handleNotification:(NSNotification *)notification
{
    self.currentNetworkStatus = [(Reachability *)notification.object currentReachabilityStatus];
}

-(BOOL) isWiFi
{
    switch (self.currentNetworkStatus)
    {
        case kReachableViaWiFi:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

-(BOOL) isNetwork
{
    switch (self.currentNetworkStatus)
    {
        case kReachableViaWiFi:
            return YES;
            break;
        case kReachableViaWWAN:
            return YES;
        default:
            return NO;
            break;
    }
}

@end