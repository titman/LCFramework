//
//  UIView+Background.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface UIView (LCBackground)

@property (nonatomic, readonly) LC_UIImageView *	backgroundImageView;
@property (nonatomic, retain) UIImage *				backgroundImage;

@end
