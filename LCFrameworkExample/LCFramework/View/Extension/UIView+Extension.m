//
//  UIView+Extension.m
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)removeAllSubviews
{
	NSArray * array = [[self.subviews copy] autorelease];
    
	for ( UIView * view in array )
	{
		[view removeFromSuperview];
	}
}

@end
