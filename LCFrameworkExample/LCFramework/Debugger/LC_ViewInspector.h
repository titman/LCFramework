//
//  LC_ViewInspector.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_ViewInspector : UIView

- (void)prepareShow:(UIView *)inView;
- (void)prepareHide;

- (void)show;
- (void)hide;

@end
