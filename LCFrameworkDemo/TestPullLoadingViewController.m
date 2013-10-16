//
//  TestPullLoadingViewController.m
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

#import "TestPullLoadingViewController.h"
#import "TestSubTitleCell.h"

@interface TestPullLoadingViewController () <UIActionSheetDelegate>

#define ___ds1 @"datasource"

@end

@implementation TestPullLoadingViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    LC_RDS(___ds1);
    LC_SUPER_DEALLOC();
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    LC_UIActionSheet * actionSheet = [[LC_UIActionSheet alloc] initWithTitle:@"选择一个方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"只有下拉刷新",@"只有上拉刷新",@"上拉下拉同时存在",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:LC_KEYWINDOW animated:YES];
    LC_RELEASE(actionSheet);
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
    
    [self setDatasource:[NSMutableArray arrayWithObjects:
                         LC_NSSTRING_FORMAT(@"%d",arc4random()),
                         LC_NSSTRING_FORMAT(@"%d",arc4random()),
                         LC_NSSTRING_FORMAT(@"%d",arc4random()),
                         nil] key:___ds1];
    
    self.title = @"上拉下拉刷新";
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    __block TestPullLoadingViewController * nRetainSelf = self;
    
    switch (buttonIndex) {
        case 0: // 下拉刷新
            
            // 以下方法调用后将赋予TableView pull refresh的能力
            [self setPullStyle:LC_PULL_STYLE_HEADER
               backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
             beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){

                 //此处可以根据需要写成加载网络数据或是本地数据
                 [nRetainSelf performSelectorInBackground:@selector(loadData) withObject:nil];
                 
             }];
            
            break;
        case 1: // 上拉刷新
            
            [self setPullStyle:LC_PULL_STYLE_FOOTER
               backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
             beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){
                 
                 [nRetainSelf performSelectorInBackground:@selector(loadData) withObject:nil];
                 
             }];
            
            break;
        case 2: // 上拉刷新加下拉刷新
            
            [self setPullStyle:LC_PULL_STYLE_HEADER_AND_FOOTER
               backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
             beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){
                 
                 [nRetainSelf performSelectorInBackground:@selector(loadData) withObject:nil];
                 
             }];
            
            break;
            
        default:
            break;
    }
}


-(void) loadData
{
    LC_AUTORELEASE_POOL_START()
    
    NSMutableArray * datasource = LC_DS(___ds1);
    
    NSString * data1 = LC_NSSTRING_FORMAT(@"%d",arc4random());
    NSString * data2 = LC_NSSTRING_FORMAT(@"%d",arc4random());
    NSString * data3 = LC_NSSTRING_FORMAT(@"%d",arc4random());
    
    [datasource addObject:data1];
    [datasource addObject:data2];
    [datasource addObject:data3];

    [NSThread sleepForTimeInterval:3];

    LC_AUTORELEASE_POOL_END()
    
    LC_GCD_SYNCHRONOUS(^{
        
        [self.pullLoader endRefresh];
        [self reloadData];
        
    });
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(int) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LC_DS(___ds1) count];
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestSubTitleCell class]];
    
    [cell setTitle:@"cell" subTitle:[LC_DS(___ds1) objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
