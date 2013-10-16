//
//  LC_UIAnimation.m
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

#import "LC_UIAnimation.h"

@interface LC_UIAnimation ()

@end

@implementation LC_UIAnimation

@end

@implementation LC_UIAnimationFade

+(LC_UIAnimationFade *) animationToAlpha:(CGFloat)alpha duration:(CGFloat)duration
{
    LC_UIAnimationFade * fadeTo = LC_AUTORELEASE([[LC_UIAnimationFade alloc] init]);
    fadeTo.animationType = LC_ANIMATION_TYPE_FADE_TO;
    fadeTo.animationDuration = duration;
    fadeTo.alpha = alpha;
    return fadeTo;
}

+(LC_UIAnimationFade *) animationByAlpha:(CGFloat)alpha duration:(CGFloat)duration
{
    LC_UIAnimationFade * fadeBy = LC_AUTORELEASE([[LC_UIAnimationFade alloc] init]);
    fadeBy.animationType = LC_ANIMATION_TYPE_FADE_BY;
    fadeBy.animationDuration = duration;
    fadeBy.alpha = alpha;
    return fadeBy;
}

@end

@implementation LC_UIAnimationDisplace

+(LC_UIAnimationDisplace*) animationToPoint:(CGPoint)point duration:(CGFloat)duration
{
    LC_UIAnimationDisplace * animation = LC_AUTORELEASE([[LC_UIAnimationDisplace alloc] init]);
    animation.point = point;
    animation.animationType = LC_ANIMATION_TYPE_DISPLACEMENT_TO;
    animation.animationDuration = duration;
    return animation;
}

+(LC_UIAnimationDisplace *) animationByPoint:(CGPoint)point duration:(CGFloat)duration
{
    LC_UIAnimationDisplace * animation = LC_AUTORELEASE([[LC_UIAnimationDisplace alloc] init]);
    animation.animationType = LC_ANIMATION_TYPE_DISPLACEMENT_BY;
    animation.animationDuration = duration;
    animation.point = point;
    return animation;
}

@end

@implementation LC_UIAnimationScale

+(LC_UIAnimationScale *) animationToScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY duration:(CGFloat)duration
{
    LC_UIAnimationScale * animation = LC_AUTORELEASE([[LC_UIAnimationScale alloc] init]);
    animation.animationType = LC_ANIMATION_TYPE_SCALE_TO;
    animation.animationDuration = duration;
    animation.scaleX = scaleX;
    animation.scaleY = scaleY;
    return animation;
}

+(LC_UIAnimationScale *) animationByScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY duration:(CGFloat)duration;
{
    LC_UIAnimationScale * animation = LC_AUTORELEASE([[LC_UIAnimationScale alloc] init]);
    animation.animationType = LC_ANIMATION_TYPE_SCALE_BY;
    animation.animationDuration = duration;
    animation.scaleX = scaleX;
    animation.scaleY = scaleY;
    return animation;
}

@end

@implementation LC_UIAnimationRotate

+(LC_UIAnimationRotate *) animationToRotate:(CGFloat)angle duration:(CGFloat)duration
{
    LC_UIAnimationRotate * animation = LC_AUTORELEASE([[LC_UIAnimationRotate alloc] init]);
    animation.animationType = LC_ANIMATION_TYPE_ROTATE_TO;
    animation.animationDuration = duration;
    animation.angle = angle;
    
    return animation;
}

+(LC_UIAnimationRotate *) animationByRotate:(CGFloat)angle duration:(CGFloat)duration;
{
    LC_UIAnimationRotate * animation = LC_AUTORELEASE([[LC_UIAnimationRotate alloc] init]);
    animation.animationType = LC_ANIMATION_TYPE_ROTATE_BY;
    animation.animationDuration = duration;
    animation.angle = angle;
    
    return animation;
}

@end


@interface LC_UIAnimationQueue()

@property(nonatomic,retain) NSMutableArray * actionList;

@end


@implementation LC_UIAnimationQueue

-(void) dealloc
{
    self.completionblock = nil;
    
    LC_RELEASE_ABSOLUTE(_actionList);
    LC_SUPER_DEALLOC();
}

-(id)init
{
    LC_SUPER_INIT({
    
        self.actionList = [NSMutableArray array];
    
    });
}

-(LC_UIAnimation *) getFirstAnimation
{
    if([_actionList count])
        return [_actionList objectAtIndex:0];
    else
        return nil;
}

-(void) removeFirstAnimation
{
    if([_actionList count])
        [_actionList removeObjectAtIndex:0];
}

-(void) addAnimation:(LC_UIAnimation *)animation
{
    if (animation)
        [_actionList addObject:animation];
}

-(void) runAnimationsInView:(UIView *)view
{    
    if (!_actionList) {
        return;
    }
    
    CGPoint center = view.center;
    CGFloat alpha = view.alpha;
    CGAffineTransform transform = view.transform;
    
    LC_UIAnimation * animation = [self getFirstAnimation];
    
    switch (animation.animationType)
    {
        case LC_ANIMATION_TYPE_DISPLACEMENT_TO:
        {
            LC_UIAnimationDisplace * displaceMent  = (LC_UIAnimationDisplace *)animation;
            center.x = displaceMent.point.x;
            center.y = displaceMent.point.y;
            break;
        }
        case LC_ANIMATION_TYPE_DISPLACEMENT_BY:
        {
            LC_UIAnimationDisplace * displaceMent  = (LC_UIAnimationDisplace *)animation;
            center.x+=displaceMent.point.x;
            center.y+=displaceMent.point.y;
            break;
        }
        case LC_ANIMATION_TYPE_FADE_TO:
        {
            LC_UIAnimationFade * fadeAnimation  = (LC_UIAnimationFade *)animation;
            alpha=fadeAnimation.alpha;
            break;
        }
        case LC_ANIMATION_TYPE_FADE_BY:
        {
            LC_UIAnimationFade * fadeAnimation  = (LC_UIAnimationFade *)animation;
            alpha+=fadeAnimation.alpha;
            break;
        }
        case LC_ANIMATION_TYPE_SCALE_BY:
        {
            LC_UIAnimationScale * scale =(LC_UIAnimationScale *)animation;
            transform.a = scale.scaleX;
            transform.d = scale.scaleY;
            break;
        }
        case LC_ANIMATION_TYPE_SCALE_TO:
        {
            LC_UIAnimationScale * scale =(LC_UIAnimationScale *)animation;
            transform = CGAffineTransformMakeScale(scale.scaleX,
                                                   scale.scaleY);
            break;
        }
        case LC_ANIMATION_TYPE_ROTATE_BY:
        {
            LC_UIAnimationRotate * rotate =(LC_UIAnimationRotate *)animation;
            CGFloat radians = rotate.angle * M_PI/180;
            CGAffineTransform rotatedTransform = CGAffineTransformRotate(transform,radians);
            transform  = rotatedTransform;
            break;
        }
        case LC_ANIMATION_TYPE_ROTATE_TO:
        {
            LC_UIAnimationRotate * rotate =(LC_UIAnimationRotate *)animation;
            CGFloat radians = rotate.angle * M_PI/180;
            transform = CGAffineTransformMakeRotation(radians);
            //            CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(rotate.angle);
            break;
        }
        default:
            break;
    }
    
    LC_FAST_ANIMATIONS_O_F(animation.animationDuration, UIViewAnimationOptionCurveLinear, ^{
    
        view.center    = center;
        view.alpha     = alpha;
        view.transform = transform;
    
    },^(BOOL finished)
    {
       [self removeFirstAnimation];
       
       if (self.actionList.count == 0)
       {
           if (self.completionblock) {
               _completionblock(self);
           }
           return;
       }
       
       [self runAnimationsInView:view];
    });

}


@end