//
//  UIPullLoader.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIPullLoader.h"

#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

#pragma mark -

#undef	ANIMATION_DURATION
#define ANIMATION_DURATION	(0.3f)

#pragma mark -

@interface LC_UIPullLoader()

@property(nonatomic,assign) LC_PULL_STYLE pullStyle;

@end

#pragma mark -

@implementation LC_UIPullLoader


-(void) dealloc
{
    self.beginRefreshBlock = nil;

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
        
        self.scrollView = scrollView;
        [self performSelector:@selector(initSelf:) withObject:[NSNumber numberWithInteger:pullStyle] afterDelay:0];

    });
}

- (id) initWithWeakScrollView:(UIScrollView *)scrollView pullStyle:(LC_PULL_STYLE)pullStyle backGroundStyle:(LC_PULL_BACK_GROUND_STYLE)backGroundStyle
{
    LC_SUPER_INIT({
        
        self.scrollView = scrollView;
        [self performSelector:@selector(initSelf:) withObject:[NSNumber numberWithInteger:pullStyle] afterDelay:0];
        
    });
}

-(void) initSelf:(NSNumber *)pullStyle
{
    self.pullStyle = [pullStyle integerValue];
    
    LC_BLOCK_SELF;
    
    switch (self.pullStyle) {
            
        case LC_PULL_STYLE_HEADER:
        {
            // setup pull-to-refresh
            [self.scrollView addPullToRefreshWithActionHandler:^{
                
                [nRetainSelf handRefresh:LC_PULL_DIRETION_TOP];
            }];
        }
            break;
            
        case LC_PULL_STYLE_FOOTER:
        {
            // setup infinite scrolling
            [self.scrollView addInfiniteScrollingWithActionHandler:^{

                [nRetainSelf handRefresh:LC_PULL_DIRETION_BUTTOM];
                
            }];
        }
            break;
            
        case LC_PULL_STYLE_HEADER_AND_FOOTER:
        {
            
            // setup pull-to-refresh
            [self.scrollView addPullToRefreshWithActionHandler:^{
                
                [nRetainSelf handRefresh:LC_PULL_DIRETION_TOP];
            }];
            
            // setup infinite scrolling
            [self.scrollView addInfiniteScrollingWithActionHandler:^{
                
                [nRetainSelf handRefresh:LC_PULL_DIRETION_BUTTOM];
                
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)handRefresh:(LC_PULL_DIRETION)diretion
{
    if (self.beginRefreshBlock) {
        self.beginRefreshBlock(self,diretion);
    }
}

- (void) startRefresh
{
    if (self.scrollView.pullToRefreshView) {
        
        [self.scrollView triggerPullToRefresh];
    }
}

- (void) endRefresh
{
    [self endRefreshWithAnimated:YES];
}

- (void) endRefreshWithAnimated:(BOOL)animated
{
    if (self.scrollView.pullToRefreshView.state == SVPullToRefreshStateLoading) {
        [self.scrollView.pullToRefreshView stopAnimating];
    }
    
    if (self.scrollView.infiniteScrollingView.state == SVPullToRefreshStateLoading) {
        [self.scrollView.infiniteScrollingView stopAnimating];
    }
    
}

-(void) setCanLoadMore:(BOOL)canLoadMore
{
    _canLoadMore = canLoadMore;
    
    self.scrollView.infiniteScrollingView.enabled = _canLoadMore;
}


@end
