//
//  TestViewController.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "TestViewController.h"
#import "TestPullLoadingViewController.h"
#import "TestSubTitleCell.h"
#import "TestNavigationController.h"
#import "LC_UIWebViewController.h"
#import "TestLabelViewController.h"
#import "TestBadgeViewController.h"
#import "TestHTTPRequestViewController.h"
#import "TestCrashReportViewController.h"
#import "TestSystemInfoViewController.h"
#import "TestURLImageViewController.h"
#import "TestAlertViewController.h"
#import "TestHudViewController.h"
#import "TestAnimationViewController.h"
#import "DRMainViewController.h"

@interface TestViewController ()

#define ___ds1 @"View"
#define ___ds2 @"function"
#define ___ds3 @"example"

@end

@implementation TestViewController

-(void) dealloc
{
    LC_RDS(___ds1);
    LC_RDS(___ds2);
    LC_RDS(___ds3);

    LC_SUPER_DEALLOC();
}

- (id) init
{
    LC_SUPER_INIT({
    
        NSLog(@"init finished : %@",self);
    
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.title = @"LCFramework";
    
    [self setDatasource:@[
                          
                          @" 滑动返回 && LC_UINavigationController",
                          @" 上下拉刷新的TableView以及ActionSheet && LC_UIPullLoader & LC_UIActionSheet",
                          @" WebView && LC_WebViewController",
                          @" 可copy的Label && LC_UILabel ",
                          @" NavigationBar提示 && LC_UINavigationNotificationView",
                          @" Badge气泡 && LC_UIBadgeView",
                          @" 图片的异步加载 && LC_UIImageView",
                          @" Block的UIAlertView && LC_UIAlertView",
                          @" 提示框(Hud) && LC_UIHud",
                          @" 动画队列 && LC_UIAnimation",
                          @" 侧边菜单 && LC_UISideMenu",
                          @" View顶部提示 && LC_UITopNotificationView"

                          
                          ] key:___ds1];
    
    [self setDatasource:@[
                          
                          @" 网络请求 && LC_HTTPRequest",
                          @" 程序崩溃记录 && LC_CrashReport",
                          @" 系统信息 && LC_SystemInfo",
                          @" UI事件信号自动路由 && LC_UISingle",
                          @" KVO以及数据绑定 && LC_Observer & LC_Binder",

                          ] key:___ds2];
    
    [self setDatasource:@[
                          
                          @"Dribbble && Demo",
                          
                          ] key:___ds3];
    
    [self showBarButton:NavigationBarButtonTypeRight system:UIBarButtonSystemItemCamera];
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeRight) {
        
        LC_UIImagePickerViewController * pick = [LC_UIImagePickerViewController viewController];
        pick.pickerType = LCImagePickerTypeCamera;
        
        [self presentViewController:pick animated:YES completion:nil];
        
        pick.imagePickFinishedBlock = ^( LC_UIImagePickerViewController * req ,NSDictionary * imageInfo){
        
            NSLog(@"image = %@",imageInfo);
        
        };
    }
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    TestSubTitleCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[TestSubTitleCell class]];
    
    NSString * titleString = nil;
    
    if (indexPath.section == 0) {
        titleString = LC_DS(___ds1)[indexPath.row];
    }else if (indexPath.section == 1){
        titleString = LC_DS(___ds2)[indexPath.row];
    }else if (indexPath.section == 2){
        titleString = LC_DS(___ds3)[indexPath.row];
    }
    
    NSArray  * titleArray  = [titleString componentsSeparatedByString:@"&&"];

    
    [cell setTitle:titleArray[0]
          subTitle:titleArray[1]];
    
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(LC_UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [LC_DS(___ds1) count];
    }else if (section == 1){
        return [LC_DS(___ds2) count];
    }else if (section == 2){
        return [LC_DS(___ds3) count];
    }

    return 0;
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

-(float) tableView:(LC_UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"基础控件";
    }
    else if (section == 1) {
        return @"功能";
    }
    else if (section == 2){
        return @"例子";
    }
    
    return @"";
}

-(void) tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            [self.navigationController pushViewController:[[TestNavigationController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        }
        else if (indexPath.row == 1) {
            
            [self.navigationController pushViewController:[[TestPullLoadingViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        }
        else if (indexPath.row == 2) {
            
            LC_UIWebViewController * webView = [[[LC_UIWebViewController alloc] initWithAddress:@"http://nsobject.me"] autorelease];
            [webView hiddenBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:webView animated:YES];
        }
        else if (indexPath.row == 3){
            
            [self.navigationController pushViewController:[[TestLabelViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        }
        else if (indexPath.row == 4){
            
            [LC_UINavigationNotificationView notifyWithText:@"LCFramework" detail:@"titm@tom.com" image:[UIImage imageNamed:@"MS_loading-1.png" useCache:NO] andDuration:3];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }else if (indexPath.row == 5){
            
            [self.navigationController pushViewController:[[TestBadgeViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        }
        else if (indexPath.row == 6){
            
            [self.navigationController pushViewController:[[TestURLImageViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];

        }else if (indexPath.row == 7){
        
            [self.navigationController pushViewController:[[TestAlertViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];

        }else if (indexPath.row == 8){
        
            [self.navigationController pushViewController:[[TestHudViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        
        }else if (indexPath.row == 9){
        
            [self.navigationController pushViewController:[[TestAnimationViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        
        }else if (indexPath.row == 10){
        
            [self showSideMenu];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        }else if (indexPath.row == 11){
            
            [LC_UITopNotificationView showInView:self.view style:LCTopNotificationViewTypeError message:@"LCFramework Test LC_UITopNotificationView."];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];

        }

    }
    
    else if (indexPath.section == 1){
    
        if (indexPath.row == 0 ) {
            
            [self.navigationController pushViewController:[[TestHTTPRequestViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
            
        }else if (indexPath.row == 1){
        
            [self.navigationController pushViewController:[[TestCrashReportViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];

        }else if (indexPath.row == 2){
        
            [self.navigationController pushViewController:[[TestSystemInfoViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        
        }
    
    }
    
    else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            [self.navigationController pushViewController:[[DRMainViewController viewController] hiddenBottomBarWhenPushed:YES] animated:YES];
        }
    }
}

-(void) showSideMenu
{
    static const LC_UISideMenu * menu = nil;
    
    if (!menu) {
    
        
        LC_UISideMenuItem * item = [[LC_UISideMenuItem alloc] initWithTitle:@"首页" action:^(LC_UISideMenu * menu ,LC_UISideMenuItem * item){
            
            [menu hide];
            
        }];
        
        LC_UISideMenuItem * item1 = [[LC_UISideMenuItem alloc] initWithTitle:@"动态" action:^(LC_UISideMenu * menu ,LC_UISideMenuItem * item){
            
            [menu hide];
            
        }];
        
        LC_UISideMenuItem * item2 = [[LC_UISideMenuItem alloc] initWithTitle:@"个人中心" action:^(LC_UISideMenu * menu ,LC_UISideMenuItem * item){
            
            [menu hide];
            
        }];
        
        LC_UISideMenuItem * item3 = [[LC_UISideMenuItem alloc] initWithTitle:@"系统设置" action:^(LC_UISideMenu * menu ,LC_UISideMenuItem * item){
            
            [menu hide];
            
        }];
        
        
        
        menu = [[LC_UISideMenu alloc] initWithItems:@[item,item1,item2,item3]];
        
        LC_RELEASE(item);
        LC_RELEASE(item1);
        LC_RELEASE(item2);
        LC_RELEASE(item3);
    
    }
    
    [menu show];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
