//
//  LC_UIAlertView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LCAlertView;

@interface LC_UIAlertView : LCAlertView

@property (nonatomic, retain) NSObject * userData;

+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title;
+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle;
+ (LC_UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherButtonTitle;

@end
