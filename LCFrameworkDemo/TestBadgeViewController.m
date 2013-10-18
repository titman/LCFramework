//
//  TestBadgeViewController.m
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

#import "TestBadgeViewController.h"

@interface TestBadgeViewController ()
{
    LC_UIBadgeView * badgeView;
}

@end

@implementation TestBadgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    badgeView.center = LC_POINT_CREATE(self.view.center.x, self.view.center.y - 100);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"系统Badge";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    
    
    
    badgeView = [[LC_UIBadgeView alloc] initWithFrame:LC_RECT_CREATE(0, 0, 0, 0) valueString:@"N"];
    
    [self.view addSubview:badgeView];
    LC_RELEASE(badgeView);
    

    
    LC_UIButton * button = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20, 250, LC_DEVICE_WIDTH - 40, 44)];
    button.title = @"点击增加数量";
    button.backgroundColor = [UIColor colorWithHexString:@"#6cbbcc"];
    [button addTarget:self action:@selector(addBadgeNumber) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    LC_RELEASE(button);
    
    
    
    LC_UIButton * button1 = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20, 250 + 44 + 5, LC_DEVICE_WIDTH - 40, 44)];
    button1.title = @"点击设置文字";
    button1.backgroundColor = [UIColor colorWithHexString:@"#6cbbcc"];
    [button1 addTarget:self action:@selector(addBadgeString) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    LC_RELEASE(button1);
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) addBadgeNumber
{
    if ([badgeView.valueString  intValue] == 0) {
        badgeView.valueString = @"1";
    }else{
        badgeView.valueString = LC_NSSTRING_FORMAT(@"%d",[badgeView.valueString intValue] + 1);
    }
    
    badgeView.center = LC_POINT_CREATE(self.view.center.x, self.view.center.y - 100);
}

-(void) addBadgeString
{
    badgeView.valueString = @"扶老奶奶";
    
    badgeView.center = LC_POINT_CREATE(self.view.center.x, self.view.center.y - 100);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
