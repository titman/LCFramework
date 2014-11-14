//
//  TestUINavigationController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestNavigationController.h"

@interface TestNavigationController ()

@end

@implementation TestNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"手指滑动屏幕返回";
    
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    LC_UILabel * tipLabel = LC_UILabel.view;
    
    tipLabel.viewFrameWidth = self.view.viewFrameWidth;
    tipLabel.viewFrameHeight = self.view.viewFrameHeight;
    
    tipLabel.textColor     = [UIColor colorWithHexString:@"#6cbbcc"];
    tipLabel.font          = [UIFont boldSystemFontOfSize:14];
    tipLabel.textAlignment = UITextAlignmentCenter;
    tipLabel.text          = @"手指按住屏幕左边边缘,轻轻向右滑动";
    
    self.view.ADD(tipLabel);
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
