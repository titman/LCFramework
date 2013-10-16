//
//  LC_HTTPRequest.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "LC_Precompile.h"

@class LC_HTTPRequest;

typedef void				(^LCHTTPRequestBlock)( LC_HTTPRequest * req );
typedef LC_HTTPRequest *	(^LCHTTPRequestBlockV)( void );
typedef LC_HTTPRequest *	(^LCHTTPRequestBlockT)( NSTimeInterval interval );
typedef LC_HTTPRequest *	(^LCHTTPRequestBlockN)( id key, ... );
typedef LC_HTTPRequest *	(^LCHTTPRequestBlockS)( NSString * string );
typedef LC_HTTPRequest *	(^LCHTTPRequestBlockSN)( NSString * string, ... );
typedef BOOL				(^LCHTTPBoolBlockS)( NSString * url );
typedef BOOL				(^LCHTTPBoolBlockV)( void );

typedef enum _LC_HTTP_REQUEST_STATE {
    
    STATE_CREATED    = 0,
    STATE_SENDING    = 1,
	STATE_RECVING    = 2,
    STATE_FAILED     = 3,
    STATE_SUCCEED    = 4,
    STATE_CANCELLED  = 5,
    STATE_REDIRECTED = 6
    
} LC_HTTP_REQUEST_STATE;

@interface LC_HTTPRequest : ASIFormDataRequest

@property (nonatomic, readonly) LCHTTPRequestBlockN	    HEADER;	// directly set header
@property (nonatomic, readonly) LCHTTPRequestBlockN	    BODY;	// directly set body
@property (nonatomic, readonly) LCHTTPRequestBlockN	    PARAM;	// add key value
@property (nonatomic, readonly) LCHTTPRequestBlockN	    FILE;	// add file data
@property (nonatomic, readonly) LCHTTPRequestBlockN	    FILE_ALIAS;
@property (nonatomic, readonly) LCHTTPRequestBlockT   	TIMEOUT;	// add file data

@property (nonatomic, assign) NSUInteger				state;
@property (nonatomic, retain) NSMutableArray *			responders;
//@property (nonatomic, assign) id						responder;

@property (nonatomic, assign) NSInteger					errorCode;
@property (nonatomic, retain) NSMutableDictionary *		userInfo;

@property (nonatomic, copy) LCHTTPRequestBlock			whenUpdate;

@property (nonatomic, assign) NSTimeInterval			initTimeStamp;
@property (nonatomic, assign) NSTimeInterval			sendTimeStamp;
@property (nonatomic, assign) NSTimeInterval			recvTimeStamp;
@property (nonatomic, assign) NSTimeInterval			doneTimeStamp;

@property (nonatomic, readonly) NSTimeInterval			timeCostPending;	// 排队等待耗时
@property (nonatomic, readonly) NSTimeInterval			timeCostOverDNS;	// 网络连接耗时（DNS）
@property (nonatomic, readonly) NSTimeInterval			timeCostRecving;	// 网络收包耗时
@property (nonatomic, readonly) NSTimeInterval			timeCostOverAir;	// 网络整体耗时

@property (nonatomic, readonly) BOOL					created;
@property (nonatomic, readonly) BOOL					sending;
@property (nonatomic, readonly) BOOL					recving;
@property (nonatomic, readonly) BOOL					failed;
@property (nonatomic, readonly) BOOL					succeed;
@property (nonatomic, readonly) BOOL					cancelled;
@property (nonatomic, readonly) BOOL					redirected;
@property (nonatomic, readonly) BOOL					sendProgressed;
@property (nonatomic, readonly) BOOL					recvProgressed;

@property (nonatomic, readonly) CGFloat					uploadPercent;
@property (nonatomic, readonly) NSUInteger				uploadBytes;
@property (nonatomic, readonly) NSUInteger				uploadTotalBytes;

@property (nonatomic, readonly) CGFloat					downloadPercent;
@property (nonatomic, readonly) NSUInteger				downloadBytes;
@property (nonatomic, readonly) NSUInteger				downloadTotalBytes;

@property (nonatomic, readonly) id jsonData;

- (BOOL)is:(NSString *)url;
- (void)changeState:(NSUInteger)state;

- (BOOL)hasResponder:(id)responder;
- (void)addResponder:(id)responder;
- (void)removeResponder:(id)responder;
- (void)removeAllResponders;

- (void)callResponders;
- (void)forwardResponder:(NSObject *)obj;

- (void)updateSendProgress;
- (void)updateRecvProgress;



@end

#pragma mark -

@interface LC_EmptyRequest : LC_HTTPRequest

@end
