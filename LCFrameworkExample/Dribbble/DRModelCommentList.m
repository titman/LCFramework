//
//  DRModelCommentList.m
//  LCFrameworkExample
//
//  Created by Licheng Guo . http://nsobject.me/ on 14/11/24.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRModelCommentList.h"
#import "DRShotsListData.h"

#define PER_PAGE	(20)

@implementation DRModelCommentList

LC_IMP_SIGNAL(DRModelCommentListLoadFinished);
LC_IMP_SIGNAL(DRModelCommentListLoadFailed);

-(void) dealloc
{
    [_id release];
    [_comments release];
    
    [super dealloc];
}

-(void) goToPage:(NSInteger)page
{
    [self.modelInterface cancelRequests];
    
    self.modelInterface.url = [LC_API LCInstance].url.APPEND(@"shots/%@/comments",self.id);
    
    self.modelInterface.parameters.APPEND(@"per_page",@(PER_PAGE));
    self.modelInterface.parameters.APPEND(@"page",@(page));
    
    self.modelInterface.REQUEST();
    
    LC_BLOCK_SELF;
    
    self.modelInterface.UPDATE = ^( LC_HTTPRequest * request ){
        
        if (request.succeed) {
            
            id result = [COMMENT objectsFromArray:request.jsonData[@"comments"]];
            
            if (page == 1) {
                nRetainSelf.comments = result;
            }
            else{
                [nRetainSelf.comments addObjectsFromArray:result];
            }
            
            [nRetainSelf sendUISignal:self.DRModelCommentListLoadFinished];
        }
        else if(request.failed){
            
            [nRetainSelf sendUISignal:self.DRModelCommentListLoadFailed];
        }
        else if (request.cancelled){
            
        }
    };
}

@end
