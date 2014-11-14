//
//  TestHTTPRequestViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Http Request";
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    
    LC_BLOCK_SELF;
    
    [self setPullStyle:LC_PULL_STYLE_HEADER
       backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
     beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){
         
         if (diretion == LC_PULL_DIRETION_TOP) {
             [nRetainSelf beginRequest];
         }
         
     }];
    
    [self.pullLoader performSelector:@selector(startRefresh) withObject:nil afterDelay:0];
    
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
    [self.GET(@"http://m.weather.com.cn/data/101010100.html") setWhenUpdate:^(LC_HTTPRequest * request){
    
        if (request.succeed) {
            
            LC_SDS([request.jsonData objectForKey:@"weatherinfo"], ___ds1);
            [self endLoading];
            
        }else if (request.failed){
            
            [self endLoading];
            
        }else if (request.cancelled){
            
        }
        
    }];
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

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LC_DS(___ds1) allKeys].count;
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestSubTitleCell class]];
    
    NSString * title = [LC_DS(___ds1) allKeysSelectKeyAtIndex:indexPath.row];
    NSString * subTitle = LC_DS(___ds1)[title];
    
    [cell setTitle:title subTitle:subTitle];
    
    return cell;
}

@end
