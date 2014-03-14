//
//  LC_UITableBarController.h
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UITabBarController : UITabBarController

@property (nonatomic, retain) LC_UITabBar * bar;
@property (nonatomic, assign) int lastSelectIndex;
@property (nonatomic, retain) NSArray * cantChangeViewControllerIndexs;

-(void) hideBar:(BOOL)yesOrNo animation:(BOOL)animation;

-(CGRect) tabBarControllerSetItemFrame:(LC_UITabBarItem *)item;

-(void) handleTabBarItemClick:(LC_UITabBarItem *)item;

@end
