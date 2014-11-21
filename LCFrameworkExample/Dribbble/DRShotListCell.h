//
//  DRShotListCell.h
//  LCFrameworkExample
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UITableViewCell.h"

@class SHOT;

@interface DRShotListCell : LC_UITableViewCell

@property(nonatomic,assign) SHOT * shot;
@property(nonatomic,assign) SHOT * shotOther;

@end
