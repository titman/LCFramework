//
//  LC_UINavigationController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UINavigationController : UINavigationController

//** 打开后将可以滑动返回, Defalt is NO. */
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) BOOL isMoving;

-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor;

-(void) setBarBackgroundImage:(UIImage *)image;

@end
