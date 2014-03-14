//
//  LC_Datasource.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_Datasource : NSObject

@property(nonatomic,retain) NSMutableDictionary * memoryDatasources;

+ (LC_Datasource *) sharedInstance;

-(id) datasourceWithTarget:(id)target key:(NSString *)key;
-(void) setDatasourceWithOjbect:(id<NSCopying>)object target:(id)target key:(NSString *)key;
-(void) removeDatasourceWithTarget:(id)target key:(NSString *)key;

@end
