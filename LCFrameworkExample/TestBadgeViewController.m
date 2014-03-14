//
//  TestBadgeViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
            selectImage:nil];
    
    
    
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
