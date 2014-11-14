//
//  LC_UIViewBuilder.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIViewBuilder.h"

@implementation LC_UIViewBuilder

UIView * __getQueryBlock( id object , NSString * tagString )
{
    UIView * view = nil;
    
    if ( [object isKindOfClass:[UIView class]] )
    {
        view = object;
    }
    else if ( [object isKindOfClass:[UIViewController class]] )
    {
        view = ((UIViewController *)object).view;
    }
    else if ( [object isKindOfClass:[UIWindow class]] )
    {
        view = object;
    }
    
    return [view viewWithTagString:tagString];

}


@end
