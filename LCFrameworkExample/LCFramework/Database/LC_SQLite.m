//
//  LC_SQLite.m
//  LCFrameworkExample
//
//  Created by CBSi-Leer on 14-3-12.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_SQLite.h"

@interface LC_SQLite ()

@end

@implementation LC_SQLite

-(void) dealloc
{
    [_queue release];
    
    LC_SUPER_DEALLOC();
}


-(LC_ThreadQueue *) queue
{
    if (!_queue) {
        self.queue = LC_AUTORELEASE([[LC_ThreadQueue alloc] init]);
        self.queue.maxConcurrentOperationCount = 1;
    }
    
    return _queue;
}


- (void) executeUpdate:(NSString*)sql completeBlock:(LCSQLiteUpdateCompleteBlock)block
{
    __block BOOL complete = NO;
    
    if (self.asynchronousPerform) {
     
        LC_Thread * thread = [[LC_Thread alloc] initWithOperationBlock:^{
            
            complete = [self executeUpdate:sql];
            
        } completeBlock:^{
            
            block(complete);
            
        }];
        
        [self.queue addOperation:LC_AUTORELEASE(thread)];
        
    }
    else{
     
        complete = [self executeUpdate:sql];
        block(complete);
        
    }
}


- (void) executeQuery:(NSString*)sql completeBlock:(LCSQLiteQueryCompleteBlock)block
{
    __block FMResultSet * result = nil;
    
    if (self.asynchronousPerform) {

        LC_Thread * thread = [[LC_Thread alloc] initWithOperationBlock:^{
            
            result = [self executeQuery:sql];
            
        } completeBlock:^{
            
            block(result);
            
            
        }];
        
        [self.queue addOperation:LC_AUTORELEASE(thread)];
        
    }
    else{
        
        result = [self executeQuery:sql];
        block(result);
    }

}



@end
