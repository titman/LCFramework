//
//  LC_UIActivityIndicatorView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UIActivityIndicatorView : UIActivityIndicatorView

@property (nonatomic, assign) BOOL	animating;

+(LC_UIActivityIndicatorView *) whiteActivityIndicatorView;
+(LC_UIActivityIndicatorView *) grayActivityIndicatorView;

@end
