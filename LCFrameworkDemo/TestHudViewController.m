//
//  TestHudViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
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

#import "TestHudViewController.h"

@interface TestHudViewController ()
{
    float _time;
}

@end

@implementation TestHudViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Hud";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];

    NSArray * titleArray = @[@"普通HUD",@"失败HUD",@"成功HUD",@"LoadingHUD",@"ProgressHUD"];
    
    for (int i = 0; i< titleArray.count; i++) {
        
        LC_UIButton * button = [[LC_UIButton alloc] initWithFrame:LC_RECT_CREATE(20, 44*i + 20*i + 20, LC_DEVICE_WIDTH - 40, 44)];
        button.title = titleArray[i];
        button.tag = i;
        button.backgroundColor = [UIColor colorWithHexString:@"#6cbbcc"];
        [button addTarget:self action:@selector(testHud:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        LC_RELEASE(button);
    }
    
}

-(void) testHud:(LC_UIButton *)button
{
    switch (button.tag) {
        case 0:
            [self showMessageHud:@"测试"];
            break;
        case 1:
            [self showFailureHud:@"o(╯□╰)o"];
            break;
        case 2:
            [self showSuccessHud:@"o(≧v≦)o~~"];
            break;
        case 3:
        {
            LC_UIHud * hud = [self showLoadingHud:@"正在读取···"];
            [hud hide:YES afterDelay:2];
        }
            break;
        case 4:
        {
            LC_UIHud * hud = [self showProgressHud:@"正在下载···"];
            [self startProgressHud:hud];
        }
            break;
        default:
            break;
    }
}

-(void) startProgressHud:(LC_UIHud *)hud
{
    [self performSelector:@selector(handleProgress:) withObject:hud afterDelay:0.1];
}

-(void) handleProgress:(LC_UIHud *)hud
{
    if (_time >= 10) {
        [hud hide:YES];
        _time = 0;
        return;
    }
    
    
    _time += 1;

    hud.progress = _time / 10;
    
    [self startProgressHud:hud];
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
