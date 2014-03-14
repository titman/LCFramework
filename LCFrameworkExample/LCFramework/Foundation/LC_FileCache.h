//
//  LC_FileCache.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_FileCache : NSObject

@property (nonatomic, retain) NSString *	cachePath;
@property (nonatomic, retain) NSString *	cacheUser;

+(LC_FileCache *) sharedInstance;

- (NSString *)fileNameForKey:(NSString *)key;

- (id)serialize:(id)obj;
- (id)unserialize:(id)data;

- (BOOL)hasObjectForKey:(id)key;

- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;

- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;

@end
