//
//  UIViewController+LCSafePush.m
//  NextApp
//
//  Created by Licheng Guo . http://nsobject.me/  on 14-8-19.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import "UIViewController+LCSafePush.h"

@implementation UIViewController (LCSafePush)

+ (void)load
{
//    Method m1;
//    Method m2;
//    
//    m1 = class_getInstanceMethod(self, @selector(sofaViewDidAppear:));
//    m2 = class_getInstanceMethod(self, @selector(viewDidAppear:));
//    method_exchangeImplementations(m1, m2);
}


- (void)sofaViewDidAppear:(BOOL)animated
{
    if ([self.navigationController isKindOfClass:[LC_UINavigationController class]]) {
        
        ((LC_UINavigationController *)self.navigationController).transitionInProgress = NO;
    }
    
    [self sofaViewDidAppear:animated];
}


@end
