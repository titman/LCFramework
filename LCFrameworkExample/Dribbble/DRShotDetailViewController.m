//
//  DRShotDetailViewController.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-23.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRShotDetailViewController.h"

@implementation DRShotDetailViewController

-(void) dealloc
{
    [_shot release];
    LC_SUPER_DEALLOC();
}

@end
