//
//  LC_UIButton.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"

@interface LC_UIButton : UIButton

@property (nonatomic, assign) NSString *			title;
@property (nonatomic, assign) UIColor *				titleColor;
@property (nonatomic, assign) UIFont *				titleFont;
@property (nonatomic, assign) UIImage *             buttonImage;
@property (nonatomic, assign) BOOL					enableAllEvents;

@property (nonatomic, retain) NSString * signalName;

@end
