//
//  LC_HTTPRequest.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_HTTPRequest.h"

#pragma mark -

@interface LC_HTTPRequest()
{
	NSUInteger				_state;
	NSMutableArray *		_responders;
    //	id						_responder;
	
	NSInteger				_errorCode;
	NSMutableDictionary *	_userInfo;
	
	BOOL					_sendProgressed;
	BOOL					_recvProgressed;
	LCHTTPRequestBlock		_whenUpdate;
	
	NSTimeInterval			_initTimeStamp;
	NSTimeInterval			_sendTimeStamp;
	NSTimeInterval			_recvTimeStamp;
	NSTimeInterval			_doneTimeStamp;
}

- (void)updateSendProgress;
- (void)updateRecvProgress;
- (void)addFileData:(id)data fileName:(NSString *)name alias:(NSString *)alias;

@end

#pragma mark -

@implementation LC_HTTPRequest

@dynamic HEADER;
@dynamic BODY;
@dynamic PARAM;
@dynamic FILE;
@dynamic TIMEOUT;

@synthesize state = _state;
@synthesize errorCode = _errorCode;
//@synthesize responder = _responder;
@synthesize responders = _responders;
@synthesize userInfo = _userInfo;

@synthesize whenUpdate = _whenUpdate;

@synthesize initTimeStamp = _initTimeStamp;
@synthesize sendTimeStamp = _sendTimeStamp;
@synthesize recvTimeStamp = _recvTimeStamp;
@synthesize doneTimeStamp = _doneTimeStamp;

@synthesize timeCostPending;	// 排队等待耗时
@synthesize timeCostOverDNS;	// 网络连接耗时（DNS）
@synthesize timeCostRecving;	// 网络收包耗时
@synthesize timeCostOverAir;	// 网络整体耗时

@dynamic created;
@dynamic sending;
@dynamic recving;
@dynamic failed;
@dynamic succeed;
//@synthesize cancelled;
@dynamic redirected;

@synthesize sendProgressed = _sendProgressed;
@synthesize recvProgressed = _recvProgressed;

@synthesize uploadPercent;
@synthesize uploadBytes;
@synthesize uploadTotalBytes;
@synthesize downloadPercent;
@synthesize downloadBytes;
@synthesize downloadTotalBytes;

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	if ( self )
	{
		_state = STATE_CREATED;
		_errorCode = 0;
		
		_responders = [[NSMutableArray nonRetainingArray] retain];
		_userInfo = [[NSMutableDictionary alloc] init];
		
		_whenUpdate = nil;
		
		_sendProgressed = NO;
		_recvProgressed = NO;
		
		_initTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		_sendTimeStamp = _initTimeStamp;
		_recvTimeStamp = _initTimeStamp;
		_doneTimeStamp = _initTimeStamp;
	}
    
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ %@, state ==> %llu, %llu/%llu",
			self.requestMethod, [self.url absoluteString],
			(unsigned long long)self.state,
			(unsigned long long)[self uploadBytes],
			(unsigned long long)[self downloadBytes]];
}

- (void)dealloc
{
	self.whenUpdate = nil;
	
	[_responders removeAllObjects];
	[_responders release];
	_responders = nil;
    
	[_userInfo removeAllObjects];
	[_userInfo release];
	_userInfo = nil;
	
	[super dealloc];
}

- (CGFloat)uploadPercent
{
	NSUInteger bytes1 = self.uploadBytes;
	NSUInteger bytes2 = self.uploadTotalBytes;
	
	return bytes2 ? ((CGFloat)bytes1 / (CGFloat)bytes2) : 0.0f;
}

- (NSUInteger)uploadBytes
{
	if ( [self.requestMethod isEqualToString:@"GET"] )
	{
		return 0;
	}
	else if ( [self.requestMethod isEqualToString:@"POST"] )
	{
		return self.postLength;
	}
	
	return 0;
}

- (NSUInteger)uploadTotalBytes
{
	if ( [self.requestMethod isEqualToString:@"GET"] )
	{
		return 0;
	}
	else if ( [self.requestMethod isEqualToString:@"POST"] )
	{
		return self.postLength;
	}
	
	return 0;
}

- (CGFloat)downloadPercent
{
	NSUInteger bytes1 = self.downloadBytes;
	NSUInteger bytes2 = self.downloadTotalBytes;
	
	return bytes2 ? ((CGFloat)bytes1 / (CGFloat)bytes2) : 0.0f;
}

- (NSUInteger)downloadBytes
{
	return [[self rawResponseData] length];
}

- (NSUInteger)downloadTotalBytes
{
	return self.contentLength;
}

- (BOOL)is:(NSString *)text
{
	return [[self.url absoluteString] isEqualToString:text];
}

- (void)callResponders
{
    NSArray * responds = [self.responders copy];
    
	for ( NSObject * responder in responds)
	{
		[self forwardResponder:responder];
	}
	
    [responds release];
}

- (void)forwardResponder:(NSObject *)obj
{
	BOOL allowed = YES;
	
	if ( [obj respondsToSelector:@selector(prehandleRequest:)] )
	{
		allowed = [obj prehandleRequest:self];
	}
	
	if ( allowed )
	{
		[obj retain];
		
		if ( [obj isRequestResponder] )
		{
			[obj handleRequest:self];
		}
		
		[obj posthandleRequest:self];
		
		[obj release];
	}
}

- (void)changeState:(NSUInteger)state
{
	if ( state != _state )
	{
		_state = state;
        
		if ( STATE_SENDING == _state )
		{
			_sendTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		}
		else if ( STATE_RECVING == _state )
		{
			_recvTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		}
		else if ( STATE_FAILED == _state || STATE_SUCCEED == _state || STATE_CANCELLED == _state )
		{
			_doneTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		}
        
		[self callResponders];
		
		if ( self.whenUpdate )
		{
			self.whenUpdate( self );
		}
	}
}

- (void)updateSendProgress
{
	_sendProgressed = YES;
	
	[self callResponders];
    
	if ( self.whenUpdate )
	{
		self.whenUpdate( self );
	}
	
	_sendProgressed = NO;
}

- (void)updateRecvProgress
{
	if ( _state == STATE_SUCCEED || _state == STATE_FAILED || _state == STATE_CANCELLED )
		return;
    
    if ( self.didUseCachedResponse )
		return;
    
	_recvProgressed = YES;
	
	[self callResponders];
    
	if ( self.whenUpdate )
	{
		self.whenUpdate( self );
	}
	
	_recvProgressed = NO;
}

- (NSTimeInterval)timeCostPending
{
	return _sendTimeStamp - _initTimeStamp;
}

- (NSTimeInterval)timeCostOverDNS
{
	return _recvTimeStamp - _sendTimeStamp;
}

- (NSTimeInterval)timeCostRecving
{
	return _doneTimeStamp - _recvTimeStamp;
}

- (NSTimeInterval)timeCostOverAir
{
	return _doneTimeStamp - _sendTimeStamp;
}

- (BOOL)created
{
	return STATE_CREATED == _state ? YES : NO;
}

- (BOOL)sending
{
	return STATE_SENDING == _state ? YES : NO;
}

- (BOOL)recving
{
	return STATE_RECVING == _state ? YES : NO;
}

- (BOOL)succeed
{
	return STATE_SUCCEED == _state ? YES : NO;
}

- (BOOL)failed
{
	return STATE_FAILED == _state ? YES : NO;
}

- (BOOL)cancelled
{
	return STATE_CANCELLED == _state ? YES : NO;
}

- (BOOL)redirected
{
	return STATE_REDIRECTED == _state ? YES : NO;
}

- (BOOL)hasResponder:(id)responder
{
	return [_responders containsObject:responder];
}

- (void)addResponder:(id)responder
{
	[_responders addObject:responder];
}

- (void)removeResponder:(id)responder
{
	[_responders removeObject:responder];
}

- (void)removeAllResponders
{
	[_responders removeAllObjects];
}

- (LCHTTPRequestBlockN)HEADER
{
	LCHTTPRequestBlockN block = ^ LC_HTTPRequest * ( id first, ... )
	{
		va_list args;
		va_start( args, first );
        
		NSString * key = [(NSObject *)first asNSString];
		NSString * value = [va_arg( args, NSObject * ) asNSString];
        
		[self addRequestHeader:key value:(NSString *)value];
        
		va_end( args );
        
		return self;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockN)BODY
{
	LCHTTPRequestBlockN block = ^ LC_HTTPRequest * ( id first, ... )
	{
		NSData * data = nil;
		
		if ( [first isKindOfClass:[NSData class]] )
		{
			data = (NSData *)first;
		}
		else if ( [first isKindOfClass:[NSString class]] )
		{
			data = [(NSString *)first dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		}
		else if ( [first isKindOfClass:[NSArray class]] )
		{
			NSString * text = [NSString queryStringFromArray:(NSArray *)first];
			if ( text )
			{
				data = [text dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
			}
		}
		else if ( [first isKindOfClass:[NSDictionary class]] )
		{
			NSString * text = [NSString queryStringFromDictionary:(NSDictionary *)first];
			if ( text )
			{
				data = [text dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
			}
		}
		else
		{
			data = [[first description] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		}
        
		if ( data )
		{
			self.postBody = [NSMutableData dataWithData:data];
		}
		
		return self;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockN)PARAM
{
	LCHTTPRequestBlockN block = ^ LC_HTTPRequest * ( id first, ... )
	{
		if ( nil == first )
			return self;
        
		NSDictionary * inputParams = nil;
		
		if ( [first isKindOfClass:[NSDictionary class]] )
		{
			inputParams = (NSDictionary *)first;
		}
		else
		{
			va_list args;
			va_start( args, first );
			
			NSString * key = [(NSString *)first asNSString];
			NSString * value = [va_arg( args, NSObject * ) asNSString];
			
			if ( key && value )
			{
				inputParams = [NSDictionary dictionaryWithObject:value forKey:key];
			}
			
			va_end( args );
		}
        
		if ( [self.requestMethod is:@"GET"] )
		{
			for ( NSString * key in inputParams.allKeys )
			{
				NSObject * value = [inputParams objectForKey:key];
				
				NSString * base = [self.url absoluteString];
				NSString * params = [NSString queryStringFromKeyValues:key, [value asNSString], nil];
				NSString * query = self.url.query;
				
				NSURL * newURL = nil;
                
				if ( query.length )
				{
					newURL = [NSURL URLWithString:[base stringByAppendingFormat:@"&%@", params]];
				}
				else
				{
					newURL = [NSURL URLWithString:[base stringByAppendingFormat:@"?%@", params]];
				}
                
				if ( newURL )
				{
					[self setURL:newURL];
				}
			}
		}
		else
		{
			for ( NSString * key in inputParams.allKeys )
			{
				NSObject * value = [inputParams objectForKey:key];
				
				[self setPostValue:[value asNSString] forKey:key];
			}
		}
        
		return self;
	};
	
	return [[block copy] autorelease];
}

- (void)addFileData:(id)data fileName:(NSString *)name alias:(NSString *)alias
{
	if ( data )
	{
		NSString * fullPath = [NSString stringWithFormat:@"%@/Temp/", [LC_Sanbox libCachePath]];
		if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:NULL] )
		{
			BOOL ret = [[NSFileManager defaultManager] createDirectoryAtPath:fullPath
												 withIntermediateDirectories:YES
																  attributes:nil
																	   error:nil];
			if ( NO == ret )
				return;
		}
		
		NSString * fileName = [fullPath stringByAppendingString:name];
		BOOL fileWritten = NO;
		
		if ( [data isKindOfClass:[NSString class]] )
		{
			NSString * string = (NSString *)data;
			fileWritten = [string writeToFile:fileName
								   atomically:YES
									 encoding:NSUTF8StringEncoding
										error:NULL];
		}
		else if ( [data isKindOfClass:[NSData class]] )
		{
			fileWritten = [data writeToFile:fileName
									options:NSDataWritingAtomic
									  error:NULL];
		}
		else
		{
			NSData * decoded = [[data description] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
			fileWritten = [decoded writeToFile:fileName
									   options:NSDataWritingAtomic
										 error:NULL];
		}
		
		if ( fileWritten && [[NSFileManager defaultManager] fileExistsAtPath:fileName isDirectory:NULL] )
		{
			[self setFile:fileName forKey:(alias ? alias : name)];
		}
	}
}

- (LCHTTPRequestBlockN)FILE
{
	LCHTTPRequestBlockN block = ^ LC_HTTPRequest * ( id first, ... )
	{
		va_list args;
		va_start( args, first );
		
		NSString * name = [(NSString *)first asNSString];
		NSObject * data = va_arg( args, NSObject * );
		
		[self addFileData:data fileName:name alias:nil];
		
		return self;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockN)FILE_ALIAS
{
	LCHTTPRequestBlockN block = ^ LC_HTTPRequest * ( id first, ... )
	{
		va_list args;
		va_start( args, first );
		
		NSString * name = [(NSString *)first asNSString];
		NSObject * data = va_arg( args, NSObject * );
		NSString * alias = va_arg( args, NSString * );
        
		[self addFileData:data fileName:name alias:alias];
		
		va_end( args );
		
		return self;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockT)TIMEOUT
{
	LCHTTPRequestBlockT block = ^ LC_HTTPRequest * ( NSTimeInterval interval )
	{
		self.timeOutSeconds = interval;
		
		return self;
	};
	
	return [[block copy] autorelease];
}

-(id) jsonData
{
    if (self.responseString) {
        return [self.responseString objectFromJSONString];
    }
    
    return nil;
}

- (void)startSynchronous
{
	[super startSynchronous];
}

- (void)startAsynchronous
{
	[super startAsynchronous];
}

@end

@implementation LC_EmptyRequest

- (void)startSynchronous
{
	[self performSelector:@selector(reportFailure)];
}

- (void)startAsynchronous
{
	[self performSelector:@selector(reportFailure)];
}

@end
