//
//  UIPullLoader.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
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

#import "MSPullToRefreshController.h"
#import "LC_UIActivityIndicatorView.h"

typedef enum _LC_PULL_DIRETION {

    LC_PULL_DIRETION_TOP    = MSRefreshDirectionTop,
    LC_PULL_DIRETION_BUTTOM = MSRefreshDirectionBottom

} LC_PULL_DIRETION;

typedef enum _LC_PULL_BACK_GROUND_STYLE {
    
    LC_PULL_BACK_GROUND_STYLE_CUSTOM   = 0, //当为自定义时可以手动设置背景以及箭头图片
    LC_PULL_BACK_GROUND_STYLE_COLORFUL = 1
    
} LC_PULL_BACK_GROUND_STYLE;

typedef enum _LC_PULL_STYLE {
    
    LC_PULL_STYLE_HEADER             = 0, 
    LC_PULL_STYLE_FOOTER             = 1,
    LC_PULL_STYLE_HEADER_AND_FOOTER  = 2,
    LC_PULL_STYLE_NULL               = 3,
    
} LC_PULL_STYLE;

@class LC_UIPullLoader;

typedef void (^LCUIPulldidRefreshBlock)( LC_UIPullLoader * pull , LC_PULL_DIRETION diretion);

@interface LC_UIPullLoader : NSObject

@property (nonatomic,copy) LCUIPulldidRefreshBlock beginRefreshBlock;

@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,assign) UIImageView *  rainbowTop;
@property (nonatomic,assign) UIImageView *  arrowTop;
@property (nonatomic,assign) UIImageView *  rainbowBot;
@property (nonatomic,assign) UIImageView *  arrowBot;
@property (nonatomic,assign) LC_UIActivityIndicatorView *  loadingTop;
@property (nonatomic,assign) LC_UIActivityIndicatorView *  loadingBot;

@property (nonatomic,assign) BOOL showActivityIndicator;

@property (readonly) LC_PULL_STYLE             pullStyle;
@property (readonly) LC_PULL_BACK_GROUND_STYLE backGroundStyle;

+ (id) pullLoaderWithScrollView:(UIScrollView *)scrollView
                      pullStyle:(LC_PULL_STYLE)pullStyle
                backGroundStyle:(LC_PULL_BACK_GROUND_STYLE)backGroundStyle;

- (id) initWithScrollView:(UIScrollView *)scrollView
                pullStyle:(LC_PULL_STYLE)pullStyle
          backGroundStyle:(LC_PULL_BACK_GROUND_STYLE)backGroundStyle;

- (void) startRefresh;
- (void) endRefresh;

@end
