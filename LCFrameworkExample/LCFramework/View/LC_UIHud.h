//
//  LC_HudCenter.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@interface LC_UIHud : MBProgressHUD

/*
 
    Thanks for MBProgressHUD.
 
 */

@end

@interface LC_UIHudCenter : NSObject

+(LC_UIHudCenter *) sharedInstance;

+ (void)setDefaultMessageIcon:(UIImage *)image;
+ (void)setDefaultSuccessIcon:(UIImage *)image;
+ (void)setDefaultFailureIcon:(UIImage *)image;
+ (void)setDefaultBubble:(UIImage *)image;

- (LC_UIHud *)showMessageHud:(NSString *)message inView:(UIView *)view;
- (LC_UIHud *)showSuccessHud:(NSString *)message inView:(UIView *)view;
- (LC_UIHud *)showFailureHud:(NSString *)message inView:(UIView *)view;
- (LC_UIHud *)showLoadingHud:(NSString *)message inView:(UIView *)view;
- (LC_UIHud *)showProgressHud:(NSString *)message inView:(UIView *)view;

@end
