//
//  LC_Datasource.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
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
    return [self.memoryDatasources objectForKey:LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
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
