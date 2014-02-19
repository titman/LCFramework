//
//  LC_UIViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIViewController.h"

@interface LC_UIViewController ()

@end

@implementation LC_UIViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupContentView];
    
}

-(void) setupContentView
{
    if (IOS7_OR_LATER && !self.navigationController) {
        self.contentView = LC_AUTORELEASE([[UIView alloc] initWithFrame:LC_RECT_CREATE(0, 20, self.view.viewFrameWidth, self.view.viewFrameHeight-20)]);
    }else{
        self.contentView = LC_AUTORELEASE([[UIView alloc] initWithFrame:LC_RECT_CREATE(0, 0, self.view.viewFrameWidth, self.view.viewFrameHeight)]);
    }
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
}

@end
