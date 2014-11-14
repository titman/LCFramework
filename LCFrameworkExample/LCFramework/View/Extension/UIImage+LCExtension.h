//
//  UIImage+extension.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>


@interface UIImage (LCExtension)

#define LC_USE_SYSTEM_IMAGE_CACHE NO

/* If LC_USE_SYSTEM_IMAGE_CACHE is YES and userCache is YES, it will call imageNamed: method.
   If not, will cache image to LC_ImageCache. */
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


+(UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size;

-(UIImage *) scaleToWidth:(float)width;

-(UIImage *) scaleToHeight:(float)height;

-(UIImage *) scaleToWidth:(float)width height:(float)height;

-(UIImage *) rotateImageLength:(float)length imageOrientation:(UIImageOrientation)orient;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

-(UIImage *) imageFromRect:(CGRect)newRect;

@end
