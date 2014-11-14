//
//  UIViewController+TabBar.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCTabBar)

-(void) setTabBarItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

-(UIViewController *) hiddenBottomBarWhenPushed:(BOOL)yesOrNo;

@end
