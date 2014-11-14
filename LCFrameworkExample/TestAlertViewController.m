//
//  TestAlertViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestAlertViewController.h"

@interface TestAlertViewController ()

@end

@implementation TestAlertViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showAlertView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Block_UIAlertView";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
}

-(void) showAlertView
{
    LC_BLOCK_SELF;
    
    //Alert View
    NSString * message = LC_NSSTRING_FORMAT(@"version : %s",LC_VERSION);
    
    [LC_UIAlertView showMessage:message cancelTitle:@"确定"].clickBlock = ^(BOOL cancel, NSInteger index){
        
        NSLog(@"LC_UIAlertView block start (%@)",nRetainSelf);
        NSLog(@"Click index : %d",index);
        
    };
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
