//
//  LC_UITableViewController.m
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

#import "LC_UITableViewController.h"

@interface LC_UITableViewController ()

@end

@implementation LC_UITableViewController

-(void) dealloc
{
    LC_RELEASE_ABSOLUTE(_pullLoader);
    LC_SUPER_DEALLOC();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) init
{
    LC_SUPER_INIT({
    
        ;
        
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
    self.tableView = [[[LC_UITableView alloc] initWithFrame:self.view.bounds style:LC_TABLE_DEFAULT_STYLE] autorelease];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = LC_TABLE_DEFAULT_BACKGROUND_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
}

-(void) setPullStyle:(LC_PULL_STYLE)pullStyle
     backgroundStyle:(LC_PULL_BACK_GROUND_STYLE)backgroundStyle
   beginRefreshBlock:(LCUIPulldidRefreshBlock)beginRefreshBlock
{
    self.pullLoader = [LC_UIPullLoader pullLoaderWithScrollView:self.tableView pullStyle:pullStyle backGroundStyle:backgroundStyle];
    self.pullLoader.beginRefreshBlock = beginRefreshBlock;
}

- (void) reloadData
{
    LC_GCD_SYNCHRONOUS(^{
    
        [self.tableView reloadData];
    
    });
}

-(LC_UITableViewCell *) tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    LC_UITableViewCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[LC_UITableViewCell class]];
    
    cell.textLabel.text = LC_NSSTRING_FORMAT(@"%d",indexPath.row);
    
    return cell;
}

-(float) tableView:(LC_UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(float) tableView:(LC_UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(float) tableView:(LC_UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger) tableView:(LC_UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger) numberOfSectionsInTableView:(LC_UITableView *)tableView
{
    return 1;
}

-(void) tableView:(LC_UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}

- (NSIndexPath *)tableView:(LC_UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [LC_UITableView roundCornersForSelectedBackgroundViewForGroupTableView:tableView
                                                                          cell:[tableView cellForRowAtIndexPath:indexPath]
                                                                     indexPath:indexPath];
    return indexPath;
}

- (NSString *)tableView:(LC_UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return @"";
    
}

- (NSString *)tableView:(LC_UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}


@end
