//
//  LC_UIActionSheet.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIActionSheet.h"

@interface LC_UIActionSheet ()

@end

@implementation LC_UIActionSheet

-(void) dealloc
{
    self.actionBlock = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) showInView:(UIView *)view animated:(BOOL)animated
{
    if (animated) {
        [super showInView:view];
    }else{
        [super showFromRect:view.bounds inView:view animated:NO];
    }
}

-(void) dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    
    if (self.actionBlock) {
        self.actionBlock(self,buttonIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
