//
//  TestLabelViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestLabelViewController.h"

@interface TestLabelViewController ()

@end

@implementation TestLabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"长按Label进行copy";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    LC_UILabel * tipLabel = LC_UILabel.view;
    
    tipLabel.viewFrameX = 20;
    tipLabel.viewFrameY = 20;
    tipLabel.viewFrameWidth = LC_DEVICE_WIDTH - 40;
    tipLabel.viewFrameHeight = LC_DEVICE_HEIGHT - 40 - 64;
    
    tipLabel.textColor = [UIColor colorWithHexString:@"#6cbbcc"];
    tipLabel.font      = [UIFont boldSystemFontOfSize:14];
    tipLabel.text      = @"    Block除了能够定义参数列表、返回类型外，还能够获取被定义时的词法范围内的状态（比如局部变量），并且在一定条件下（比如使用__block变量）能够修改这些状态。此外，这些可修改的状态在相同词法范围内的多个block之间是共享的，即便出了该词法范围（比如栈展开，出了作用域），仍可以继续共享或者修改这些状态。\n    通常来说，block都是一些简短代码片段的封装，适用作工作单元，通常用来做并发任务、遍历、以及回调。\n    比如我们可以在遍历NSArray时做一些事情：\n    - (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;\n    其中将stop设为YES，就跳出循环，不继续遍历了。\n";
    
    tipLabel.numberOfLines = 0;
    tipLabel.backgroundColor = LC_RGBA(0, 0, 0, 0.1);
    tipLabel.layer.cornerRadius = 10;
    tipLabel.layer.masksToBounds = YES;
    
    tipLabel.copyingEnabled = YES;
    
    self.view.ADD(tipLabel);
}

-(void) tap
{
    NSLog(@"tap");
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
