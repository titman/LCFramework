//
//  LC_UIAlertView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
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

#import "LC_UIAlertView.h"

@interface LC_UIAlertView () <UIAlertViewDelegate>

@end

@implementation LC_UIAlertView

-(void) dealloc
{
    self.clickBlock = nil;
    
    LC_RELEASE(_userData);
    LC_SUPER_DEALLOC();
}

- (id) init
{
    LC_SUPER_INIT({
    
        self.delegate = self;
		self.title = nil;
    
    });
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title
{
    LC_UIAlertView * alert = [[LC_UIAlertView alloc] init];
	[alert setMessage:message];
	[alert addCancelTitle:title];
	[alert show];
    
	return LC_AUTORELEASE(alert);
}

+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle
{
    LC_UIAlertView * alert = [[LC_UIAlertView alloc] init];
	[alert setMessage:message];
	[alert addCancelTitle:title];
    [alert addButtonTitle:otherButtonTitle];
	[alert show];
    
	return LC_AUTORELEASE(alert);
}

+ (LC_UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    LC_UIAlertView * alert = [[LC_UIAlertView alloc] init];
	[alert setMessage:message];
    [alert setTitle:title];
	[alert addCancelTitle:cancelTitle];
    [alert addButtonTitle:otherButtonTitle];
	[alert show];
    
	return LC_AUTORELEASE(alert);
}

- (void)dismissAnimated:(BOOL)animated
{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:animated];
}

- (void)addCancelTitle:(NSString *)title
{
    self.cancelButtonIndex = [self addButtonWithTitle:title];
}

- (void)addButtonTitle:(NSString *)title
{
    [self addButtonWithTitle:title];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(LC_UIAlertView *)alertView
{
	return YES;
}

- (void)alertView:(LC_UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.clickBlock) {
        _clickBlock(alertView,buttonIndex);
    }
}

@end
