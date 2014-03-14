//
//  LC_UIActionSheet.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@class LC_UIActionSheet;

typedef void(^LCUIActionSheetActionBlock) (LC_UIActionSheet * actionSheet, int clickIndex);

@interface LC_UIActionSheet : UIActionSheet

@property(nonatomic,copy) LCUIActionSheetActionBlock actionBlock;

-(void) showInView:(UIView *)view animated:(BOOL)animated;

@end
