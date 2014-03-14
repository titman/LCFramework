//
//  TestPullLoadingViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
            selectImage:nil];
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
    [LC_Audio playSoundName:@"000-click.mp3"];
    
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

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
