//
//  UINavigationController+Extension.m
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-11-13.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

-(id) rootViewController
{
    if (!self.viewControllers || self.viewControllers.count <= 0) {
        return nil;
    }
    
    return self.viewControllers[0];
}

@end
