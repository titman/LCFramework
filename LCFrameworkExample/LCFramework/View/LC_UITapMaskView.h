//
//  LC_UITapMaskView.h
//  WuxianchangPro
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-11-1.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "LC_UIView.h"

@interface LC_UITapMaskView : UIView

typedef void (^LCUITapMaskViewWillHideBlock)( LC_UITapMaskView * tapMask );

@property(nonatomic,copy) LCUITapMaskViewWillHideBlock willHideBlock;

-(void) show;
-(void) hide;
-(void) hide:(BOOL)animated;
@end
