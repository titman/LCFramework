//
//  LC_UISideMenu.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-14.
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

#import <Foundation/Foundation.h>

@class LC_UISideMenu;
@class LC_UISideMenuItem;

typedef void (^LCUISideItemActionBlock)( LC_UISideMenu * menu, LC_UISideMenuItem * item );


#pragma mark -


@interface LC_UISideMenuItem : NSObject

@property (retain, readwrite, nonatomic) NSString * title;
@property (retain, readwrite, nonatomic) UIImage *  image;
@property (retain, readwrite, nonatomic) UIImage *  highlightedImage;
@property (copy, readwrite, nonatomic) LCUISideItemActionBlock action;

- (id)initWithTitle:(NSString *)title action:(LCUISideItemActionBlock) action;

@end


#pragma mark -


@interface LC_UISideMenu : UIView

@property (retain, nonatomic)  NSArray * items;
@property (assign, nonatomic) CGFloat  verticalOffset;
@property (assign, nonatomic) CGFloat  horizontalOffset;
@property (assign, nonatomic) CGFloat  itemHeight;
@property (retain, nonatomic) UIFont  * font;
@property (retain, nonatomic) UIColor * textColor;
@property (retain, nonatomic) UIColor * highlightedTextColor;
@property (assign, readwrite, nonatomic) BOOL isShowing;

- (id)initWithItems:(NSArray *)items;

- (void)show;
- (void)hide;
//- (void)setRootViewController:(UIViewController *)viewController;

@end
