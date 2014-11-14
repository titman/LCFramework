//
//  LC_UINavigationNotificationView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UINavigationGradientView;
@class LC_UIImageView;

LC_NOTIFICATION_SET(LCUINavigationNofiticationTapReceivedNotification,@"LCUINavigationNofiticationTapReceivedNotification");

//typedef void (^LC_UINavigationNotificationAction)(id);

@interface LC_UINavigationNotificationView : UIView

@property (nonatomic, assign) UILabel *textLabel;
@property (nonatomic, assign) UILabel *detailTextLabel;
@property (nonatomic, assign) LC_UIImageView *imageView;
@property (nonatomic, assign) LC_UINavigationGradientView * contentView;

@property (nonatomic) NSTimeInterval duration;

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                       detail:(NSString*)detail
                                        image:(UIImage*)image
                                  andDuration:(NSTimeInterval)duration;

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                       detail:(NSString*)detail
                                  andDuration:(NSTimeInterval)duration;

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                    andDetail:(NSString*)detail;

//+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
//                                       detail:(NSString*)detail
//                                        image:(UIImage*)image
//                                     duration:(NSTimeInterval)duration
//                                andTouchBlock:(LC_UINavigationNotificationAction)block;
//
//+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
//                                       detail:(NSString*)detail
//                                     duration:(NSTimeInterval)duration
//                                andTouchBlock:(LC_UINavigationNotificationAction)block;
//
//+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
//                                       detail:(NSString*)detail
//                                andTouchBlock:(LC_UINavigationNotificationAction)block;

@end