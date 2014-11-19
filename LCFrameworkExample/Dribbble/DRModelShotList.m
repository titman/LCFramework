//
//  DRModelShotList.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRModelShotList.h"
#import "DRInterfaceShotList.h"

#define PER_PAGE	(30)

@implementation DRModelShotList

-(void) goToPage:(NSInteger)page
{
    LC_HTTPInterface * interface = [LC_HTTPInterface interface];
    
    interface.url = [LC_API LCInstance].url.APPEND(@"popular");
    
    interface.parameters.APPEND(@"per_page",@(PER_PAGE));
    interface.parameters.APPEND(@"page",@(page));
    
    interface.REQUEST();
}

@end
