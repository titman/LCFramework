//  LC_Thread.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>

#pragma mark -

@class LC_Thread;

@interface LC_ThreadQueue : NSOperationQueue

+(BOOL) cancelWithTagString:(NSString *)tagString;

+(LC_Thread *) threadWithTagString:(NSString *)tagString;

@end

#pragma mark -

typedef void (^LCOperationBlock) ();
typedef void (^LCOperationCompleteBlock) ();

#pragma mark -

@interface LC_Thread : NSOperation

@property(nonatomic,copy) LCOperationBlock operationBlock;
@property(nonatomic,copy) LCOperationCompleteBlock operationCompleteBlock;
@property(nonatomic,retain) id object;
@property(nonatomic,retain) NSString * tagString;

+(LC_Thread *) performOperationBlockInBackground:(LCOperationBlock)block completeBlock:(LCOperationCompleteBlock)completeBlock;

-(LC_Thread *) initWithOperationBlock:(LCOperationBlock)block completeBlock:(LCOperationCompleteBlock)completeBlock;

@end
