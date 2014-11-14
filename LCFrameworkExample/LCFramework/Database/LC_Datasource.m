//
//  LC_Datasource.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Datasource.h"

@implementation LC_Datasource

+(NSString *) currentDatasourceInfo
{
    NSDictionary * datasource = [LC_Datasource LCInstance].memoryDatasources;
    
    if (!datasource) {
        return @"No datasource cache, or no use LC_Datasource.";
    }
    
    NSMutableString * info = [NSMutableString stringWithFormat:@"  * count : %d\n",datasource.allKeys.count];
    
    for (NSString * key in datasource.allKeys) {
        
        NSString * oneInfo = datasource[key];
        
        [info appendFormat:@"  * %@ - %@\n",key,[oneInfo class]];
    }
    
    return info;
}

-(void) dealloc
{
    LC_RELEASE(_memoryDatasources);
    LC_SUPER_DEALLOC();
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
    
    INFO(@"[LC_Datasource] Data seated in %@, name is %@.",[target class],key);
    
    [self.memoryDatasources setObject:object forKey:LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
}

-(id) datasourceWithTarget:(id)target key:(NSString *)key
{
    //INFO(@"Datasource read in %@, name is %@.",[target class],key);

    return self.memoryDatasources[LC_NSSTRING_FORMAT(@"%@-%p",key,target)];
}

-(void) removeDatasourceWithTarget:(id)target key:(NSString *)key
{
    if (!key) {
        return;
    }
    
    INFO(@"[LC_Datasource] Data remove in %@, name is %@.",[target class],key);
    
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
