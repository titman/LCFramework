//
//  LC_UIBlurView.m
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 14-2-19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_UIBlurView.h"

@interface LC_UIBlurView ()

@property(nonatomic,retain) UIToolbar * toolbar;

@end

@implementation LC_UIBlurView

-(void) dealloc
{
    [_toolbar release];
    LC_SUPER_DEALLOC();
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initSelf];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    if (![self toolbar])
    {
        [self setToolbar:LC_AUTORELEASE([[UIToolbar alloc] initWithFrame:[self bounds]])];
        [self.layer addSublayer:[self.toolbar layer]];
    }
}

- (void) setBlurTintColor:(UIColor *)blurTintColor
{
    [self.toolbar setBarTintColor:blurTintColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

@end
