//
//  LC_UITableBar.m
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
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

#import "LC_UITabBar.h"

#define LC_UITabBar_Height 49.f

#pragma mark -

@interface LC_UITabBarItem ()

@property (nonatomic,retain) UIImage * image;
@property (nonatomic,retain) UIImage * selectedImage;

@end

#pragma mark -

@implementation LC_UITabBarItem

-(void) dealloc
{
    LC_RELEASE(_image);
    LC_RELEASE(_selectedImage);
    LC_SUPER_DEALLOC();
}

+(LC_UITabBarItem *) tabBarItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;
{
    LC_UITabBarItem * item = [[LC_UITabBarItem alloc] initWithImage:image highlightedImage:highlightedImage];

    return LC_AUTORELEASE(item);
    
}

-(id) initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        self.image = image;
        self.selectedImage = highlightedImage;
    
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];

    }
    
    return self;
}

-(void) setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        [self setImage:self.selectedImage forState:UIControlStateNormal];
        [self setImage:self.selectedImage forState:UIControlStateHighlighted];
    }else{
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:self.image forState:UIControlStateHighlighted];
    }
}


@end

#pragma mark -

@implementation LC_UITabBar

-(void) dealloc
{
    LC_RELEASE(_items);
    LC_SUPER_DEALLOC();
}

-(LC_UITabBar *) initWithTabBarItems:(NSArray *)items
{
    self = [super initWithFrame:LC_RECT_CREATE(0, 0, LC_DEVICE_WIDTH, LC_UITabBar_Height)];
    
    if (self) {
        
        self.items = items;
        self.backgroundImage = [UIImage imageNamed:@"LC_DefaultTabbarBkg.png" useCache:NO];
        
    }
    
    return self;
}

-(void) setItems:(NSArray *)items
{
    if (items == _items) {
        return;
    }
    
    if (_items) {
        for (LC_UITabBarItem * item in _items) {
            LC_REMOVE_FROM_SUPERVIEW(item, NO);
        }
    }
    
    LC_RELEASE(_items);
    _items = LC_RETAIN(items);
    
    if (!_items) {
        return;
    }
    
    float itemWidth = self.viewFrameWidth / _items.count;
    float itemHeight = self.viewFrameHeight;
    
    [items enumerateObjectsUsingBlock:^(LC_UITabBarItem * item ,NSUInteger idx, BOOL *stop)
    {
        item.frame = LC_RECT_CREATE(itemWidth * idx, 0, itemWidth, itemHeight);
        item.tagString = LC_NSSTRING_FORMAT(@"%d",idx);
        [self addSubview:item];
    }];
}

-(void) setSelectedIndex:(NSInteger)selectedIndex
{
    [self.items enumerateObjectsUsingBlock:^(LC_UITabBarItem * item ,NSUInteger idx, BOOL *stop)
    {
        if (selectedIndex == idx) {
            [item setHighlighted:YES];
        }else{
            [item setHighlighted:NO];
        }
    }];
    
}


@end
