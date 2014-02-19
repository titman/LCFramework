//
//  NSNumber+LCExtension.m
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-12-18.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "NSNumber+LCExtension.h"

@implementation NSNumber (LCExtension)

-(int) length
{
    NSString * tempString = LC_NSSTRING_FORMAT(@"%@",self);
    return tempString.length;
}

@end
