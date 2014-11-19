//
//  LC_Order.h
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-16.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC_Order : NSObject

+(BOOL) addOrder:(NSString *)order toObject:(id)object;
+(BOOL) removeOrder:(NSString *)order fromObject:(id)object;
+(BOOL) impOrder:(NSString *)order toObject:(id)object;

@end
