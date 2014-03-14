//
//  LC_Datasource.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Datasource.h"

@implementation LC_Datasource

-(void) dealloc
{
    LC_RELEASE(_memoryDatasources);
    LC_SUPER_DEALLOC();
}

+ (LC_Datasource *)sharedInstance
{
    static dispatch_once_t once;
    static LC_Datasource * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

-(id) init
{
    LC_SUPER_INIT({
    
        self.memoryDatasources = [NSMutableDictionary dictionary];
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
		[self observeNotification:UIApplicationDidReceiveMemoryWarningNotification];
#endif
    });
}

-(void)setDatasourceWithOjbect:(id<NSCopying>)object target:(id)target key:(NSString *)key
{
    if (!object) {
        return;
    }
    
    if (!key) {
        return;
    }
    
    [self.memoryDatasources setObject:object forKey:LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
}

-(id) datasourceWithTarget:(id)target key:(NSString *)key
{
    return self.memoryDatasources[LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
}

-(void) removeDatasourceWithTarget:(id)target key:(NSString *)key
{
    if (!key) {
        return;
    }
    
    [self.memoryDatasources removeObjectForKey:LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
}

- (void)handleNotification:(NSNotification *)notification
{
	if ( [notification is:UIApplicationDidReceiveMemoryWarningNotification] )
	{
        ;
	}
}

@end
