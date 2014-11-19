//
//  NSObject+LCOrder.h
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-16.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import <Foundation/Foundation.h>

static NSMutableDictionary * ___ORDER_CENTER = nil;

@interface NSObject (LCOrder)

-(void) addOrder:(NSString *)order;

@end
