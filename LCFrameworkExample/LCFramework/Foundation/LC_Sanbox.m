//
//  LC_Sanbox.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Sanbox.h"

static int autoCleanTmpPath = NO;

@implementation LC_Sanbox

+(void) autoCleanTmpPath:(BOOL)yesOrNo
{
    autoCleanTmpPath = yesOrNo;
    
    if (autoCleanTmpPath) {
        //
    }
}

-(id) init
{
    LC_SUPER_INIT({
        
        [self observeNotification:UIApplicationDidFinishLaunchingNotification];
        
    })
}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UIApplicationDidFinishLaunchingNotification]) {
        
        
    }
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();

}

@end
