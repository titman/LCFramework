//
//  LC_UITableView.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-20.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

typedef void (^LCTableViewTapBlock) ();
typedef void (^LCTableViewWillReloadBlock) ();

@class LC_UITableViewCell;

@interface LC_UITableView : UITableView

@property(nonatomic,copy) LCTableViewTapBlock tapBlock;
@property(nonatomic,copy) LCTableViewWillReloadBlock willReloadBlock;

- (void)scrollToBottomAnimated:(BOOL)animated;

// it will call cell's - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
-(id) autoCreateDequeueReusableCellWithIdentifier:(NSString *)identifier andClass:(Class)cellClass;

// it will call cell's - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
-(id) autoCreateDequeueReusableCellWithIdentifier:(NSString *)identifier
                                         andClass:(Class)cellClass
                                configurationCell:(void (^)(id configurationCell))configurationCell;

// 辅助 优化Group型TableView的选择背景为圆角
+ (void)roundCornersForSelectedBackgroundViewForGroupTableView:(UITableView *)tableView cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
