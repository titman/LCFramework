//
//  LC_UINavigationNotificationView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
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

#import <UIKit/UIKit.h>

@class LC_UINavigationGradientView;
@class LC_UIImageView;

LC_NOTIFICATION_AS(LCUINavigationNofiticationTapReceivedNotification);

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