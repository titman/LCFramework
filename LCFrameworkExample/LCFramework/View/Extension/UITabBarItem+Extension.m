//
//  UITabBarItem+Exxtension.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "UITabBarItem+Extension.h"

#define KEY_TAGDATA	"UITabBarItem.tagData"


@implementation UITabBarItem (Extension)

- (NSArray *)imageData
{
	NSObject * obj = objc_getAssociatedObject( self, KEY_TAGDATA );
	if ( obj && [obj isKindOfClass:[NSArray class]] )
		return (NSArray *)obj;
	
	return nil;
}

- (void)setImageData:(NSArray *)imageData
{
	objc_setAssociatedObject( self, KEY_TAGDATA, imageData, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

@end
