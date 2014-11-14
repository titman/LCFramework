//
//  LC_UITableViewCell.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-20.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UITableViewCell : UITableViewCell

@property(nonatomic,retain) NSIndexPath * cellIndexPath;
@property(nonatomic,assign) LC_UITableView * tableView;
@property(nonatomic,assign) UIColor * selectedViewColor;

@end
