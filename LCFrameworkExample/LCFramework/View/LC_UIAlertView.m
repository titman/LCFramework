//
//  LC_UIAlertView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
        ;
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
    
    if (otherButtonTitle) {
        [alert addButtonTitle:otherButtonTitle];
    }
    
	[alert show];
    
	return LC_AUTORELEASE(alert);
}

+ (LC_UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    LC_UIAlertView * alert = [[LC_UIAlertView alloc] init];
	[alert setMessage:message];
    [alert setTitle:title];
    [alert addCancelTitle:cancelTitle];

    if (otherButtonTitle) {
        [alert addButtonTitle:otherButtonTitle];
    }
    
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
