//
//  UIImage+extension.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+(UIImage *)imageNamed:(NSString *)name useCache:(BOOL)useCache;

// -3.14 ~ 3.14
-(UIImage *) changeHueValue:(float)value;

-(UIImage *) transprent;

-(UIImage *) rounded;
-(UIImage *) rounded:(CGRect)circleRect;

-(UIImage *) stretched;
-(UIImage *) stretched:(UIEdgeInsets)capInsets;

-(UIImage *) grayscale;

-(UIColor *) patternColor;

-(UIImage *) blurValue:(float)value;

+(UIImage *) screenshotsKeyWindowWithStatusBar:(BOOL)withStatusBar;

+(UIImage *) screenshotWithView:(UIView *)view;

@end
