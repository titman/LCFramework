//
//  LC_UIActionSheet.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
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

#import "LC_UIActionSheet.h"

@interface LC_UIActionSheet ()

@property (nonatomic,assign) UIView * inView;

@end

@implementation LC_UIActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) showInView:(UIView *)view animated:(BOOL)animated
{
    if (animated) {
        
        [super showFromRect:view.frame inView:view animated:NO];
        
        self.inView = view;
        
//        self.frame = LC_RECT_CREATE( self.viewFrameX, self.viewFrameY + self.viewFrameHeight, self.viewFrameWidth, self.viewFrameHeight);
//        
//        //动画部分
//        LC_FAST_ANIMATIONS_O_F(0.3, UIViewAnimationOptionCurveLinear, ^{
//        
//            self.alpha = 1;
//            self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY - self.viewFrameHeight - 20, self.viewFrameWidth, self.viewFrameHeight + 20);
//        
//        }, ^(BOOL isFinished){
//
//            LC_FAST_ANIMATIONS(0.2, ^{
//            
//                self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY + 20, self.viewFrameWidth ,self.viewFrameHeight-20);
//            
//            });
//        
//        });
        
        LC_FAST_ANIMATIONS(0.3, ^{
        
            CGAffineTransform t = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            view.transform = t;
            
        });
        
        
    }else{
    
        [self showFromRect:view.frame inView:view animated:NO];
        
    }
}

-(void) dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    
    LC_FAST_ANIMATIONS(0.3, ^{
    
        CGAffineTransform t = CGAffineTransformIdentity;
        [self.inView setTransform:t];
    
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
