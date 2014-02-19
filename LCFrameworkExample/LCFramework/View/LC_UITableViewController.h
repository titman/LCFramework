//
//  LC_UITableViewController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-20.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>
#import "LC_UIPullLoader.h"

@interface LC_UITableViewController : LC_UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) UITableViewStyle initTableViewStyle;
@property (nonatomic,assign) LC_UITableView * tableView;
@property (nonatomic,retain) LC_UIPullLoader * pullLoader;

// 调用该函数来设置上下拉刷新
-(void) setPullStyle:(LC_PULL_STYLE)pullStyle
     backgroundStyle:(LC_PULL_BACK_GROUND_STYLE)backgroundStyle
   beginRefreshBlock:(LCUIPulldidRefreshBlock)beginRefreshBlock;

// 主线程刷新数据
- (void) reloadData;

// 继承该类 实现下列方法
-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(float) tableView:(LC_UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
-(float) tableView:(LC_UITableView *)tableView heightForFooterInSection:(NSInteger)section;
-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(NSInteger) numberOfSectionsInTableView:(LC_UITableView *)tableView;

-(void) tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;




@end
