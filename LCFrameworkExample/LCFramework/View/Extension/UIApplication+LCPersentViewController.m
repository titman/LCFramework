//
//  UIApplication+LCPersentViewController.m
//  NextApp
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com )  on 14-4-9.
//  Copyright (c) 2014年 http://nextapp.com.cn/. All rights reserved.
//

#import "UIApplication+LCPersentViewController.h"

static NSMutableDictionary * allPersentViewController = nil;

@implementation UIApplication (LCPersentViewController)

-(NSMutableDictionary *) shareAllPersentViewController
{
    if (!allPersentViewController) {
        allPersentViewController = [[NSMutableDictionary alloc] init];
    }
    
    return allPersentViewController;
}

-(BOOL) persentViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.keyWindow.rootViewController) {
        
        NSMutableDictionary * dic = [self shareAllPersentViewController];
        
        if ([dic objectForKey:LC_NSSTRING_FORMAT(@"%p",viewController)]) {
            
            ERROR(@"UIApplication+LCPersentViewController happened an error : %@ already persented.",[viewController class]);
            return NO;
        }
        
        [dic setObject:viewController forKey:LC_NSSTRING_FORMAT(@"%p",viewController)];
        
        // Begain add view and animate
        
        UIView * view = viewController.view;
        
        if (!animated) {
            
            [viewController viewWillAppear:NO];

            [self.keyWindow.rootViewController.view addSubview:view];
            
            [viewController viewDidAppear:NO];

            
        }else{
            
            [viewController viewWillAppear:YES];
            
            float x = view.viewFrameX;
            float y = view.viewFrameY;
            
            view.frame = CGRectMake(x, self.keyWindow.viewFrameHeight, view.viewFrameWidth, view.viewFrameHeight);
            
            [self.keyWindow.rootViewController.view addSubview:view];
            
            LC_FAST_ANIMATIONS_F(0.5, ^{
                
                view.frame = CGRectMake(x, y, view.viewFrameWidth, view.viewFrameHeight);
                
            }, ^(BOOL isFinished){
                
                [viewController viewDidAppear:YES];
                
            });
        }
        
        return YES;
    }
    
    ERROR(@"UIApplication+LCPersentViewController happened an error : %@ no have a keyWindow.",[self class]);
    return NO;
}

-(BOOL) dismissModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController * find = [[self shareAllPersentViewController] objectForKey:LC_NSSTRING_FORMAT(@"%p",viewController)];
    
    if (find) {
        
        UIView * view = viewController.view;
        
        if (!animated) {
            
            [viewController viewWillDisappear:NO];
            [viewController viewDidDisappear:NO];
            
            [view removeFromSuperview];
            
        }else{
            
            [viewController viewWillDisappear:YES];
            
            LC_FAST_ANIMATIONS_F(0.5, ^{
                
                viewController.view.frame = CGRectMake(viewController.view.viewFrameX, self.keyWindow.viewFrameHeight, view.viewFrameWidth, view.viewFrameHeight);
                
            }, ^(BOOL isFinished){
                
                [viewController viewWillDisappear:YES];
                [view removeFromSuperview];
                
            });
        }
        
        [[self shareAllPersentViewController] removeObjectForKey:LC_NSSTRING_FORMAT(@"%p",viewController)];
        
        return YES;
    }
    
    ERROR(@"UIApplication+LCPersentViewController happened an error : %@ will dismiss viewcontroller not found.",[viewController class]);
    
    return NO;
}

@end
