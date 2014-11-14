//
//  LC_UIBadgeView.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIBadgeView.h"

@interface LC_UIBadgeView ()

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
    
    UITabBarItem *item = [[[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0] autorelease];
    item.badgeValue = valueString;
    
    tabBar.items = @[item];
    
    NSArray * tabbarSubviews = tabBar.subviews;
    
    for (UIView * viewTab in tabbarSubviews) {
        
        for (UIView * subview in viewTab.subviews) {
            
            NSString * strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"])
            {
                [subview retain];
                //从原视图上移除
                [subview removeFromSuperview];
                self.badgeView = subview;
                [subview release];
                
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
    
    if (self.hideWhenEmpty) {
        if (_valueString.length <= 0 || [_valueString isEqualToString:@"0"]) {
            return;
        }
    }

    [self findBadgeWithValueString:valueString];
    
    if (_badgeView) {
        
        _badgeView.frame = LC_RECT_CREATE(0, 0, _badgeView.viewFrameWidth, _badgeView.viewFrameHeight);
        self.frame = LC_RECT_CREATE(self.viewFrameX, self.viewFrameY, _badgeView.viewFrameWidth, _badgeView.viewFrameHeight);
        [self addSubview:_badgeView];
        
    }else{
        ERROR(@"%@ 该类已不适用!",[self class]);
    }
    
    [self setKawaiiBubble:_kawaiiBubble];
}

-(void) setKawaiiBubble:(BOOL)kawaiiBubble
{
    _kawaiiBubble = kawaiiBubble;
    
    if (_kawaiiBubble) {
        
        [self setValueString:@" "];
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    }
    else{
        
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
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
