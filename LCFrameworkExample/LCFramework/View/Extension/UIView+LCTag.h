//
//  UIView+Tag.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

typedef id (^LCUIViewAppendTagStringBlock) ( NSString * tagString );
typedef id (^LCUIViewWithTagBlock) ( NSInteger tag );
typedef id (^LCUIViewWithTagStringBlock) ( NSString * tagString );

@interface UIView (LCTag)

@property (nonatomic, readonly) LCUIViewAppendTagStringBlock APPEND_TAG;
@property (nonatomic, readonly) LCUIViewWithTagBlock         FIND;
@property (nonatomic, readonly) LCUIViewWithTagStringBlock   FIND_S;

@property (nonatomic, retain) NSString * tagString;

- (UIView *)viewWithTagString:(NSString *)value;

@end
