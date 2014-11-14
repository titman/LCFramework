//
//  LCAlertView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//


typedef void(^LCAlertViewCompletionBlock)(BOOL cancelled, NSInteger buttonIndex);

@interface LCAlertView : UIViewController

@property (nonatomic, copy) LCAlertViewCompletionBlock clickBlock;
@property (nonatomic, getter = isVisible) BOOL visible;

@property (nonatomic,assign) UIWindow *mainWindow;
@property (nonatomic,retain) UIWindow *alertWindow;
@property (nonatomic,assign) UIView *backgroundView;
@property (nonatomic,assign) UIView *alertView;
@property (nonatomic,assign) UILabel *titleLabel;
@property (nonatomic,assign) UIView *contentView;
@property (nonatomic,assign) UILabel *messageLabel;
@property (nonatomic,assign) UIButton *cancelButton;
@property (nonatomic,assign) UIButton *otherButton;
@property (nonatomic,retain) NSArray *buttons;
@property (nonatomic) CGFloat buttonsY;
@property (nonatomic,assign) CALayer *verticalLine;
@property (nonatomic,retain) UITapGestureRecognizer *tap;

+ (instancetype)showAlertWithTitle:(NSString *)title;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(LCAlertViewCompletionBlock)completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        completion:(LCAlertViewCompletionBlock)completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                        completion:(LCAlertViewCompletionBlock)completion;

/**
 * @param otherTitles Must be a NSArray containing type NSString, or set to nil for no otherTitles.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                        completion:(LCAlertViewCompletionBlock)completion;


+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                       contentView:(UIView *)view
                        completion:(LCAlertViewCompletionBlock)completion;
/**
 * @param otherTitles Must be a NSArray containing type NSString, or set to nil for no otherTitles.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(LCAlertViewCompletionBlock)completion;

/**
 * Adds a button to the receiver with the given title.
 * @param title The title of the new button
 * @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;

/**
 * Dismisses the receiver, optionally with animation.
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

/**
 * By default the alert allows you to tap anywhere around the alert to dismiss it.
 * This method enables or disables this feature.
 */
- (void)setTapToDismissEnabled:(BOOL)enabled;

@end

