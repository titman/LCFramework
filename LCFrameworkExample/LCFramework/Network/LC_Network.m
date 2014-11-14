//
//  LC_Network.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
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

+(void) load
{
    [LC_Network LCInstance];
}

-(id) init
{
    LC_SUPER_INIT({
    
        self.currentNetworkStatus = kReachableViaWWAN;
        
        [self observeNotification:kReachabilityChangedNotification];
        
        reachabilityObject = [[Reachability reachabilityWithHostName:LC_NETWORK_REACHABILITY_HOST_NAME] retain];
        [reachabilityObject startNotifier];

    });
}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:kReachabilityChangedNotification]) {
        
        self.currentNetworkStatus = [(Reachability *)notification.object currentReachabilityStatus];
        
        INFO(@"[LC_Network] State changed : %d",self.currentNetworkStatus);
    }
}

-(BOOL) isWiFi
{
    switch (self.currentNetworkStatus) {
        case NotReachable:
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            return YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
    }
    
    return NO;
}

-(BOOL) isNetwork
{
    switch (self.currentNetworkStatus) {
            
        case NotReachable:
            // 没有网络连接
            return NO;
            break;
        case ReachableViaWWAN:
            return YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
    }
    
    return NO;
}

-(BOOL) realTimeNetwrok
{
    self.currentNetworkStatus = [reachabilityObject currentReachabilityStatus];

    switch (self.currentNetworkStatus) {
            
        case NotReachable:
            // 没有网络连接
            return NO;
            break;
        case ReachableViaWWAN:
            return YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
        default:
            return NO;
    }
    
    return NO;
}

@end