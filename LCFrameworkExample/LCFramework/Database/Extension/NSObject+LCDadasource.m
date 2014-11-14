//
//  NSObject+LCDadasource.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "NSObject+LCDadasource.h"
#import "LC_Datasource.h"

@implementation NSObject (LCDadasource)

-(void) setDatasource:(id<NSCopying>)datasource key:(NSString *)key
{
    [[LC_Datasource LCInstance] setDatasourceWithOjbect:datasource target:self key:key];
}

-(id) datasourceWithKey:(NSString *)key
{
    return [[LC_Datasource LCInstance] datasourceWithTarget:self key:key];
}

-(void) removeDatasourceWithKey:(NSString *)key
{
    [[LC_Datasource LCInstance] removeDatasourceWithTarget:self key:key];
}

@end
