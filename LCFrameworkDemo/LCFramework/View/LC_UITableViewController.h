//
//  LC_UITableViewController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-20.
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

#import <UIKit/UIKit.h>
#import "LC_UIPullLoader.h"

@interface LC_UITableViewController : LC_UIViewController <UITableViewDataSource,UITableViewDelegate>

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
