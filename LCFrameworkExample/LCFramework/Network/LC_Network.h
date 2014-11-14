//
//  LC_Network.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "Reachability.h"
#import "LC_HTTPRequest.h"
#import "LC_HTTPRequestQueue.h"


#import "NSObject+LCHTTPRequest.h"


#define LC_NETWORK_REACHABILITY_HOST_NAME @"www.baidu.com"


@interface LC_Network : NSObject

@property(nonatomic,assign) NetworkStatus currentNetworkStatus;

-(BOOL) isWiFi;
-(BOOL) isNetwork;
-(BOOL) realTimeNetwrok;

@end
