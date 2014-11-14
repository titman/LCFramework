//
//  UINavigationController+Extension.m
//  WuxianchangPro
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-11-13.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "UINavigationController+LCExtension.h"

@implementation UINavigationController (LCExtension)

-(id) rootViewController
{
    if (!self.viewControllers || self.viewControllers.count <= 0) {
        return nil;
    }
    
    return self.viewControllers[0];
}

@end
