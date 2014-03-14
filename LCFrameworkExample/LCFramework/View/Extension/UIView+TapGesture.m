//
//  UIView+TapGesture.m
//  LCFramework

//  Created by 郭历成 ( ADVICE & BUG : titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+TapGesture.h"

#pragma mark -

@interface __LC_TapGesture : UITapGestureRecognizer

@end

#pragma mark -

@implementation __LC_TapGesture

- (id)initWithTarget:(id)target action:(SEL)action
{
	self = [super initWithTarget:target action:action];
	if ( self )
	{
		self.numberOfTapsRequired = 1;
		self.numberOfTouchesRequired = 1;
		self.cancelsTouchesInView = YES;
		self.delaysTouchesBegan = YES;
		self.delaysTouchesEnded = YES;
	}
	return self;
}

@end

#pragma mark -

@implementation UIView (TapGesture)

- (UITapGestureRecognizer *)tapGesture
{
	__LC_TapGesture * tapGesture = nil;
	
	for ( UIGestureRecognizer * gesture in self.gestureRecognizers )
	{
		if ( [gesture isKindOfClass:[__LC_TapGesture class]] )
		{
			tapGesture = (__LC_TapGesture *)gesture;
		}
	}
	
	return tapGesture;
}

-(UITapGestureRecognizer *) addTapTarget:(id)target selector:(SEL)selector
{
    __LC_TapGesture * tapGesture = [[[__LC_TapGesture alloc] initWithTarget:target action:selector] autorelease];
    [self addGestureRecognizer:tapGesture];
    
    return tapGesture;
}

@end
