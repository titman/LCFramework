//
//  LC_UITopNotificationView.m
//  LCFrameworkDemo
//
//  Created by 郭历成 ( titm@tom.com ) on 13-10-21.
//  Copyright (c) 2013年 LS Developer ( http://www.likesay.com ). All rights reserved.
//

#import "LC_UITopNotificationView.h"

@interface LC_UITopNotificationView ()
{
    LCTopNotificationViewType style;
}

@property(nonatomic,retain) UIView * parentView;

@end

@implementation LC_UITopNotificationView

+ (void)showInView:(UIView *)view style:(LCTopNotificationViewType)style message:(NSString *)message
{
    LC_UITopNotificationView * notificationView = [[LC_UITopNotificationView alloc] initWithParentView:view type:style];
    notificationView.label.text = message;
    
    if (style == LCTopNotificationViewTypeError) {
        
        notificationView.imageView.image = [UIImage imageNamed:@"LC_UITopNotificationView_exclamationMarkIcon.png" useCache:YES];
        notificationView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        
    }else if (style == LCTopNotificationViewTypeSuccess){
        
        notificationView.imageView.image = [UIImage imageNamed:@"LC_UITopNotificationView_checkmarkIcon.png" useCache:YES];
        notificationView.backgroundColor = [UIColor colorWithRed:0.21 green:0.72 blue:0.00 alpha:0.9];
    }else if (style == LCTopNotificationViewTypeNone){
        notificationView.imageView.image = nil;
        notificationView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.6 alpha:0.3];
    }
    
    [notificationView show];
    LC_AUTORELEASE(notificationView);
}

+ (void)showInView:(UIView *)view
         tintColor:(UIColor*)tintColor
             image:(UIImage*)image
           message:(NSString*)message
          duration:(NSTimeInterval)duration
{
    LC_UITopNotificationView * notificationView = [[LC_UITopNotificationView alloc] initWithParentView:view type:LCTopNotificationViewTypeNone];
    notificationView.label.text = message;
    notificationView.imageView.image = image;
    notificationView.duration = duration;
    notificationView.backgroundColor = tintColor;
    
    [notificationView show];
    LC_AUTORELEASE(notificationView);
}

-(void) dealloc
{
    if (self.parentView && [self.parentView isKindOfClass:[UIScrollView class]]) {
        [self.parentView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    self.parentView = nil;
    
    LC_SUPER_DEALLOC();
}

-(void) removeFromSuperview
{
    if (self.parentView && [self.parentView isKindOfClass:[UIScrollView class]]) {
        [self.parentView removeObserver:self forKeyPath:@"contentOffset"];
        self.parentView = nil;
    }
    
    [super removeFromSuperview];
}

- (id)initWithParentView:(UIView *)view type:(LCTopNotificationViewType)type
{
    self = [super initWithFrame:[self getFrameFromView:view]];
    if (self) {

        style = type;
        self.parentView = view;
        self.duration = 2;
        
        self.backgroundColor = [UIColor colorWithRed:0.21 green:0.72 blue:0.00 alpha:1.0];
        
        [self initSelf];
    }
    return self;
}

- (CGRect) getFrameFromView:(UIView *)view
{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView * scrollView = (UIScrollView *)view;
        return CGRectMake(0, scrollView.contentOffset.y + scrollView.contentInset.top, view.viewFrameWidth, LCUITopNotificationViewHeight);
    }
    
    return CGRectMake(0, 0, view.viewFrameWidth, LCUITopNotificationViewHeight);
}

-(void) initSelf
{
    //[self createBlurLayer];
    
    
    self.imageView = LC_AUTORELEASE([[LC_UIImageView alloc] init]);
    self.imageView.opaque = NO;
    [self addSubview:_imageView];
    
    self.label = LC_AUTORELEASE([[LC_UILabel alloc] init]);
    self.label.font = [UIFont systemFontOfSize:17.0f];
    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.numberOfLines = 2;
    self.label.textAlignment = UITextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    
    
    [self addSubview:self.label];
    
    if ([self.parentView isKindOfClass:[UIScrollView class]]) {
        [self.parentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
}

-(void) layout
{
    if (self.imageView.image) {
        
        float distanceSide = (LCUITopNotificationViewHeight - LCUITopNotificationViewImageViewSidelength)/2;
        self.imageView.frame = LC_RECT_CREATE(distanceSide, distanceSide, LCUITopNotificationViewImageViewSidelength, LCUITopNotificationViewImageViewSidelength);

        float labelX = distanceSide * 2 + LCUITopNotificationViewImageViewSidelength;
        self.label.frame = LC_RECT_CREATE(labelX, distanceSide, self.parentView.viewFrameWidth - labelX - distanceSide - LCUITopNotificationViewImageViewSidelength, LCUITopNotificationViewHeight - distanceSide * 2);

        
    }else{
        
        float distanceSide = (LCUITopNotificationViewHeight - 4);
        self.label.frame = CGRectMake(2, 2, self.parentView.viewFrameWidth - 4, distanceSide);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([object isEqual:self.parentView]) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            self.frame = [self getFrameFromView:self.parentView];
        }
    }
}

-(void) createBlurLayer
{
    UIToolbar * toolbar = LC_AUTORELEASE([[UIToolbar alloc] initWithFrame:[self bounds]]);
    toolbar.alpha = 0.8;
    [self insertSubview:toolbar atIndex:0];
}

-(void) show
{
    if (!self.parentView) {
        self.parentView = LC_KEYWINDOW;
    }

    [self layout];
    self.alpha = 0;
    [self.parentView addSubview:self];
    
    
    LC_FAST_ANIMATIONS_F(0.25, ^{
    
        self.alpha = 1;
    
    }, ^(BOOL finished){
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         
            LC_FAST_ANIMATIONS_F(0.25, ^{
            
                self.alpha = 0;
            
            }, ^(BOOL finished){
            
                [self removeFromSuperview];
            
            });
            
        });
    
    });
}

@end
