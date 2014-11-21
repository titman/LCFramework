//
//  LC_HTTPInterface.m
//  LCFramework
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_HTTPInterface.h"

#pragma mark -

@implementation LC_HTTPInterfaceResult

-(void) dealloc
{
    [_errorMessage release];
    [_json release];
    
    [super dealloc];
}

+(instancetype) result
{
    return LC_AUTORELEASE([[LC_HTTPInterfaceResult alloc] init]);
}

-(id) init
{
    LC_SUPER_INIT({
        
        self.state = LCHTTPRequestStateFail;
        self.errorCode = 0;
        self.errorMessage = @"";
        self.json = nil;
    })
}

@end

#pragma mark -

@implementation LC_HTTPInterface

-(void) dealloc
{
    self.UPDATE = nil;
    
    [_url release];
    [_parameters release];
    
    LC_SUPER_DEALLOC();
}

+(instancetype) interface
{
    return [[[[self class] alloc] init] autorelease];
}

-(id) init
{
    LC_SUPER_INIT({
        
        self.parameters = [NSMutableDictionary dictionary];
    })
}

-(void) request
{
    if (!self.url) {
        return;
    }
    
    [self cancelRequests];
    
    self.GET( self.url ).PARAM( self.parameters );
}

- (LCHTTPInterfaceRequestBlock)REQUEST
{
    LCHTTPInterfaceRequestBlock block = ^ LC_HTTPInterface * ()
    {
        [self request];
        return self;
    };
    
    return [[block copy] autorelease];
}


-(void) post
{
    
}

- (LCHTTPRequestPostBlock)POST
{
    LCHTTPRequestPostBlock block = ^ LC_HTTPInterface * ()
    {
        [self post];
        return self;
    };
    
    return [[block copy] autorelease];
}

-(void) handleRequest:(LC_HTTPRequest *)request
{
    if (self.UPDATE) {
        self.UPDATE(request);
    }
}


@end
