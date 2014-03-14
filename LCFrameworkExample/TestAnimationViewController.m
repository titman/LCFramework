//
//  TestAnimationViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestAnimationViewController.h"

@interface TestAnimationViewController ()

@property(nonatomic,assign) LC_UIImageView * imageView;

@end

@implementation TestAnimationViewController

-(void) dealloc
{
    LC_SUPER_DEALLOC();
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

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self beginAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"动画";
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) beginAnimations
{
    __block LC_UINavigationController * dragNav = (LC_UINavigationController *)self.navigationController;
    dragNav.canDragBack = NO;
    
    if (self.imageView) {
        return;
    }
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    self.imageView = LC_AUTORELEASE([[LC_UIImageView alloc] initWithFrame:CGRectZero]);
    self.imageView.image = [UIImage imageNamed:@"120.png" useCache:NO];
    self.imageView.frame = LC_RECT_CREATE(self.view.center.x - 60, self.view.center.y - 60, 120, 120);
    [self.view addSubview:self.imageView];
    
    LC_UIAnimationFade * ani1 = [LC_UIAnimationFade animationToAlpha:1 duration:1.0];
    LC_UIAnimationScale * ani2 = [LC_UIAnimationScale animationByScaleX:1.5 scaleY:1.5 duration:0.3];
    LC_UIAnimationScale * ani3 = [LC_UIAnimationScale animationByScaleX:1.3 scaleY:1.3 duration:0.3];
    LC_UIAnimationRotate * ani4 = [LC_UIAnimationRotate animationByRotate:90.0 duration:0.4];
    LC_UIAnimationRotate * ani5 = [LC_UIAnimationRotate animationToRotate:180.0 duration:0.4];
    LC_UIAnimationScale * ani6 = [LC_UIAnimationScale animationByScaleX:3.0 scaleY:3.0 duration:1];
    LC_UIAnimationFade * ani7 = [LC_UIAnimationFade animationToAlpha:0 duration:0.5];
    
    LC_UIAnimationQueue * queue = [[LC_UIAnimationQueue alloc] init];
    
    [queue addAnimation:ani1];
    [queue addAnimation:ani2];
    [queue addAnimation:ani3];
    [queue addAnimation:ani4];
    [queue addAnimation:ani5];
    [queue addAnimation:ani6];
    [queue addAnimation:ani7];
    
    __block TestAnimationViewController * nRetainSelf = self;
    
    queue.completionblock = ^(id queue){
    
        self.navigationItem.leftBarButtonItem.enabled = YES;
        
        [queue release];
        
        LC_REMOVE_FROM_SUPERVIEW(nRetainSelf.imageView, YES);
        
        LC_UIAlertView * alertView = [LC_UIAlertView showMessage:@"播放完毕" cancelTitle:@"取消" otherButtonTitle:@"重新播放"];
        alertView.clickBlock = ^(LC_UIAlertView * alertView, NSInteger index){
            
            dragNav.canDragBack = YES;
            
            if (index == 1) {
                [nRetainSelf beginAnimations];
            }else{
                [nRetainSelf.navigationController popViewControllerAnimated:YES];
            }
        
        };
    
    };
    
    [self.imageView runAnimationsQueue:queue];
    
}

@end
