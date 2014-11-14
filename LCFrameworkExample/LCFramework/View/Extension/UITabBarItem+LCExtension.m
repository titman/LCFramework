//
//  UITabBarItem+Exxtension.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UITabBarItem+LCExtension.h"

#define KEY_TAGDATA	"UITabBarItem.tagData"


@implementation UITabBarItem (LCExtension)

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
