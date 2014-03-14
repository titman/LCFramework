//
//  LC_HTTPRequestQueue.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"

#pragma mark -

@interface LC_HTTPRequestQueue : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, assign) BOOL						merge;
@property (nonatomic, assign) BOOL						online;				// 开网/断网

@property (nonatomic, assign) BOOL						blackListEnable;	// 是否使用黑名单
@property (nonatomic, assign) NSTimeInterval			blackListTimeout;	// 黑名单超时
@property (nonatomic, retain) NSMutableDictionary *		blackList;

@property (nonatomic, assign) NSUInteger				bytesUpload;
@property (nonatomic, assign) NSUInteger				bytesDownload;

@property (nonatomic, assign) NSTimeInterval			delay;
@property (nonatomic, retain) NSMutableArray *			requests;

@property (nonatomic, copy) LCHTTPRequestBlock			whenCreate;
@property (nonatomic, copy) LCHTTPRequestBlock			whenUpdate;

+ (LC_HTTPRequestQueue *) sharedInstance;

+ (BOOL)isReachableViaWIFI;
+ (BOOL)isReachableViaWLAN;
+ (BOOL)isNetworkInUse;
+ (NSUInteger)bandwidthUsedPerSecond;

+ (LC_HTTPRequest *)GET:(NSString *)url;
+ (LC_HTTPRequest *)POST:(NSString *)url;
+ (LC_HTTPRequest *)PUT:(NSString *)url;

+ (BOOL)requesting:(NSString *)url;
+ (BOOL)requesting:(NSString *)url byResponder:(id)responder;

+ (NSArray *)requests:(NSString *)url;
+ (NSArray *)requests:(NSString *)url byResponder:(id)responder;

+ (void)cancelRequest:(LC_HTTPRequest *)request;
+ (void)cancelRequestByResponder:(id)responder;
+ (void)cancelAllRequests;

+ (void)blockURL:(NSString *)url;
+ (void)unblockURL:(NSString *)url;


@end
