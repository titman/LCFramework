//
//  LC_SystemInfoViewer.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-9.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_SystemInfoViewer.h"

#define ___ds1 @"datasource"

@interface LC_SystemInfoViewer ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LC_SystemInfoViewer

-(void) dealloc
{
    LC_RDS(___ds1);
    LC_SUPER_DEALLOC();
}

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        
        [self setDatasource:[LC_SystemInfo deviceDetailInfo] key:___ds1];
        
        self.delegate = self;
        self.dataSource = self;
        
        if (!LC_DS(___ds1)) {
            [LC_UIAlertView showMessage:@"未知设备" cancelTitle:@"知道了"];
        }
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LC_DS(___ds1) allKeys] count] + 1;
}

- (UITableViewCell *)tableView:(LC_UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LC_UITableViewCell * cell = [tableView autoCreateDequeueReusableCellWithIdentifier:@"cell" andClass:[LC_UITableViewCell class]];
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"CLOSE";
        cell.detailTextLabel.text = @"";
        
    }else{
        
        NSString * key = [LC_DS(___ds1) allKeysSelectKeyAtIndex:indexPath.row-1];
        
        cell.textLabel.text = key;
        cell.detailTextLabel.text = [LC_DS(___ds1) objectForKey:key];;
        
    }
    

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
