//
//  LC_UITableBar.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
        
        self.clipsToBounds = NO;

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
        self.clipsToBounds = NO;
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
        item.tagString = LC_NSSTRING_FORMAT(@"%ld",(unsigned long)idx);
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
