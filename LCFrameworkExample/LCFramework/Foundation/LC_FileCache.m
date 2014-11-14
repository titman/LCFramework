//
//  LC_FileCache.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_FileCache.h"

@implementation LC_FileCache


- (id)init
{
	self = [super init];
    
	if ( self )
	{
		self.cacheUser = @"";
		self.cachePath = [NSString stringWithFormat:@"%@/%@/Cache/", [LC_Sanbox libCachePath], [LC_SystemInfo appVersion]];
	}
	return self;
}

- (void)dealloc
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
    
	self.cachePath = nil;
	self.cacheUser = nil;
	
	[super dealloc];
}

- (NSString *)fileNameForKey:(NSString *)key
{
	NSString * pathName = nil;
    
	if ( self.cacheUser && [self.cacheUser length] )
	{
		pathName = [self.cachePath stringByAppendingFormat:@"%@/", self.cacheUser];
	}
	else
	{
		pathName = self.cachePath;
	}
	
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:pathName] )
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:pathName
								  withIntermediateDirectories:YES
												   attributes:nil
														error:NULL];
	}
    
	return [pathName stringByAppendingString:key];
}

- (BOOL)hasObjectForKey:(id)key
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[self fileNameForKey:key]];
}

- (id)objectForKey:(id)key
{
	NSData * data = [NSData dataWithContentsOfFile:[self fileNameForKey:key]];
	if ( data )
	{
		return [self unserialize:data];
	}
	
	return nil;
}

- (void)setObject:(id)object forKey:(id)key
{
	if ( nil == object )
	{
		[self removeObjectForKey:key];
	}
	else
	{
		NSData * data = nil;
		
		if ( [object isKindOfClass:[NSData class]] )
		{
			data = (NSData *)object;
		}
		else
		{
			data = [self serialize:object];
		}
		
		[data writeToFile:[self fileNameForKey:key]
				  options:NSDataWritingAtomic
					error:NULL];
	}
}

- (void)removeObjectForKey:(NSString *)key
{
	[[NSFileManager defaultManager] removeItemAtPath:[self fileNameForKey:key] error:nil];
}

- (void)removeAllObjects
{
	[[NSFileManager defaultManager] removeItemAtPath:_cachePath error:NULL];
	[[NSFileManager defaultManager] createDirectoryAtPath:_cachePath
							  withIntermediateDirectories:YES
											   attributes:nil
													error:NULL];
}

- (NSData *)serialize:(id)obj
{
	if ( [obj isKindOfClass:[NSData class]] )
		return obj;
	
	if ( [obj respondsToSelector:@selector(JSONData)] )
		return [obj JSONData];
	
	return nil;
}

- (id)unserialize:(NSData *)data
{
	return [data objectFromJSONData];
}


@end
