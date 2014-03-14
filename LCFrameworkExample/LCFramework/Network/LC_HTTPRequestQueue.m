//
//  LC_HTTPRequestQueue.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_HTTPRequestQueue.h"

#pragma mark -

#undef	DEFAULT_BLACKLIST_TIMEOUT
#define DEFAULT_BLACKLIST_TIMEOUT	(60.0f * 5.0f)	// 黑名单超时5分钟

#undef	DEFAULT_GET_TIMEOUT
#define DEFAULT_GET_TIMEOUT			(30.0f)			// 取图30秒超时

#undef	DEFAULT_POST_TIMEOUT
#define DEFAULT_POST_TIMEOUT		(30.0f)			// 发协议30秒超时

#undef	DEFAULT_PUT_TIMEOUT
#define DEFAULT_PUT_TIMEOUT			(30.0f)			// 上传30秒超时

#undef	DEFAULT_UPLOAD_TIMEOUT
#define DEFAULT_UPLOAD_TIMEOUT		(120.0f)		// 上传图片120秒超时

#pragma mark -

@interface LC_HTTPRequestQueue()
{
	BOOL					_merge;
	BOOL					_online;
	
	BOOL					_blackListEnable;
	NSTimeInterval			_blackListTimeout;
	NSMutableDictionary *	_blackList;
	
	NSUInteger				_bytesUpload;
	NSUInteger				_bytesDownload;
	
	NSTimeInterval			_delay;
	NSMutableArray *		_requests;
	
	LCHTTPRequestBlock		_whenCreate;
	LCHTTPRequestBlock		_whenUpdate;
}

- (BOOL)checkResourceBroken:(NSString *)url;

- (LC_HTTPRequest *)GET:(NSString *)url sync:(BOOL)sync;
- (LC_HTTPRequest *)POST:(NSString *)url sync:(BOOL)sync;
- (LC_HTTPRequest *)PUT:(NSString *)url sync:(BOOL)sync;

- (void)cancelRequest:(LC_HTTPRequest *)request;
- (void)cancelRequestByResponder:(id)responder;
- (void)cancelAllRequests;

- (void)blockURL:(NSString *)url;
- (void)unblockURL:(NSString *)url;

- (BOOL)requesting:(NSString *)url;
- (BOOL)requesting:(NSString *)url byResponder:(id)responder;

- (NSArray *)requests:(NSString *)url;
- (NSArray *)requests:(NSString *)url byResponder:(id)responder;

@end

#pragma mark -


@implementation LC_HTTPRequestQueue

+(LC_HTTPRequestQueue *) sharedInstance
{
    static dispatch_once_t once; 
    static LC_HTTPRequestQueue * __singleton__; 
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); 
    return __singleton__;
}

@synthesize merge = _merge;
@synthesize online = _online;

@synthesize	blackListEnable = _blackListEnable;
@synthesize	blackListTimeout = _blackListTimeout;
@synthesize	blackList = _blackList;

@synthesize bytesUpload = _bytesUpload;
@synthesize bytesDownload = _bytesDownload;

@synthesize delay = _delay;
@synthesize requests = _requests;

@synthesize whenCreate = _whenCreate;
@synthesize whenUpdate = _whenUpdate;

+ (BOOL)isReachableViaWIFI
{
	return YES;
}

+ (BOOL)isReachableViaWLAN
{
	return YES;
}

+ (BOOL)isNetworkInUse
{
	return ([[LC_HTTPRequestQueue sharedInstance].requests count] > 0) ? YES : NO;
}

+ (NSUInteger)bandwidthUsedPerSecond
{
	return [ASIHTTPRequest averageBandwidthUsedPerSecond];
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		_delay = 0.01f;
		_merge = YES;
		_online = YES;
		_requests = [[NSMutableArray alloc] init];
        
		_blackListEnable = NO;
		_blackListTimeout = DEFAULT_BLACKLIST_TIMEOUT;
		_blackList = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)setOnline:(BOOL)en
{
	_online = en;
    
	if ( NO == _online )
	{
		[self cancelAllRequests];
	}
}

- (void)dealloc
{
	[self cancelAllRequests];
    
	[_requests removeAllObjects];
	[_requests release];
    
	[_blackList removeAllObjects];
	[_blackList release];
	
	self.whenCreate = nil;
	self.whenUpdate = nil;
    
	[super dealloc];
}

- (BOOL)checkResourceBroken:(NSString *)url
{
	if ( _blackListEnable )
	{
		NSDate * date = nil;
		NSDate * now = [NSDate date];
		
		date = [_blackList objectForKey:url];
		if ( date && ([date timeIntervalSince1970] - [now timeIntervalSince1970]) < _blackListTimeout )
		{
			NSLog( @"resource broken: %@", url );
			return YES;
		}
	}
    
	return NO;
}

+ (LC_HTTPRequest *)GET:(NSString *)url
{
	return [[LC_HTTPRequestQueue sharedInstance] GET:url sync:NO];
}

- (LC_HTTPRequest *)GET:(NSString *)url sync:(BOOL)sync
{
	LC_HTTPRequest * request = nil;
    
	if ( NO == sync && _merge )
	{
		for ( LC_HTTPRequest * req in _requests )
		{
			if ( [req.url.absoluteString isEqualToString:url] )
			{
				return req;
			}
		}
	}
    
	NSURL * absoluteURL = [NSURL URLWithString:url];
    
	if ( NO == _online || [self checkResourceBroken:url] )
	{
		request = [[[LC_EmptyRequest alloc] initWithURL:absoluteURL] autorelease];
	}
	else
	{
		request = [[LC_HTTPRequest alloc] initWithURL:absoluteURL];
	}
    
	request.timeOutSeconds = DEFAULT_GET_TIMEOUT;
	request.requestMethod = @"GET";
	request.postBody = nil;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    
	[request setNumberOfTimesToRetryOnTimeout:2];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif	// #if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    
	[request setThreadPriority:0.5];
	[request setQueuePriority:NSOperationQueuePriorityLow];
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
    
	return [request autorelease];
}

+ (LC_HTTPRequest *)POST:(NSString *)url
{
	return [[LC_HTTPRequestQueue sharedInstance] POST:url sync:NO];
}

- (LC_HTTPRequest *)POST:(NSString *)url sync:(BOOL)sync
{
	LC_HTTPRequest * request = nil;
	
	NSURL * absoluteURL = [NSURL URLWithString:url];
	
	if ( NO == _online )
	{
		request = [[[LC_EmptyRequest alloc] initWithURL:absoluteURL] autorelease];
	}
	else
	{
		request = [[LC_HTTPRequest alloc] initWithURL:absoluteURL];
	}
	
	request.timeOutSeconds = DEFAULT_POST_TIMEOUT;
	request.requestMethod = @"POST";
	request.postFormat = ASIMultipartFormDataPostFormat; // ASIRawPostFormat;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
	[request setNumberOfTimesToRetryOnTimeout:2];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif	// #if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
    
	return [request autorelease];
}

+ (LC_HTTPRequest *)PUT:(NSString *)url
{
	return [[LC_HTTPRequestQueue sharedInstance] PUT:url sync:NO];
}

- (LC_HTTPRequest *)PUT:(NSString *)url sync:(BOOL)sync
{
	LC_HTTPRequest * request = nil;
	
	NSURL * absoluteURL = [NSURL URLWithString:url];
	NSLog( @"PUT %@", absoluteURL );
    
	if ( NO == _online )
	{
		request = [[[LC_EmptyRequest alloc] initWithURL:absoluteURL] autorelease];
	}
	else
	{
		request = [[LC_HTTPRequest alloc] initWithURL:absoluteURL];
	}
    
	request.timeOutSeconds = DEFAULT_PUT_TIMEOUT;
	request.requestMethod = @"PUT";
	request.postFormat = ASIURLEncodedPostFormat; // ASIRawPostFormat;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
	[request setNumberOfTimesToRetryOnTimeout:2];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif	// #if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
	
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
	
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
	
	return [request autorelease];
}

+ (BOOL)requesting:(NSString *)url
{
	return [[LC_HTTPRequestQueue sharedInstance] requesting:url];
}

- (BOOL)requesting:(NSString *)url
{
	for ( LC_HTTPRequest * request in _requests )
	{
		if ( [[request.url absoluteString] isEqualToString:url] )
		{
			return YES;
		}
	}
    
	return NO;
}

+ (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
	return [[LC_HTTPRequestQueue sharedInstance] requesting:url byResponder:responder];
}

- (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
	for ( LC_HTTPRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] /*request.responder != responder*/ )
			continue;
        
		if ( nil == url || [[request.url absoluteString] isEqualToString:url] )
		{
			return YES;
		}
	}
    
	return NO;
}

+ (NSArray *)requests:(NSString *)url
{
	return [[LC_HTTPRequestQueue sharedInstance] requests:url];
}

- (NSArray *)requests:(NSString *)url
{
	NSMutableArray * array = [NSMutableArray array];
	
	for ( LC_HTTPRequest * request in _requests )
	{
		if ( [[request.url absoluteString] isEqualToString:url] )
		{
			[array addObject:request];
		}
	}
	
	return array;
}

+ (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	return [[LC_HTTPRequestQueue sharedInstance] requests:url byResponder:responder];
}

- (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	NSMutableArray * array = [NSMutableArray array];
    
	for ( LC_HTTPRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] /* request.responder != responder */ )
			continue;
		
		if ( nil == url || [[request.url absoluteString] isEqualToString:url] )
		{
			[array addObject:request];
		}
	}
    
	return array;
}

+ (void)cancelRequest:(LC_HTTPRequest *)request
{
	[[LC_HTTPRequestQueue sharedInstance] cancelRequest:request];
}

- (void)cancelRequest:(LC_HTTPRequest *)request
{
	[NSObject cancelPreviousPerformRequestsWithTarget:request selector:@selector(startAsynchronous) object:nil];
	
	if ( [_requests containsObject:request] )
	{
		if ( request.created || request.sending || request.recving )
		{
			[request changeState:STATE_CANCELLED];
		}
        
		[request clearDelegatesAndCancel];
		[request removeAllResponders];
        
		[_requests removeObject:request];
	}
}

+ (void)cancelRequestByResponder:(id)responder
{
	[[LC_HTTPRequestQueue sharedInstance] cancelRequestByResponder:responder];
}

- (void)cancelRequestByResponder:(id)responder
{
	if ( nil == responder )
	{
		[self cancelAllRequests];
	}
	else
	{
		NSMutableArray * tempArray = [NSMutableArray array];
		
		for ( LC_HTTPRequest * request in _requests )
		{
			if ( [request hasResponder:responder] /* request.responder == responder */ )
			{
				[tempArray addObject:request];
			}
		}
		
		for ( LC_HTTPRequest * request in tempArray )
		{
			[self cancelRequest:request];
		}
	}
}

+ (void)cancelAllRequests
{
	[[LC_HTTPRequestQueue sharedInstance] cancelAllRequests];
}

- (void)cancelAllRequests
{
	NSMutableArray * allRequests = [NSMutableArray arrayWithArray:_requests];
	
	for ( LC_HTTPRequest * request in allRequests )
	{
		[self cancelRequest:request];
	}
}

+ (void)blockURL:(NSString *)url
{
	[[LC_HTTPRequestQueue sharedInstance] blockURL:url];
}

- (void)blockURL:(NSString *)url
{
	[_blackList setObject:[NSDate date] forKey:url];
}

+ (void)unblockURL:(NSString *)url
{
	[[LC_HTTPRequestQueue sharedInstance] unblockURL:url];
}

- (void)unblockURL:(NSString *)url
{
	if ( [_blackList objectForKey:url] )
	{
		NSDate * date = [NSDate dateWithTimeInterval:(_blackListTimeout + 1.0f) sinceDate:[NSDate date]];
		[_blackList setObject:date forKey:url];
	}
}

- (NSArray *)requests
{
	return _requests;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
    
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest changeState:STATE_SENDING];
    
	_bytesUpload += request.postLength;
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
	
	NSLog( @"%@ %@\n%@",
		 [request requestMethod],
		 [request.url absoluteString],
		 [request.postBody asNSString]);
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
    
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest changeState:STATE_RECVING];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	_bytesDownload += [[request rawResponseData] length];
	
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
    
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	
	NSLog( @"HTTP %d(%@)\n%@\n%@",
         request.responseStatusCode,
         request.responseStatusMessage,
         [request.url absoluteString],
         request.responseString);
    
	if ( [request.requestMethod isEqualToString:@"GET"] )
	{
		if ( request.responseStatusCode >= 400 && request.responseStatusCode < 500 )
		{
			[self blockURL:[request.url absoluteString]];
		}
	}
    
	if ( 200 == request.responseStatusCode )
	{
		[networkRequest changeState:STATE_SUCCEED];
	}
	else
	{
		[networkRequest changeState:STATE_FAILED];
	}
    
	[networkRequest clearDelegatesAndCancel];
	[networkRequest removeAllResponders];
    
	[_requests removeObject:networkRequest];
    
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
    
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
    
	networkRequest.errorCode = -1;
	[networkRequest changeState:STATE_FAILED];
	
	[networkRequest clearDelegatesAndCancel];
	[networkRequest removeAllResponders];
	
	[_requests removeObject:networkRequest];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
	
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest changeState:STATE_REDIRECTED];
}

- (void)requestRedirected:(ASIHTTPRequest *)request
{
	_bytesDownload += [[request rawResponseData] length];
	
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
    
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	
	NSLog( @"HTTP %d(%@)\n%@",
		 request.responseStatusCode,
		 request.responseStatusMessage,
		 [request.url absoluteString] );
    
	if ( [request.requestMethod isEqualToString:@"GET"] )
	{
		if ( request.responseStatusCode >= 400 && request.responseStatusCode < 500 )
		{
			[self blockURL:[request.url absoluteString]];
		}
	}
	
	[networkRequest changeState:STATE_SUCCEED];
	
	[networkRequest clearDelegatesAndCancel];
	[networkRequest removeAllResponders];
	
	[_requests removeObject:networkRequest];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
	[self requestFailed:request];
}

- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
	[self requestFailed:request];
}

#pragma mark -

// Called when the request receives some data - bytes is the length of that data
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
	
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest updateRecvProgress];
}

// Called when the request sends some data
// The first 32KB (128KB on older platforms) of data sent is not included in this amount because of limitations with the CFNetwork API
// bytes may be less than zero if a request needs to remove upload progress (probably because the request needs to run again)
- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
	
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest updateSendProgress];
}

// Called when a request needs to change the length of the content to download
- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
	
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest updateRecvProgress];
}

// Called when a request needs to change the length of the content to upload
// newLength may be less than zero when a request needs to remove the size of the internal buffer from progress tracking
- (void)request:(ASIHTTPRequest *)request incrementUploadSizeBy:(long long)newLength
{
	if ( NO == [request isKindOfClass:[LC_HTTPRequest class]] )
		return;
	
	LC_HTTPRequest * networkRequest = (LC_HTTPRequest *)request;
	[networkRequest updateSendProgress];
}


@end
