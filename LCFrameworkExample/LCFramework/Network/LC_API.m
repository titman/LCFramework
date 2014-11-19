//
//  LC_API.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_API.h"

@implementation LC_API

-(void) dealloc
{
    [_url release];
    
    LC_SUPER_DEALLOC();
}

@end
