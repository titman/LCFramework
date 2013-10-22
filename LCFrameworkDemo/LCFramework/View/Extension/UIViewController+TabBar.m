//
//  UIViewController+TabBar.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIViewController+TabBar.h"

@implementation UIViewController (TabBar)

-(void) setTabBarItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    // UITabBarItem只是一个载体,用来传递默认图与高亮图,以用来在LC_UITabBarController中取出
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
