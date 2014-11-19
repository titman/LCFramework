//
//  LC_HTTPInterface.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-11-15.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "LC_HTTPInterface.h"

@implementation LC_HTTPInterface

-(void) dealloc
{
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
        [self POST];
        return self;
    };
    
    return [[block copy] autorelease];
}

-(void) update:(LC_HTTPRequest *)request
{
    if (request.succeed) {
        
    }else if (request.failed){
        
    }else if (request.cancelled){
        
    }
}

-(void) handleRequest:(LC_HTTPRequest *)request
{
    [self update:request];
}


@end
