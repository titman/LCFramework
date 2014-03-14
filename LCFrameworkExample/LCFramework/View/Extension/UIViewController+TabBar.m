//
//  UIViewController+TabBar.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIViewController+TabBar.h"

@implementation UIViewController (TabBar)

-(void) setTabBarItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    // UITabBarItem只是一个载体,用来传递默认图与高亮图,然后在LC_UITabBarController中取出
    UITabBarItem * item = [[UITabBarItem alloc]  initWithTitle:@"" image:image tag:0];//initWithTitle:nil image:image selectedImage:highlightedImage];
    item.imageData = [NSArray arrayWithObjects:image,highlightedImage, nil];
    self.tabBarItem = item;
    LC_RELEASE(item);

}

-(UIViewController *) hiddenBottomBarWhenPushed:(BOOL)yesOrNo
{
    self.hidesBottomBarWhenPushed = yesOrNo;
    return self;
}

@end
