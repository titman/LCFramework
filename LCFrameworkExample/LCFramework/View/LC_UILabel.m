//
//  LC_UILabel.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UILabel.h"

@interface LC_UILabel ()

@property (nonatomic, assign) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation LC_UILabel

-(id) initWithCopyingEnabled:(BOOL)copyingEnabled
{
    self = [super initWithFrame:CGRectZero];
	if ( self )
	{
        self.copyingEnabled = copyingEnabled;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

-(id) initWithFrame:(CGRect)frame copyingEnabled:(BOOL)copyingEnabled
{
    self = [super initWithFrame:frame];
	if ( self )
	{
        self.copyingEnabled = copyingEnabled;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

- (id)init
{
	self = [super initWithFrame:CGRectZero];
	if ( self )
	{
        self.copyingEnabled = NO;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if ( self )
	{
        self.copyingEnabled = NO;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

-(void) defaultConfig
{
    self.font = [UIFont systemFontOfSize:12.0f];
    self.textAlignment = UITextAlignmentLeft;
    self.textColor = [UIColor darkGrayColor];
    self.backgroundColor = [UIColor clearColor];
    self.lineBreakMode = UILineBreakModeTailTruncation;
    self.userInteractionEnabled = YES;
}

-(void) initCopyGecognizer
{
    if (self.copyingEnabled) {
        if (self.longPressGestureRecognizer) {
            self.longPressGestureRecognizer.enabled = YES;
            return;
        }else{
            self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
            [self addGestureRecognizer:_longPressGestureRecognizer];
            LC_RELEASE(_longPressGestureRecognizer);
            
            _copyMenuArrowDirection = UIMenuControllerArrowDefault;
        }
    }else{
        if (self.longPressGestureRecognizer) {
            self.longPressGestureRecognizer.enabled = NO;
        }
    }
}

-(void) setCopyingEnabled:(BOOL)copyingEnabled
{
    _copyingEnabled = copyingEnabled;
    [self initCopyGecognizer];
}

-(void) longPressGestureRecognized:(UILongPressGestureRecognizer *)rg
{
    if (rg == self.longPressGestureRecognizer)
    {
        if (rg.state == UIGestureRecognizerStateBegan)
        {
            if(![self becomeFirstResponder]){
                NSLog(@" ! UIMenuController will not work with %@ since it cannot become first responder", self);
            }

            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = self.copyMenuArrowDirection;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.copyingEnabled)
        {
            retValue = YES;
        }
	}
    else
    {
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.copyingEnabled)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.text];
    }
}


@end
