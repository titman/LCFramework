//
//  NSObject+LCInstance.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCInstance.h"

static NSMutableDictionary * instenceDatasource = nil;

@implementation NSObject (LCInstance)

+ (instancetype) LCInstance
{
    NSMutableDictionary * datasource = [[self class] shareInstenceDatasource];
    
    NSString * selfClass = [[self class] description];
    
    id __singleton__ = datasource[selfClass];
    
    if (datasource[selfClass]) {
        return __singleton__;
    }
    
    __singleton__ = [[self alloc] init];
    
    [[self class] setObjectToInstenceDatasource:__singleton__];
    [__singleton__ release];
    
    INFO(@"[LCInstance] %@ instance init.",[__singleton__ class]);
    
    return __singleton__;
}

+(NSMutableDictionary *) shareInstenceDatasource
{
    @synchronized(self){
    
        if (!instenceDatasource) {
            instenceDatasource = [[NSMutableDictionary alloc] init];
        }

    }
    
    return instenceDatasource;
}

+(BOOL) setObjectToInstenceDatasource:(id)object
{
    NSString * objectClass = [[object class] description];

    if (!object) {
        ERROR(@"[LCInstance] init fail.");
        return NO;
    }
    
    if (!objectClass) {
        ERROR(@"[LCInstance] class error.");
        return NO;
    }
    
    [[[self class] shareInstenceDatasource] setObject:object forKey:objectClass];
    
    return YES;
}

+(NSString *) currentInstenceInfo
{
    NSDictionary * datasource = [NSObject shareInstenceDatasource];
    
    if (!datasource) {
        return @"[LCInstance] No instence , or no use NSObject+LCInstance.";
    }
    
    NSMutableString * info = [NSMutableString stringWithFormat:@"  * count : %d\n",datasource.allKeys.count];
    
    for (NSString * key in datasource.allKeys) {
        
        NSString * oneInfo = datasource[key];
        
        [info appendFormat:@"  * %@\n",[oneInfo class]];
    }
    
    return info;
}

@end
