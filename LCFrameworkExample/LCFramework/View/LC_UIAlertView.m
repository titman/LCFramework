//
//  LC_UIAlertView.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIAlertView.h"

@interface LC_UIAlertView ()

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
        
    });
}


+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title
{
    return [LC_UIAlertView showAlertWithTitle:nil message:message cancelTitle:title completion:nil];
}

+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle
{
    return [LC_UIAlertView showAlertWithTitle:nil message:message cancelTitle:title otherTitle:otherButtonTitle completion:nil];
}

+ (LC_UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    return [LC_UIAlertView showAlertWithTitle:title message:message cancelTitle:cancelTitle otherTitle:otherButtonTitle completion:nil];
}

@end
