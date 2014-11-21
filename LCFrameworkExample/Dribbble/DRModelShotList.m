//
//  DRModelShotList.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "DRModelShotList.h"
#import "DRShotsListData.h"

#define PER_PAGE	(30)

@implementation DRModelShotList

LC_IMP_SIGNAL(DRModelShotListLoadFinished);
LC_IMP_SIGNAL(DRModelShotListLoadFailed);

-(void) goToPage:(NSInteger)page
{
    [self.modelInterface cancelRequests];
    
    self.modelInterface.url = [LC_API LCInstance].url.APPEND(@"shots/popular");
    
    self.modelInterface.parameters.APPEND(@"per_page",@(PER_PAGE));
    self.modelInterface.parameters.APPEND(@"page",@(page));
    
    self.modelInterface.REQUEST();
    
    LC_BLOCK_SELF;
    
    self.modelInterface.UPDATE = ^( LC_HTTPRequest * request ){
        
        if (request.succeed) {
            
            id result = [SHOT objectsFromArray:request.jsonData[@"shots"]];
            
            if (page == 1) {
                nRetainSelf.shots = result;
            }
            else{
                [nRetainSelf.shots addObjectsFromArray:result];
            }
            
            [nRetainSelf sendUISignal:DRModelShotList.DRModelShotListLoadFinished];
        }
        else if(request.failed){
         
            [nRetainSelf sendUISignal:DRModelShotList.DRModelShotListLoadFailed];
        }
        else if (request.cancelled){
            
        }
    };
}

@end
