//
//  LC_UITapMaskView.m
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-11-1.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "LC_UITapMaskView.h"

@implementation LC_UITapMaskView

-(void) dealloc
{
    self.willHideBlock = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.alpha = 0;
        self.backgroundColor = LC_COLOR_W_RGB(0, 0, 0, 0.5);
        [self addTapTarget:self selector:@selector(tapAction)];
    }
    return self;
}

-(void) show
{
    LC_FAST_ANIMATIONS(0.25, ^{
    
        self.alpha = 1;
    
    });
}

-(void) hide
{
    LC_FAST_ANIMATIONS(0.25, ^{
        
        self.alpha = 0;
        
    });
}

-(void) tapAction
{
    if (self.willHideBlock) {
        self.willHideBlock(self);
    }
    
    [self hide];
}

@end
