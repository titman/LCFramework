//
//  TestCrashReportViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "TestCrashReportViewController.h"
#import "TestSubTitleCell.h"

@interface TestCrashReportViewController ()

#define ___ds1 @"datasource"

@end

@implementation TestCrashReportViewController

-(void) dealloc
{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    LC_UIAlertView * alertView = [LC_UIAlertView showMessage:@"点击“Crash”按钮程序将立即Crash,重新打开程序并进入该页面将看见崩溃日志"
                                                 cancelTitle:@"取消"
                                            otherButtonTitle:@"Crash"];
    
    alertView.clickBlock = ^(LC_UIAlertView * alertView, NSInteger index){
        
        if (index == 1) {
            [[NSArray array] objectAtIndex:1];
        }
        
    };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setDatasource:[LC_CrashReport crashLog] key:___ds1];
    
    self.title = LC_NSSTRING_FORMAT(@"崩溃日志(%d)",[LC_DS(___ds1) count]);
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    
    [self showBarButton:NavigationBarButtonTypeRight system:UIBarButtonSystemItemTrash];
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (NavigationBarButtonTypeLeft == type) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [LC_CrashReport cleanCrashLog];
        [self setDatasource:[NSMutableArray array] key:___ds1];
        [self reloadData];
        [LC_UIAlertView showMessage:@"清除完成" cancelTitle:@"确定"];
    }
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LC_DS(___ds1) count];
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestSubTitleCell class]];
    
    NSDictionary * crashData = [LC_DS(___ds1) objectAtIndex:indexPath.row];
    
    [cell setTitle:[crashData objectForKey:@"date"]
          subTitle:[crashData objectForKey:@"exception"]];
    
    return cell;
}

-(void) tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * crashData = [LC_DS(___ds1) objectAtIndex:indexPath.row];

    [LC_UIAlertView showMessage:[crashData objectForKey:@"callStackSymbols"] cancelTitle:@"确定"];
}

@end
