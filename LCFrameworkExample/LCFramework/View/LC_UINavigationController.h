//
//  LC_UINavigationController.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UINavigationController : UINavigationController

@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor;

-(void) setBarBackgroundImage:(UIImage *)image;

@end
