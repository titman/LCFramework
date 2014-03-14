//
//  UIViewController+Layout.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-25.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIViewController+Layout.h"

@implementation UIViewController (Layout)

-(void) setEdgesForExtendedLayoutNoneStyle
{
    if (IOS7_OR_LATER) {
        [self performSelector:@selector(setEdgesForExtendedLayout:) withObject:UIRectEdgeNone];
    }
}

@end

