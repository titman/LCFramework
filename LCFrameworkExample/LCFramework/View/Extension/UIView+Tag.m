//
//  UIView+Tag.m
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+Tag.h"

#define KEY_TAGSTRING	"UIView.tagString"

@implementation UIView (Tag)

@dynamic tagString;

- (NSString *)tagString
{
	NSObject * obj = objc_getAssociatedObject( self, KEY_TAGSTRING );
	if ( obj && [obj isKindOfClass:[NSString class]] )
		return (NSString *)obj;
	
	return nil;
}

- (void)setTagString:(NSString *)value
{
	objc_setAssociatedObject( self, KEY_TAGSTRING, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

- (UIView *)viewWithTagString:(NSString *)value
{
	if ( nil == value )
		return nil;
	
	for ( UIView * subview in self.subviews )
	{
		NSString * tag = subview.tagString;
		if ( [tag isEqualToString:value] )
		{
			return subview;
		}
	}
	
	return nil;
}

@end
