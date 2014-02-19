//
//  UIViewController+TabBar.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (TabBar)

-(void) setTabBarItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

-(UIViewController *) hiddenBottomBarWhenPushed:(BOOL)yesOrNo;

@end
