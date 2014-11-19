//
//  DRModelShotList.h
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_Model.h"

@interface DRModelShotList : LC_Model

LC_ST_SIGNAL(DRModelShotListLoadFinished);
LC_ST_SIGNAL(DRModelShotListLoadFailed);

@property (nonatomic, retain) NSMutableArray *	shots;

-(void) goToPage:(NSInteger)page;

@end
