//
//  LC_UIBadgeView.m
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

#import "LC_UIBadgeView.h"

@interface LC_UIBadgeView ()

@property(nonatomic,retain) UIView * badgeView;

@end

@implementation LC_UIBadgeView

-(void) dealloc
{
    LC_RELEASE(_badgeView);
    LC_RELEASE(_valueString);
    LC_SUPER_DEALLOC();
}

- (id)initWithFrame:(CGRect)frame valueString:(NSString *)valueString
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.valueString = valueString;
    }
    return self;
}

-(void) findBadgeWithValueString:(NSString *)valueString
{
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = valueString;
    
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;
    [item release];
    [array release];
    
    for (UIView * viewTab in tabBar.subviews) {
        
        for (UIView *subview in viewTab.subviews) {
            
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"])
            {
                //从原视图上移除
                [subview removeFromSuperview];
                self.badgeView = subview;
                
                break;
            }
        }
    }
    
    [tabBar release];
}

-(void) setValueString:(NSString *)valueString
{
    if (_valueString == valueString) {
        return;
    }
    
    if (_valueString) {
        [_valueString release];
    }
    
    _valueString = [valueString retain];
    
    if (_badgeView) {
        LC_REMOVE_FROM_SUPERVIEW(_badgeView, YES);
    }
    
    [self findBadgeWithValueString:valueString];
    
    if (_badgeView) {
        
        _badgeView.frame = LC_RECT_CREATE(0, 0, _badgeView.viewFrameWidth, _badgeView.viewFrameHeight);
        
        self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY, _badgeView.viewFrameWidth, _badgeView.viewFrameHeight);
        [self addSubview:_badgeView];
    }else{
        NSLog(@"%@ 该类已不适用!",[self class]);
    }
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
