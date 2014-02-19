//
//  LC_UITopNotificationView.h
//  LCFrameworkDemo
//
//  Created by 郭历成 ( titm@tom.com ) on 13-10-21.
//  Copyright (c) 2013年 LS Developer ( http://www.likesay.com ). All rights reserved.
//

#define LCUITopNotificationViewHeight 44.0f
#define LCUITopNotificationViewImageViewSidelength 40.0f
#define LCUITopNotificationViewDefaultShowDuration 2.0

typedef enum _LCTopNotificationViewType {
    
    LCTopNotificationViewTypeNone = 0,
    LCTopNotificationViewTypeSuccess,
    LCTopNotificationViewTypeError,
    
} LCTopNotificationViewType;

@interface LC_UITopNotificationView : UIView

@property (nonatomic, assign) LC_UILabel * label;
@property (nonatomic, assign) LC_UIImageView * imageView;
@property (nonatomic, assign) float duration;

+ (void)showInView:(UIView *)view
             style:(LCTopNotificationViewType)style
           message:(NSString *)message;

+ (void)showInView:(UIView *)view
         tintColor:(UIColor*)tintColor
             image:(UIImage*)image
           message:(NSString*)message
          duration:(NSTimeInterval)duration;

- (void) show;

@end
