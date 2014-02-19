//
//  LC_FileManager.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_FileManager.h"

@implementation LC_FileManager

+(LC_FileManager *) sharedInstance
{
    static dispatch_once_t once;
    static LC_FileManager * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

+ (BOOL) removeItemAtPath:(NSString *)path error:(NSError **)error
{
    return [[LC_FileManager sharedInstance] removeItemAtPath:path error:error];
}

+(BOOL) fileExistsAtPath:(NSString *)path
{
    return [[LC_FileManager sharedInstance] fileExistsAtPath:path];
}

+ (BOOL)touch:(NSString *)path
{
	if ( NO == [LC_FileManager fileExistsAtPath:path] )
	{
		return [[NSFileManager defaultManager] createDirectoryAtPath:path
										 withIntermediateDirectories:YES
														  attributes:nil
															   error:NULL];
	}
	
	return YES;
}

+ (BOOL) setSkipBackupAttribute:(NSString *)path
{
    NSString * strVersion = [[UIDevice currentDevice] systemVersion];
    float fVersion = 0.0;
    
    if (strVersion.length > 0) {
        fVersion = [strVersion floatValue];
    }
    
    BOOL result = NO;
    
    NSURL * url = [NSURL fileURLWithPath:path];
    
    if (fVersion >= 5.1f) {
        result = [self addSkipBackupAttributeToItemAtURL_iOS5_1:url];
    }
    
    if ((fVersion > 5.0f) && (fVersion < 5.1f)) {
        result = [self addSkipBackupAttributeToItemAtURL:url];
    }
    
    return result;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL_iOS5_1:(NSURL *)URL
{
    BOOL success = NO;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        NSError *error = nil;
        success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                 forKey:NSURLIsExcludedFromBackupKey error:&error];
        
        if (!success) {
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
    }
    
    return success;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    int result = NO;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        const char *filePath = [[URL path] fileSystemRepresentation];
        
        const char  *attrName = "com.apple.MobileBackup";
        u_int8_t    attrValue = 1;
        
        result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    }
    
    return result;
}

+ (float) fileSizeWithPath:(NSString *)path
{
    NSDictionary * fileAttributes = [[LC_FileManager sharedInstance] attributesOfItemAtPath:path error:nil];
    
    unsigned long long length = [fileAttributes fileSize];
    
    return length/1024.0;
}

@end
