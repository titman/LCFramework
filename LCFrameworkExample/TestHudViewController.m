//
//  TestHudViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
            selectImage:nil];

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
