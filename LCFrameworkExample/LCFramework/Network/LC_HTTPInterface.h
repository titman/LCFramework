//
//  LC_HTTPInterface.h
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _LCHTTPRequestState{
    
    LCHTTPRequestStateFinish = 0,
    LCHTTPRequestStateFail = 1,
    LCHTTPRequestStateNoNetwork = 2,
    LCHTTPRequestStateCancel = 3,
    LCHTTPRequestStateUpdate = 4,
    
}LCHTTPRequestState;


#pragma mark -


@interface LC_HTTPInterfaceResult : NSObject

@property(nonatomic,assign) LCHTTPRequestState state;
@property(nonatomic,assign) NSInteger errorCode;
@property(nonatomic,retain) NSString * errorMessage;
@property(nonatomic,retain) id json;

+(instancetype) result;

@end

#pragma mark -

@interface LC_HTTPInterface : NSObject

@property (nonatomic, copy)   NSString * url;
@property (nonatomic, retain) NSMutableDictionary * parameters;

+(instancetype) interface;

typedef LC_HTTPInterface * (^LCHTTPInterfaceRequestBlock)();
typedef LC_HTTPInterface * (^LCHTTPRequestPostBlock)();
typedef void (^LCHTTPRequestUpdateBlock)(LC_HTTPRequest * request);

@property (nonatomic, readonly) LCHTTPInterfaceRequestBlock  REQUEST;
@property (nonatomic, readonly) LCHTTPRequestPostBlock	     POST;
@property (nonatomic, copy)     LCHTTPRequestUpdateBlock	 UPDATE;

-(void) request;
-(void) post;


@end
