//
//  UIPullLoader.m
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

#import "LC_UIPullLoader.h"

#pragma mark -

#undef	ANIMATION_DURATION
#define ANIMATION_DURATION	(0.3f)

#pragma mark -

@interface LC_UIPullLoader() <MSPullToRefreshDelegate>

@property (nonatomic,retain) MSPullToRefreshController * ptrc;

@end

#pragma mark -

@implementation LC_UIPullLoader

-(void) dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    self.beginRefreshBlock = nil;
    [_ptrc release];
    [_scrollView release];
    [super dealloc];
}

+ (id) pullLoaderWithScrollView:(UIScrollView *)scrollView
                      pullStyle:(LC_PULL_STYLE)pullStyle
                backGroundStyle:(LC_PULL_BACK_GROUND_STYLE)backGroundStyle
{
    LC_UIPullLoader * pull = [[LC_UIPullLoader alloc] initWithScrollView:scrollView pullStyle:pullStyle backGroundStyle:backGroundStyle];
    return LC_AUTORELEASE(pull);
}

- (id) initWithScrollView:(UIScrollView *)scrollView pullStyle:(LC_PULL_STYLE)pullStyle backGroundStyle:(LC_PULL_BACK_GROUND_STYLE)backGroundStyle
{
    LC_SUPER_INIT({
        
        self.ptrc = LC_AUTORELEASE([[MSPullToRefreshController alloc] initWithScrollView:scrollView delegate:self]);
        
        self.scrollView = scrollView;
        [_scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];

        _pullStyle       = pullStyle;
        _backGroundStyle = backGroundStyle;
        
        self.showActivityIndicator = YES;
        
        [self drawWithStyle:backGroundStyle];
    
    });
}

- (void) drawWithStyle:(LC_PULL_BACK_GROUND_STYLE)style
{
    
    switch (style) {
            
        case LC_PULL_BACK_GROUND_STYLE_COLORFUL:
        {            
            NSMutableArray * animationImages = [NSMutableArray arrayWithCapacity:19];
            
            for (int i=1; i< 20; i++)
                [animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"MS_loading-%d.png",i]]];
            
            _rainbowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_loading-1.png"]];
            _rainbowTop.frame = CGRectMake(0, -_scrollView.frame.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
            _rainbowTop.animationImages = animationImages;
            _rainbowTop.animationDuration = 2;
            [_scrollView addSubview:_rainbowTop];
            LC_RELEASE(_rainbowTop);
            
            _rainbowBot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_loading-1.png"]];
            _rainbowBot.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            _rainbowBot.frame = CGRectMake(0, _scrollView.frame.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
            _rainbowBot.animationImages = animationImages;
            _rainbowBot.animationDuration = 2;
            [_scrollView addSubview:_rainbowBot];
            LC_RELEASE(_rainbowBot);

        }
            break;
        case LC_PULL_BACK_GROUND_STYLE_CUSTOM:
        {
            _rainbowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_loading-1.png"]];
            _rainbowTop.frame = CGRectMake(0, -_scrollView.frame.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
            [_scrollView addSubview:_rainbowTop];
            LC_RELEASE(_rainbowTop);
            
            _rainbowBot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_loading-1.png"]];
            _rainbowBot.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            _rainbowBot.frame = CGRectMake(0, _scrollView.frame.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
            [_scrollView addSubview:_rainbowBot];
            LC_RELEASE(_rainbowBot);
        }
            break;
        default:
        {
            [self drawWithStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL];
            return;
        }
            break;
    }
    
    _arrowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_big_arrow.png"]];
    _arrowTop.frame = CGRectMake(floorf((_rainbowTop.frame.size.width-_arrowTop.frame.size.width)/2), _rainbowTop.frame.size.height - _arrowTop.frame.size.height - 10 , _arrowTop.frame.size.width, _arrowTop.frame.size.height);
    [_rainbowTop addSubview:_arrowTop];
    LC_RELEASE(_arrowTop);
    
    _arrowBot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MS_big_arrow.png"]];
    _arrowBot.frame = CGRectMake(floorf((_rainbowBot.frame.size.width-_arrowBot.frame.size.width)/2), 10 , _arrowBot.frame.size.width, _arrowBot.frame.size.height);
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    [_rainbowBot addSubview:_arrowBot];
    LC_RELEASE(_arrowBot);
    
    _loadingTop = [LC_UIActivityIndicatorView whiteActivityIndicatorView];
    _loadingTop.center = _arrowTop.center;
    [_rainbowTop addSubview:_loadingTop];
    
    _loadingBot = [LC_UIActivityIndicatorView whiteActivityIndicatorView];
    _loadingBot.center = _arrowBot.center;
    [_rainbowBot addSubview:_loadingBot];
    
    switch (self.pullStyle) {
            
        case LC_PULL_STYLE_HEADER:
            LC_REMOVE_FROM_SUPERVIEW(_loadingBot, YES);
            LC_REMOVE_FROM_SUPERVIEW(_arrowBot, YES);
            LC_REMOVE_FROM_SUPERVIEW(_rainbowBot, YES);
            break;
        case LC_PULL_STYLE_FOOTER:
            LC_REMOVE_FROM_SUPERVIEW(_loadingTop, YES);
            LC_REMOVE_FROM_SUPERVIEW(_arrowTop, YES);
            LC_REMOVE_FROM_SUPERVIEW(_rainbowTop, YES);
            break;
        case LC_PULL_STYLE_HEADER_AND_FOOTER:
            break;
        case LC_PULL_STYLE_NULL:
            break;
    }
}

- (void) startRefresh
{
    [_ptrc startRefreshingDirection:MSRefreshDirectionTop];
}

- (void) endRefresh
{
    [_ptrc finishRefreshingDirection:MSRefreshDirectionTop animated:YES];
    [_ptrc finishRefreshingDirection:MSRefreshDirectionBottom animated:YES];
    [_rainbowTop stopAnimating];
    [_rainbowBot stopAnimating];
    _arrowBot.hidden = NO;
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    _arrowTop.hidden = NO;
    _arrowTop.transform = CGAffineTransformIdentity;
    _loadingTop.hidden = YES;
    [_loadingTop stopAnimating];
    _loadingBot.hidden = YES;
    [_loadingBot stopAnimating];
}

#pragma mark - MSPullToRefreshDelegate Methods

- (BOOL) pullToRefreshController:(MSPullToRefreshController *)controller canRefreshInDirection:(MSRefreshDirection)direction {
    
    switch (self.pullStyle) {
            
        case LC_PULL_STYLE_HEADER:
            return direction == MSRefreshDirectionTop;
        case LC_PULL_STYLE_FOOTER:
            return direction == MSRefreshDirectionBottom;
        case LC_PULL_STYLE_HEADER_AND_FOOTER:
            return direction == MSRefreshDirectionTop || direction == MSRefreshDirectionBottom;
        case LC_PULL_STYLE_NULL:
            return 0;            
    }
    
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return LC_UIPULLLOADER_DEFAULT_HEIGHT;
}

- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshableInsetForDirection:(MSRefreshDirection)direction
{
    return LC_UIPULLLOADER_DEFAULT_HEIGHT;
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller canEngageRefreshDirection:(MSRefreshDirection)direction
{    
    LC_FAST_ANIMATIONS(ANIMATION_DURATION, ^{
    
        _arrowTop.transform = CGAffineTransformMakeRotation(M_PI);
        _arrowBot.transform = CGAffineTransformIdentity;
    
    });
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction
{
    LC_FAST_ANIMATIONS(ANIMATION_DURATION, ^{
    
        _arrowTop.transform = CGAffineTransformIdentity;
        _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    
    });
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction
{

    _arrowTop.hidden = YES;
    _arrowBot.hidden = YES;
    [_rainbowTop startAnimating];
    [_rainbowBot startAnimating];
    
    if (self.showActivityIndicator) {
        _loadingTop.hidden = NO;
        [_loadingTop startAnimating];
        _loadingBot.hidden = NO;
        [_loadingBot startAnimating];
    }
    
    switch (direction) {
        case MSRefreshDirectionBottom:
            self.beginRefreshBlock(self,LC_PULL_DIRETION_BUTTOM);
            break;
        case MSRefreshDirectionTop:
            self.beginRefreshBlock(self,LC_PULL_DIRETION_TOP);
            break;
        default:
            break;
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    CGFloat contentSizeArea = _scrollView.contentSize.width*_scrollView.contentSize.height;
    CGFloat frameArea = _scrollView.frame.size.width*_scrollView.frame.size.height;
    CGSize adjustedContentSize = contentSizeArea < frameArea ? _scrollView.frame.size : _scrollView.contentSize;
        
    _rainbowBot.frame = CGRectMake(0, adjustedContentSize.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
}


@end
