//
//  LC_UIAnimation.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

#import "UIView+Animation.h"




typedef enum
{
    //** default */
    LC_ANIMATION_TYPE_NONE   =0,
    /** 位置移动量 */
    LC_ANIMATION_TYPE_DISPLACEMENT_BY,
    /** 位置移动 */
    LC_ANIMATION_TYPE_DISPLACEMENT_TO,
    LC_ANIMATION_TYPE_FADE_BY,
    LC_ANIMATION_TYPE_FADE_TO,
    LC_ANIMATION_TYPE_SCALE_BY,
    LC_ANIMATION_TYPE_SCALE_TO,
    LC_ANIMATION_TYPE_ROTATE_BY,
    LC_ANIMATION_TYPE_ROTATE_TO,
    /** 回调Block */
    LC_ANIMATION_TYPE_CALL_BACK
    
}LC_ANIMATION_TYPE;


#pragma mark -


@interface LC_UIAnimation : NSObject

@property(nonatomic,assign) LC_ANIMATION_TYPE animationType;
@property(nonatomic,assign) CGFloat animationDuration;

@end


#pragma mark -


/** 透明度变化的动画 */
@interface LC_UIAnimationFade : LC_UIAnimation

@property (nonatomic,assign) CGFloat alpha;

+(LC_UIAnimationFade *)animationToAlpha:(CGFloat)alpha duration:(CGFloat)duration;

/** alpha是变化量，可以是正负值 */
+(LC_UIAnimationFade *)animationByAlpha:(CGFloat)alpha duration:(CGFloat)duration;

@end


#pragma mark -


/** 位置移动 */
@interface LC_UIAnimationDisplace : LC_UIAnimation

@property (nonatomic,assign) CGPoint point;

+(LC_UIAnimationDisplace *)animationToPoint:(CGPoint)point duration:(CGFloat)duration;
+(LC_UIAnimationDisplace *)animationByPoint:(CGPoint)point duration:(CGFloat)duration;

@end


#pragma mark -


/** 缩放动画 */
@interface LC_UIAnimationScale : LC_UIAnimation

@property (nonatomic,assign) CGFloat scaleX;
@property (nonatomic,assign) CGFloat scaleY;

+(LC_UIAnimationScale *)animationToScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY duration:(CGFloat)duration;
+(LC_UIAnimationScale *)animationByScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY duration:(CGFloat)duration;

@end


#pragma mark -


/** 旋转动画 */
@interface LC_UIAnimationRotate : LC_UIAnimation

/** 角度值,不是M_PI,不是弧度 */
@property (nonatomic,assign) CGFloat angle;


+(LC_UIAnimationRotate *)animationToRotate:(CGFloat)angle duration:(CGFloat)duration;
+(LC_UIAnimationRotate *)animationByRotate:(CGFloat)angle duration:(CGFloat)duration;

@end


#pragma mark -


typedef void(^LC_UIANIMATION_BLOCK)(id ani);

/** 动画队列，添加动作到队列中，然后view执行队列动画 */
@interface LC_UIAnimationQueue :NSObject

@property (nonatomic,copy) LC_UIANIMATION_BLOCK completionblock;

-(void) addAnimation:(LC_UIAnimation *)animation;
-(void) runAnimationsInView:(UIView *)view;

@end


#pragma mark -


