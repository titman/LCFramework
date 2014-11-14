//
// UIScrollView+SVPullToRefresh.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

@class SVPullToRefreshArrow;
@class SVPullToRefreshView;

@interface UIScrollView (SVPullToRefresh)

typedef NS_ENUM(NSUInteger, SVPullToRefreshPosition) {
    SVPullToRefreshPositionTop = 0,
    SVPullToRefreshPositionBottom,
};

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler;
- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler position:(SVPullToRefreshPosition)position;
- (void) triggerPullToRefresh;

@property (nonatomic, assign, readonly) SVPullToRefreshView * pullToRefreshView;
@property (nonatomic, assign) BOOL showsPullToRefresh;

@end


typedef NS_ENUM(NSUInteger, SVPullToRefreshState) {
    SVPullToRefreshStateStopped = 0,
    SVPullToRefreshStateTriggered,
    SVPullToRefreshStateLoading,
    SVPullToRefreshStateAll = 10
};

@interface SVPullToRefreshView : UIView

@property (nonatomic, assign) SVPullToRefreshArrow * arrow;
@property (nonatomic, retain) UIColor *arrowColor;
@property (nonatomic, retain, readwrite) UIColor *activityIndicatorViewColor NS_AVAILABLE_IOS(5_0);
@property (nonatomic, readwrite) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property (nonatomic, readonly) SVPullToRefreshState state;
@property (nonatomic, readonly) SVPullToRefreshPosition position;

- (void)setCustomView:(UIView *)view forState:(SVPullToRefreshState)state;

- (void)startAnimating;
- (void)stopAnimating;

// deprecated; use setSubtitle:forState: instead
@property (nonatomic, assign, readonly) UILabel *dateLabel;
@property (nonatomic, retain) NSDate *lastUpdatedDate;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

// deprecated; use [self.scrollView triggerPullToRefresh] instead
- (void)triggerRefresh;

@end

@interface SVPullToRefreshArrow : UIView

@property (nonatomic, retain) UIColor * arrowColor;

@end
