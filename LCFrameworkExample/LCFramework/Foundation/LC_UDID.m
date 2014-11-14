//
//  LC_UDID.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UDID.h"

#define KEY_CHAIN_ADDRESS @"LC_UDID"

@implementation LC_UDID

+ (NSString *) UDID
{
    NSString * udid = [LC_UDID UDIDFromKeyChain];
    
    if (!udid) {
        
        //NSString * sysVersion = [UIDevice currentDevice].systemVersion;
        
        //float version = [sysVersion floatValue];
        
        //if (version >= 6.0) {
          //  udid = [LC_UDID UDIDFromIOS6Later];
        //}
        //else{
            udid = [LC_UDID UDIDFromIOS6Before];
        //}
        
        [LC_UDID setUDIDToKeyChain:udid];
    }
    
    return udid;
}

+(NSString *) UDIDFromIOS6Later
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString *) UDIDFromIOS6Before
{
    return [NSString uuid];
}

+(NSString *) UDIDFromKeyChain
{
    return [LC_Keychain objectForKey:KEY_CHAIN_ADDRESS];
}

+(void) setUDIDToKeyChain:(NSString *)udid
{
    [LC_Keychain setObject:udid forKey:KEY_CHAIN_ADDRESS];
}


@end
