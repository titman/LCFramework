//
//  LC_UITableBar.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

#pragma mark -

@interface LC_UITabBarItem : LC_UIButton

+(LC_UITabBarItem *) tabBarItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

-(void) setHighlighted:(BOOL)highlighted;

@end

#pragma mark -

@interface LC_UITabBar : LC_UIImageView

@property (nonatomic, retain) NSArray * items;
@property (nonatomic, assign) NSInteger	selectedIndex;

-(LC_UITabBar *) initWithTabBarItems:(NSArray *)items;

@end
