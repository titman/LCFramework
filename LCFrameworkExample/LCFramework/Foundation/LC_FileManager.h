//
//  LC_FileManager.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_FileManager : NSFileManager

+ (BOOL) removeItemAtPath:(NSString *)path error:(NSError **)error;

+ (BOOL) copyItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;

+ (BOOL) moveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;

+ (BOOL) fileExistsAtPath:(NSString *)path;

+ (BOOL) touch:(NSString *)path;

+ (BOOL) setSkipBackupAttribute:(NSString *)path;

// kb
+ (float) fileSizeWithPath:(NSString *)path;

@end
