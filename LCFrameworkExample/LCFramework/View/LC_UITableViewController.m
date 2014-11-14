//
//  LC_UITableViewController.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-20.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

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
    
//    if (self.initTableViewStyle >= 0) {
        self.tableView = [[[LC_UITableView alloc] initWithFrame:self.view.bounds style:self.initTableViewStyle] autorelease];
//    }else{
//        self.tableView = [[[LC_UITableView alloc] initWithFrame:self.view.bounds style:LC_TABLE_DEFAULT_STYLE] autorelease];
//    }
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = LC_TABLE_DEFAULT_BACKGROUND_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
