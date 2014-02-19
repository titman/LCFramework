//
//  NSObject+LCDadasource.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

#define LC_DS(key) [self datasourceWithKey:key]
#define LC_RDS(key) [self removeDatasourceWithKey:key]

@interface NSObject (LCDadasource)

-(void) setDatasource:(id<NSCopying>)datasource key:(NSString *)key;

-(id) datasourceWithKey:(NSString *)key;

-(void) removeDatasourceWithKey:(NSString *)key;

@end
