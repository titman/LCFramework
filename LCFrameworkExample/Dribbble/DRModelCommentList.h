//
//  DRModelCommentList.h
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/24.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_Model.h"

@interface DRModelCommentList : LC_Model

LC_ST_SIGNAL(DRModelCommentListLoadFinished);
LC_ST_SIGNAL(DRModelCommentListLoadFailed);

@property(nonatomic,copy) NSNumber * id;
@property(nonatomic,retain) NSMutableArray * comments;

-(void) goToPage:(NSInteger)page;

@end
