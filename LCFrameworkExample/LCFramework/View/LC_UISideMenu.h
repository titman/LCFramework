//
//  LC_UISideMenu.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-14.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

@class LC_UISideMenu;
@class LC_UISideMenuItem;

typedef void (^LCUISideItemActionBlock)( LC_UISideMenu * menu, LC_UISideMenuItem * item );


#pragma mark -


@interface LC_UISideMenuItem : NSObject

@property (retain, readwrite, nonatomic) NSString * title;
@property (retain, readwrite, nonatomic) UIImage *  image;
@property (retain, readwrite, nonatomic) UIImage *  highlightedImage;
@property (copy, readwrite, nonatomic) LCUISideItemActionBlock action;

- (id)initWithTitle:(NSString *)title action:(LCUISideItemActionBlock) action;

@end


#pragma mark -


@interface LC_UISideMenu : UIView

@property (retain, nonatomic)  NSArray * items;
@property (assign, nonatomic) CGFloat  verticalOffset;
@property (assign, nonatomic) CGFloat  horizontalOffset;
@property (assign, nonatomic) CGFloat  itemHeight;
@property (retain, nonatomic) UIFont  * font;
@property (retain, nonatomic) UIColor * textColor;
@property (retain, nonatomic) UIColor * highlightedTextColor;
@property (assign, readwrite, nonatomic) BOOL isShowing;

- (id)initWithItems:(NSArray *)items;

- (void)show;
- (void)hide;
//- (void)setRootViewController:(UIViewController *)viewController;

@end
