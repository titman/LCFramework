//
//  LC_UILabel.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
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
    self.textAlignment = UITextAlignmentCenter;
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
