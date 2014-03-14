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
    
    self.title = @"手指滑动屏幕返回";
    
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    LC_UILabel * tipLabel = [[LC_UILabel alloc] initWithFrame:LC_RECT_CREATE(0, 0, self.view.viewFrameWidth, self.view.viewFrameHeight) copyingEnabled:NO];
    
    tipLabel.textColor     = [UIColor colorWithHexString:@"#6cbbcc"];
    tipLabel.font          = [UIFont boldSystemFontOfSize:14];
    tipLabel.textAlignment = UITextAlignmentCenter;
    tipLabel.text          = @"手指按住屏幕,轻轻向右滑动";
    
    [self.view addSubview:tipLabel];
    LC_RELEASE(tipLabel);
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
