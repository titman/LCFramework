//
//  TestHTTPRequestViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
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

#import "TestHTTPRequestViewController.h"
#import "TestSubTitleCell.h"

@interface TestHTTPRequestViewController ()

#define ___ds1 @"datasource"

@end

@implementation TestHTTPRequestViewController

-(void) dealloc
{
    [self cancelRequests];
    
    LC_RDS(___ds1);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Http Request";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    
    
    
    __block TestHTTPRequestViewController * nRetainSelf = self;
    
    [self setPullStyle:LC_PULL_STYLE_HEADER
       backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
     beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){
         
         if (diretion == LC_PULL_DIRETION_TOP) {
             [nRetainSelf beginRequest];
         }
         
     }];
    
    [self.pullLoader startRefresh];
    
    /*
        LC_HTTPRequest * request = [self GET:@"http://m.weather.com.cn/data/101010100.html"];
        
        [request setWhenUpdate:^(LC_HTTPRequest * request){
            / To to something.
        }];
        
    */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

-(void) beginRequest
{
    //self.HTTP_GET(@"http://m.weather.com.cn/data/101010100.html");
    self.GET(@"http://m.weather.com.cn/data/101010100.html");
}

- (void) handleRequest:(LC_HTTPRequest *)request
{
    if (request.succeed) {
        
        [self setDatasource:[request.jsonData objectForKey:@"weatherinfo"] key:___ds1];
        
        [self endLoading];
        
    }else if (request.failed){
        
        [self endLoading];
        
    }else if (request.cancelled){

    }
}

-(void) endLoading
{
    [self.pullLoader endRefresh];
    [self reloadData];
}

#pragma mark -

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(int) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LC_DS(___ds1) allKeys].count;
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestSubTitleCell class]];
    
    NSString * title = [LC_DS(___ds1) allKeysSelectKeyAtIndex:indexPath.row];
    NSString * subTitle = [LC_DS(___ds1) objectForKey:title];
    
    [cell setTitle:title subTitle:subTitle];
    
    return cell;
}

@end
