//
//  UIColor+Extension.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

// 16进制颜色转UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
