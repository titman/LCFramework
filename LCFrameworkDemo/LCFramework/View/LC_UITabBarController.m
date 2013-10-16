//
//  LC_UITableBarController.m
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


#import "LC_UITabBarController.h"

@interface LC_UITabBarController ()

@end

@implementation LC_UITabBarController

-(void) dealloc
{
    LC_RELEASE(_bar);
    LC_SUPER_DEALLOC();
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.bar.selectedIndex = self.selectedIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) init
{
    LC_SUPER_INIT({
    
        ;
        
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupBar
{
    self.tabBar.opaque = NO;
    self.tabBar.backgroundColor = [UIColor clearColor];

#if defined(__IPHONE_5_0)
    self.tabBar.tintColor = [UIColor clearColor];
    self.tabBar.backgroundImage = nil;
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.selectedImageTintColor = [UIColor clearColor];
    self.tabBar.selectionIndicatorImage = nil;
#endif	// #if defined(__IPHONE_5_0)
    
#if defined(__IPHONE_6_0)
    self.tabBar.shadowImage = nil;
#endif	// #if defined(__IPHONE_6_0)
    
    
    // init LC_UITabBar.
    self.bar = LC_AUTORELEASE([[LC_UITabBar alloc] initWithTabBarItems:nil]);
    self.bar.selectedIndex = self.selectedIndex;
    self.bar.backgroundColor = [UIColor redColor];
    
    [self.tabBar addSubview:self.bar];
}

-(void) resetTabBarWithViewControllers:(NSArray *)viewControllers
{
    NSMutableArray * items = [NSMutableArray array];
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL *stop) {

        UITabBarItem * sysTabBarItem = obj.tabBarItem;
        
        LC_UITabBarItem * item = [LC_UITabBarItem tabBarItemWithImage:sysTabBarItem.imageData[0] highlightedImage:sysTabBarItem.imageData[1]];
        [items addObject:item];
        
    }];
    
    self.bar.items = items;
}

-(void) handleTabBarItemClick:(LC_UITabBarItem *)item
{
    
}

-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    self.bar.selectedIndex = selectedIndex;
    [self handleTabBarItemClick:self.bar.items[selectedIndex]];
    
    [self.tabBar bringSubviewToFront:self.bar];
}

-(void) setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    
    int selectIndex = self.selectedIndex;
    
    [self handleTabBarItemClick:self.bar.items[selectIndex]];
    
    self.bar.selectedIndex = selectIndex;
    
    [self.tabBar bringSubviewToFront:self.bar];
}

-(void) setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    [self resetTabBarWithViewControllers:viewControllers];
}

-(void) setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    
    [self resetTabBarWithViewControllers:viewControllers];
}

@end
