//
//  LC_UIAlertView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UIAlertView;

typedef void (^LCAlertViewButtonClickBlock)( LC_UIAlertView * alertView, NSInteger clickIndex);


@interface LC_UIAlertView : UIAlertView

@property (nonatomic, retain) NSObject *			      userData;
@property (nonatomic, copy)   LCAlertViewButtonClickBlock clickBlock;

+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title;
+ (LC_UIAlertView *)showMessage:(NSString *)message cancelTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle;
+ (LC_UIAlertView *)showMessage:(NSString *)message title:(NSString *)title cancelTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherButtonTitle;

- (void)dismissAnimated:(BOOL)animated;

- (void)addCancelTitle:(NSString *)title;
- (void)addButtonTitle:(NSString *)title;


@end
