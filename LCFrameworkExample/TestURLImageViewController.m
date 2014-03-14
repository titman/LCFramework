//
//  TestURLImageViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-26.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestURLImageViewController.h"
#import "TestImageSubTitleCell.h"

@interface TestURLImageViewController ()

#define ___ds1 @"userDatasource"

@end

@implementation TestURLImageViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"图片URL加载";
    
    [self setDatasource:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2000用户测试数据" ofType:@"plist"]] key:___ds1];
    
    [self setEdgesForExtendedLayoutNoneStyle];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    TestImageSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestImageSubTitleCell class]];
    
    NSDictionary * userData = [LC_DS(___ds1) objectAtIndex:indexPath.row];
    
    NSString * imageURL = [userData objectForKey:@"head"];
    NSString * userName = [userData objectForKey:@"nickName"];
    NSString * sign     = [userData objectForKey:@"sign"];
    
    [cell setTitle:userName subTitle:sign imageURL:imageURL];

    return cell;
}

-(void) tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}

@end
