//
//  TestLabelViewController.m
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

#import "TestLabelViewController.h"

@interface TestLabelViewController ()

@end

@implementation TestLabelViewController

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
    
    self.title = @"长按Label进行copy";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    
    LC_UILabel * tipLabel = [[LC_UILabel alloc] initWithFrame:LC_RECT_CREATE(20, 20, LC_DEVICE_WIDTH-40, LC_DEVICE_HEIGHT-44-40) copyingEnabled:YES];
    
    tipLabel.textColor = [UIColor colorWithHexString:@"#6cbbcc"];
    tipLabel.font      = [UIFont boldSystemFontOfSize:14];
    tipLabel.text      = @"    Block除了能够定义参数列表、返回类型外，还能够获取被定义时的词法范围内的状态（比如局部变量），并且在一定条件下（比如使用__block变量）能够修改这些状态。此外，这些可修改的状态在相同词法范围内的多个block之间是共享的，即便出了该词法范围（比如栈展开，出了作用域），仍可以继续共享或者修改这些状态。\n    通常来说，block都是一些简短代码片段的封装，适用作工作单元，通常用来做并发任务、遍历、以及回调。\n    比如我们可以在遍历NSArray时做一些事情：\n    - (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;\n    其中将stop设为YES，就跳出循环，不继续遍历了。\n";
    
    tipLabel.numberOfLines = 0;
    tipLabel.backgroundColor = LC_COLOR_W_RGB(0, 0, 0, 0.1);
    tipLabel.layer.cornerRadius = 10;
    tipLabel.layer.masksToBounds = YES;
    
    [self.view addSubview:tipLabel];
    LC_RELEASE(tipLabel);
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
