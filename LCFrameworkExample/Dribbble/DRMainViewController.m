//
//  DRMainViewController.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRMainViewController.h"
#import "DRModelShotList.h"
#import "DRShotListCell.h"
#import "DRShotDetailViewController.h"

@interface DRMainViewController ()
{
    NSInteger _page;
}

@property(nonatomic,retain) DRModelShotList * listModel;


@end

@implementation DRMainViewController

-(void) dealloc
{
    self.listModel = nil;
    
    LC_SUPER_DEALLOC();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Dribbble";

    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    
    
    [LC_API LCInstance].url = @"http://api.dribbble.com/";
    
    self.listModel = [[[DRModelShotList alloc] init] autorelease];
    [self.listModel addObserver:self];
    
    
    LC_BLOCK_SELF;
    
    [self setPullStyle:LC_PULL_STYLE_HEADER_AND_FOOTER backgroundStyle:LC_PULL_BACK_GROUND_STYLE_CUSTOM beginRefreshBlock:^(LC_UIPullLoader *pull, LC_PULL_DIRETION diretion) {
       
        if (diretion == LC_PULL_DIRETION_TOP) {
            
            nRetainSelf->_page = 1;
        }else{
            nRetainSelf->_page += 1;
        }
        
        [nRetainSelf.listModel goToPage:nRetainSelf->_page];
        
    }];
    
    [self.pullLoader performSelector:@selector(startRefresh) withObject:nil afterDelay:0.25];
    
}

LC_HANDLE_SIGNAL(DRModelShotListLoadFinished){
    
    [self reloadData];
    [self.pullLoader endRefresh];
}

LC_HANDLE_SIGNAL(DRModelShotListLoadFailed){
    
    [self.pullLoader endRefresh];
    [self showMessageHud:@"加载失败..."];
}

LC_HANDLE_SIGNAL(DRShotListCellDetailAction){

    NSArray * tag = [((UIView *)signal.source).tagString componentsSeparatedByString:@"-"];
    
    NSInteger row = [tag[0] integerValue];
    NSInteger index = [tag[1] integerValue];
    
    SHOT * data = self.listModel.shots[row + index];
    
    NSLog(@"Data : %@",data);
    NSLog(@"Index : %d",row + index);
    
    //DRShotDetailViewController * detail = [DRShotDetailViewController viewController];
    //detail.shot = data;
    //[self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -


-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRShotListCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[DRShotListCell class]];
    
    cell.cellIndexPath = indexPath;
    
    NSInteger index = indexPath.row * 2;
    
    cell.shot = self.listModel.shots[index];
    
    NSInteger remainder = self.listModel.shots.count % 2;

    if (!remainder) {
        cell.shotOther = self.listModel.shots[index + 1];
    }

    return cell;
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150 + (LC_DEVICE_WIDTH - (150 * 2))/3;
}

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger remainder = self.listModel.shots.count % 2;
    
    return remainder ? self.listModel.shots.count/2 + 1 : self.listModel.shots.count/2;
}

#pragma mark -

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
