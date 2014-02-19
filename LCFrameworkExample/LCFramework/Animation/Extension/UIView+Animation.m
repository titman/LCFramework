//
//  UIView+Animation.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

-(void) runAnimationsQueue:(LC_UIAnimationQueue *)queue
{
    [queue runAnimationsInView:self];
}

@end
