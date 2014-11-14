//
//  UIApplication+LCPersentViewController.h
//  NextApp
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com )  on 14-4-9.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LCPersentViewController)

-(BOOL) persentViewController:(UIViewController *)viewController animated:(BOOL)animated;

-(BOOL) dismissModalViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
