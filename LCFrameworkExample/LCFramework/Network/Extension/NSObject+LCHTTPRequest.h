//
//  NSObject+LCHTTPRequest.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_HTTPRequest.h"

@interface NSObject (LCHTTPRequest)

@property (nonatomic, readonly) LCHTTPBoolBlockV		REQUESTING;
@property (nonatomic, readonly) LCHTTPBoolBlockS		REQUESTING_URL;
@property (nonatomic, readonly) LCHTTPBoolBlockV		CANCEL_REQUESTS;

@property (nonatomic, readonly) LCHTTPRequestBlockSN	GET;
@property (nonatomic, readonly) LCHTTPRequestBlockSN	PUT;
@property (nonatomic, readonly) LCHTTPRequestBlockSN	POST;

@property (nonatomic, readonly) LCHTTPRequestBlockSN	HTTP_GET;
@property (nonatomic, readonly) LCHTTPRequestBlockSN	HTTP_PUT;
@property (nonatomic, readonly) LCHTTPRequestBlockSN	HTTP_POST;

- (LC_HTTPRequest *)GET:(NSString *)url;
- (LC_HTTPRequest *)PUT:(NSString *)url;
- (LC_HTTPRequest *)POST:(NSString *)url;

- (LC_HTTPRequest *)HTTP_GET:(NSString *)url;
- (LC_HTTPRequest *)HTTP_PUT:(NSString *)url;
- (LC_HTTPRequest *)HTTP_POST:(NSString *)url;

- (BOOL)isRequestResponder;
- (BOOL)requestingURL;
- (BOOL)requestingURL:(NSString *)url;
- (NSArray *)requests;
- (NSArray *)requests:(NSString *)url;
- (void)cancelRequests;

- (BOOL)prehandleRequest:(LC_HTTPRequest *)request;
- (void)posthandleRequest:(LC_HTTPRequest *)request;
- (void)handleRequest:(LC_HTTPRequest *)request;

@end
