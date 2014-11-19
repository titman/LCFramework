//
//  LC_HTTPInterface.h
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC_HTTPInterface : NSObject

@property (nonatomic, copy) NSString * url;
@property (nonatomic, retain) NSMutableDictionary * parameters;

+(instancetype) interface;

typedef LC_HTTPInterface * (^LCHTTPInterfaceRequestBlock)();
typedef LC_HTTPInterface * (^LCHTTPRequestPostBlock)();

@property (nonatomic, readonly) LCHTTPInterfaceRequestBlock  REQUEST;
@property (nonatomic, readonly) LCHTTPRequestPostBlock	     POST;
@property (nonatomic, readonly) LCHTTPRequestPostBlock	     POST;

receiver

-(void) request;
-(void) post;


@end
