//
//  DRShotDetailViewController.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-23.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRShotDetailViewController.h"
#import "DRModelCommentList.h"
#import "DRShotsListData.h"
#import "DRShotDetailHeader.h"
#import "DRShotCommentCell.h"

@interface DRShotDetailViewController ()
{
    NSInteger _page;
}

@property(nonatomic,retain) DRModelCommentList * listModel;
@property(nonatomic,retain) SHOT * shot;

@end

@implementation DRShotDetailViewController

-(void) dealloc
{
    [_listModel release];
    [_shot release];
    
    LC_SUPER_DEALLOC();
}

-(instancetype) initWithShot:(SHOT *)shot
{
    LC_SUPER_INIT({
        
        self.shot = shot;
    })
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.shot.title;
    
    [self showBarButton:NavigationBarButtonTypeLeft
                  title:@""
                  image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
            selectImage:nil];
    
    
    
    self.listModel = [[[DRModelCommentList alloc] init] autorelease];
    self.listModel.id = self.shot.id;
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
    
    
    DRShotDetailHeader * header = DRShotDetailHeader.view;
    header.shot = self.shot;
    
    self.tableView.tableHeaderView = header;
}

LC_HANDLE_SIGNAL(DRModelCommentListLoadFinished)
{
    [self.pullLoader endRefresh];
    [self reloadData];
}

LC_HANDLE_SIGNAL(DRModelCommentListLoadFailed)
{
    [self.pullLoader endRefresh];
    [self showMessageHud:@"加载失败..."];
}

#pragma mark -

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRShotCommentCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[DRShotCommentCell class]];
    
    cell.cellIndexPath = indexPath;
    
    cell.comment = self.listModel.comments[indexPath.row];
    
    return cell;
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    COMMENT * comment = self.listModel.comments[indexPath.row];
    
    CGSize size = [comment.body sizeWithFont:[UIFont systemFontOfSize:14] byWidth:LC_DEVICE_WIDTH - 55];

    float height = size.height < 40 ? 40 : size.height;
    
    return height + 29.f;
}

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.comments.count;
}

#pragma mark -

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
