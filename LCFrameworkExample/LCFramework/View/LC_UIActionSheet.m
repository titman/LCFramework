//
//  LC_UIActionSheet.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIActionSheet.h"
#import "IBActionSheet.h"

@interface LC_UIActionSheet () <IBActionSheetDelegate>

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
    self.delegate = self;
    
    [super showInView:LC_KEYWINDOW];
}

-(void) showInView:(UIView *)theView
{
    self.delegate = self;
    
    [super showInView:LC_KEYWINDOW];
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == self.buttons.count - 1) {
        return;
    }
    
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
