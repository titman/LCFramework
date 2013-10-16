//
//  NSObject+LCHTTPRequest.m
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

#import "NSObject+LCHTTPRequest.h"

@implementation NSObject (LCHTTPRequest)

@dynamic REQUESTING;
@dynamic REQUESTING_URL;
@dynamic CANCEL_REQUESTS;

@dynamic GET;
@dynamic PUT;
@dynamic POST;

@dynamic HTTP_GET;
@dynamic HTTP_PUT;
@dynamic HTTP_POST;

- (LC_HTTPRequest *)GET:(NSString *)url
{
	return [self HTTP_GET:url];
}

- (LC_HTTPRequest *)PUT:(NSString *)url
{
	return [self HTTP_PUT:url];
}

- (LC_HTTPRequest *)POST:(NSString *)url
{
	return [self HTTP_POST:url];
}

- (LC_HTTPRequest *)HTTP_GET:(NSString *)url
{
	LC_HTTPRequest * req = [LC_HTTPRequestQueue GET:url];
	[req addResponder:self];
	return req;
}

- (LC_HTTPRequest *)HTTP_PUT:(NSString *)url
{
	LC_HTTPRequest * req = [LC_HTTPRequestQueue PUT:url];
	[req addResponder:self];
	return req;
}

- (LC_HTTPRequest *)HTTP_POST:(NSString *)url
{
	LC_HTTPRequest * req = [LC_HTTPRequestQueue POST:url];
	[req addResponder:self];
	return req;
}

- (BOOL)isRequestResponder
{
	if ( [self respondsToSelector:@selector(handleRequest:)] )
	{
		return YES;
	}
	
	return NO;
}

- (LCHTTPBoolBlockV)REQUESTING
{
	LCHTTPBoolBlockV block = ^ BOOL ( void )
	{
		return [self requestingURL:nil];
	};
    
	return [[block copy] autorelease];
}

- (LCHTTPBoolBlockS)REQUESTING_URL
{
	LCHTTPBoolBlockS block = ^ BOOL ( NSString * url )
	{
		return [self requestingURL:url];
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPBoolBlockV)CANCEL_REQUESTS
{
	LCHTTPBoolBlockV block = ^ BOOL ( void )
	{
		[self cancelRequests];
		return YES;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)GET
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
        
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue GET:url];
		[req addResponder:self];
		return req;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)PUT
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
		
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue PUT:url];
		[req addResponder:self];
		return req;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)POST
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
		
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue POST:url];
		[req addResponder:self];
		return req;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)HTTP_GET
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
		
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue GET:url];
		[req addResponder:self];
		return req;
	};
    
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)HTTP_PUT
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
		
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue PUT:url];
		[req addResponder:self];
		return req;
	};
	
	return [[block copy] autorelease];
}

- (LCHTTPRequestBlockSN)HTTP_POST
{
	LCHTTPRequestBlockSN block = ^ LC_HTTPRequest * ( NSString * url, ... )
	{
		va_list args;
		va_start( args, url );
		
		url = [[[NSString alloc] initWithFormat:url arguments:args] autorelease];
		
		va_end( args );
        
		LC_HTTPRequest * req = [LC_HTTPRequestQueue POST:url];
		[req addResponder:self];
		return req;
	};
    
	return [[block copy] autorelease];
}

- (BOOL)requestingURL
{
	if ( [self isRequestResponder] )
	{
		return [LC_HTTPRequestQueue requesting:nil byResponder:self];
	}
	else
	{
		return NO;
	}
}

- (BOOL)requestingURL:(NSString *)url
{
	if ( [self isRequestResponder] )
	{
		return [LC_HTTPRequestQueue requesting:url byResponder:self];
	}
	else
	{
		return NO;
	}
}

- (NSArray *)requests
{
	return [LC_HTTPRequestQueue requests:nil byResponder:self];
}

- (NSArray *)requests:(NSString *)url
{
	return [LC_HTTPRequestQueue requests:url byResponder:self];
}

- (void)cancelRequests
{
	if ( [self isRequestResponder] )
	{
		[LC_HTTPRequestQueue cancelRequestByResponder:self];
	}
}

- (BOOL)prehandleRequest:(LC_HTTPRequest *)request
{
	return YES;
}

- (void)posthandleRequest:(LC_HTTPRequest *)request
{
	
}

- (void)handleRequest:(LC_HTTPRequest *)request
{
    ;
}


@end
