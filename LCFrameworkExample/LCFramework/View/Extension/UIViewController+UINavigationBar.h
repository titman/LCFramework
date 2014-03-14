//
//  UIViewController+UINavigationBar.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"
//#import "LC_UIView.h"

typedef enum _NavigationBarButtonType {
    
    NavigationBarButtonTypeLeft  = 0,
    NavigationBarButtonTypeRight = 1
    
} NavigationBarButtonType;

@interface UIViewController (UINavigationBar)

+ (id)viewController;

// 在ViewController中直接实现该方法
- (void)navigationBarButtonClick:(NavigationBarButtonType)type;

- (void)showNavigationBarAnimated:(BOOL)animated;
- (void)hideNavigationBarAnimated:(BOOL)animated;

- (void)showBackBarButtonWithImage:(UIImage *)image selectImage:(UIImage *)selectImage;

- (void)showBarButton:(NavigationBarButtonType)position custom:(UIView *)view;
- (void)showBarButton:(NavigationBarButtonType)position image:(UIImage *)image selectImage:(UIImage *)selectImage;
- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage;

- (void)hideBarButton:(NavigationBarButtonType)position;






- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)name textColor:(UIColor *)textColor;

- (void)showBarButton:(NavigationBarButtonType)position system:(UIBarButtonSystemItem)index;

@end
