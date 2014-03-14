//
//  LC_MemeryCache.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_MemoryCache.h"

#pragma mark -

#undef	DEFAULT_MAX_COUNT
#define DEFAULT_MAX_COUNT	(48)

#pragma mark -

@interface LC_MemoryCache()
@end


@implementation LC_MemoryCache

+ (LC_MemoryCache *)sharedInstance
{
    static dispatch_once_t once;
    static LC_MemoryCache * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		_clearWhenMemoryLow = YES;
		_maxCacheCount = DEFAULT_MAX_COUNT;
		_cachedCount = 0;
		
		_cacheKeys = [[NSMutableArray alloc] init];
		_cacheObjs = [[NSMutableDictionary alloc] init];
        
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
		[self observeNotification:UIApplicationDidReceiveMemoryWarningNotification];
#endif
	}
    
	return self;
}

- (void)dealloc
{
	[self unobserveAllNotifications];
	
	[_cacheObjs removeAllObjects];
    [_cacheObjs release];
	
	[_cacheKeys removeAllObjects];
	[_cacheKeys release];
	
    [super dealloc];
}

- (BOOL)hasObjectForKey:(id)key
{
	return [_cacheObjs objectForKey:key] ? YES : NO;
}

- (id)objectForKey:(id)key
{
	return [_cacheObjs objectForKey:key];
}

- (void)setObject:(id)object forKey:(id)key
{
	if ( nil == key )
		return;
	
	if ( nil == object )
		return;
	
	_cachedCount += 1;
    
	while ( _cachedCount >= _maxCacheCount )
	{
		NSString * tempKey = [_cacheKeys objectAtIndex:0];
        
		[_cacheObjs removeObjectForKey:tempKey];
		[_cacheKeys removeObjectAtIndex:0];
        
		_cachedCount -= 1;
	}
    
	[_cacheKeys addObject:key];
	[_cacheObjs setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
	if ( [_cacheObjs objectForKey:key] )
	{
		[_cacheKeys removeObjectIdenticalTo:key];
		[_cacheObjs removeObjectForKey:key];
        
		_cachedCount -= 1;
	}
}

- (void)removeAllObjects
{
	[_cacheKeys removeAllObjects];
	[_cacheObjs removeAllObjects];
	
	_cachedCount = 0;
}

#pragma mark -

- (void)handleNotification:(NSNotification *)notification
{
	if ( [notification is:UIApplicationDidReceiveMemoryWarningNotification] )
	{
		if ( _clearWhenMemoryLow )
		{
			[self removeAllObjects];
		}
	}
}



@end
