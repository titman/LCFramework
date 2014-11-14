//
//  LC_SQLite.h
//  LCFrameworkExample
//
//  Created by CBSi-Leer on 14-3-12.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^LCSQLiteUpdateCompleteBlock)(BOOL complete);
typedef void (^LCSQLiteQueryCompleteBlock)(FMResultSet * result);


@interface LC_SQLite : FMDatabase

/* Default is YES */
@property(nonatomic, assign) BOOL asynchronousPerform;
@property(nonatomic,retain) LC_ThreadQueue * queue;


- (void) executeUpdate:(NSString*)sql completeBlock:(LCSQLiteUpdateCompleteBlock)block;

- (void) executeQuery:(NSString*)sql completeBlock:(LCSQLiteQueryCompleteBlock)block;


@end
