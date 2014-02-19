//
//  UIPullLoader.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

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
