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
    self.tabBar.opaque = YES;
    self.tabBar.alpha = 0;
    
    // init LC_UITabBar.
    self.bar = LC_AUTORELEASE([[LC_UITabBar alloc] initWithTabBarItems:nil]);
    self.bar.selectedIndex = self.selectedIndex;
    self.bar.backgroundColor = [UIColor clearColor];
    self.bar.frame = self.tabBar.frame;
    self.bar.userInteractionEnabled = YES;
    
    [self.view addSubview:self.bar];
    
    [self.tabBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([object isEqual:self.tabBar]) {
        if ([keyPath isEqualToString:@"frame"]) {
            
            self.tabBar.alpha = 0;
        }
    }
}

-(void) hideBar:(BOOL)yesOrNo animation:(BOOL)animation
{
    if (animation) {
        LC_FAST_ANIMATIONS(0.25, ^{
            
            if (yesOrNo) {
                self.bar.alpha = 0;
            }else{
                self.bar.alpha = 1;
            }
            
        });
    }else{
        if (yesOrNo) {
            self.bar.alpha = 0;
        }else{
            self.bar.alpha = 1;
        }
    }
}

-(void) resetTabBarWithViewControllers:(NSArray *)viewControllers
{
    NSMutableArray * items = [NSMutableArray array];
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL *stop) {

        UITabBarItem * sysTabBarItem = obj.tabBarItem;
        
        LC_UITabBarItem * item = [LC_UITabBarItem tabBarItemWithImage:sysTabBarItem.imageData[0] highlightedImage:sysTabBarItem.imageData[1]];
        item.tag = idx;
        [item addTapTarget:self selector:@selector(itemClick:)];
         [items addObject:item];
        
    }];
    
    self.bar.items = items;
}

-(void) itemClick:(UITapGestureRecognizer *)tap
{
    [self setSelectedIndex:tap.view.tag];
}

-(void) handleTabBarItemClick:(LC_UITabBarItem *)item
{
    ;
}

-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    self.bar.selectedIndex = selectedIndex;
    [self handleTabBarItemClick:self.bar.items[selectedIndex]];
    
    [self.view bringSubviewToFront:self.bar];
}

-(void) setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];

    NSInteger selectIndex = self.selectedIndex;
    
    [self handleTabBarItemClick:self.bar.items[selectIndex]];
    
    self.bar.selectedIndex = selectIndex;
    
    [self.view bringSubviewToFront:self.bar];
}

-(void) setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    [self resetTabBarWithViewControllers:viewControllers];
    
    [self.view bringSubviewToFront:self.bar];
}

-(void) setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    
    [self resetTabBarWithViewControllers:viewControllers];
    
    [self.view bringSubviewToFront:self.bar];
}

@end
