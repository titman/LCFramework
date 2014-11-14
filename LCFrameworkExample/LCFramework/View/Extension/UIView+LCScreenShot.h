//
//  UIView+ScreenShot.h
//  LCFramework
//
//  Created by CBSi-Leer on 14-3-31.
//  Copyright (c) 2014年 http://nsobject.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCScreenShot)

@property (nonatomic, readonly) UIImage * screenshot;
@property (nonatomic, readonly) UIImage * screenshotOneLayer;

- (UIImage *)capture;
- (UIImage *)capture:(CGRect)area;


@end
