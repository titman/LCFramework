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
    if (self.imageView) {
        return;
    }
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    self.imageView = LC_UIImageView.view;
    self.imageView.image = [UIImage imageNamed:@"120.png" useCache:NO];
    
    self.imageView.viewFrameX = self.view.viewCenterX - 60;
    self.imageView.viewFrameY = self.view.viewCenterY - 60;
    self.imageView.viewFrameWidth = 120;
    self.imageView.viewFrameHeight = 120;
    
    self.view.ADD(self.imageView);
    
    LC_UIAnimationFade   * ani1 = [LC_UIAnimationFade   animationToAlpha:1 duration:1.0];
    LC_UIAnimationScale  * ani2 = [LC_UIAnimationScale  animationByScaleX:1.5 scaleY:1.5 duration:0.3];
    LC_UIAnimationScale  * ani3 = [LC_UIAnimationScale  animationByScaleX:1.3 scaleY:1.3 duration:0.3];
    LC_UIAnimationRotate * ani4 = [LC_UIAnimationRotate animationByRotate:90.0 duration:0.4];
    LC_UIAnimationRotate * ani5 = [LC_UIAnimationRotate animationToRotate:180.0 duration:0.4];
    LC_UIAnimationScale  * ani6 = [LC_UIAnimationScale  animationByScaleX:3.0 scaleY:3.0 duration:1];
    LC_UIAnimationFade   * ani7 = [LC_UIAnimationFade   animationToAlpha:0 duration:0.5];
    
    LC_UIAnimationQueue * queue = [[LC_UIAnimationQueue alloc] init];
    
    [queue addAnimation:ani1];
    [queue addAnimation:ani2];
    [queue addAnimation:ani3];
    [queue addAnimation:ani4];
    [queue addAnimation:ani5];
    [queue addAnimation:ani6];
    [queue addAnimation:ani7];
    
    LC_BLOCK_SELF;

    queue.completionblock = ^(id queue){
    
        nRetainSelf.navigationItem.leftBarButtonItem.enabled = YES;
        
        LC_REMOVE_FROM_SUPERVIEW(nRetainSelf.imageView, YES);
        
        LC_UIAlertView * alertView = [LC_UIAlertView showMessage:@"播放完毕" cancelTitle:@"取消" otherButtonTitle:@"重新播放"];
        
        alertView.clickBlock = ^(BOOL cancelled, NSInteger buttonIndex){
                        
            if (buttonIndex == 1) {
                [nRetainSelf beginAnimations];
            }else{
                [nRetainSelf.navigationController popViewControllerAnimated:YES];
            }
        
        };
        
        [queue release];
    
    };
    
    [self.imageView runAnimationsQueue:queue];
    
}

@end
