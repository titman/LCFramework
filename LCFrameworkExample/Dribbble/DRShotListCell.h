//
//  DRShotListCell.h
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_UITableViewCell.h"

@class SHOT;

@interface DRShotListCell : LC_UITableViewCell

@property(nonatomic,assign) SHOT * shot;
@property(nonatomic,assign) SHOT * shotOther;

@end
