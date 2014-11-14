//  LC_Thread.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Thread.h"

#define OPERATION_COUNT 5

@implementation LC_ThreadQueue

-(instancetype) init
{
    LC_SUPER_INIT({
      
        self.maxConcurrentOperationCount = OPERATION_COUNT;
        
    })
}

+(BOOL) cancelWithTagString:(NSString *)tagString
{
    LC_Thread * thread = [LC_ThreadQueue threadWithTagString:tagString];
    
    if (thread) {
        [thread cancel];
        return YES;
    }
    
    return NO;
}

+(LC_Thread *) threadWithTagString:(NSString *)tagString
{
    NSArray * operations = [LC_ThreadQueue LCInstance].operations;
    
    for (LC_Thread * thread in operations) {
        
        if (!LC_NSSTRING_IS_INVALID(thread.tagString)) {
            
            if ([thread.tagString isEqualToString:tagString]) {
                return thread;
            }
        }
    }
    
    return nil;
}

@end

@implementation LC_Thread

-(void) dealloc
{
    self.operationBlock = nil;
    self.operationCompleteBlock = nil;
    
    [_tagString release];
    [_object release];
    
    [super dealloc];
}

+(LC_Thread *) performOperationBlockInBackground:(LCOperationBlock)block completeBlock:(LCOperationCompleteBlock)completeBlock
{
    LC_Thread * thread = [[LC_Thread alloc] initWithOperationBlock:block completeBlock:completeBlock];
    
    [[LC_ThreadQueue LCInstance] addOperation:thread];

    return [thread autorelease];
}

-(LC_Thread *) initWithOperationBlock:(LCOperationBlock)block completeBlock:(LCOperationCompleteBlock)completeBlock
{
    LC_SUPER_INIT({
        
        self.operationBlock = block;
        self.operationCompleteBlock = completeBlock;
        self.object = nil;
        self.tagString = nil;
    })
}

-(void) main
{
    if (self.operationBlock) {
        self.operationBlock();
    }else{
        ERROR(@"LC_Thread not found 'operationBlock'.");
    }
    
    if (self.operationCompleteBlock) {
        
        [LC_GCD dispatchAsyncInMainQueue:^{
           
            self.operationCompleteBlock();
            
        }];
    }
}

@end
