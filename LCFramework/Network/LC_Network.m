//
//  LC_Network.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
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
    self.currentNetworkStatus = [reachabilityObject currentReachabilityStatus];

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