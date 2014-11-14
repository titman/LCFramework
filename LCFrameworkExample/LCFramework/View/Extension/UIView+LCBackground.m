//
//  UIView+Background.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-11.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIView+LCBackground.h"

#pragma mark -

@interface __LC_BackgroundImageView : LC_UIImageView
@end

#pragma mark -

@implementation __LC_BackgroundImageView
@end

@implementation UIView (LCBackground)

@dynamic backgroundImageView;
@dynamic backgroundImage;

- (LC_UIImageView *) backgroundImageView
{
	LC_UIImageView * imageView = nil;
	
	for ( UIView * subView in self.subviews )
	{
		if ( [subView isKindOfClass:[__LC_BackgroundImageView class]] )
		{
			imageView = (LC_UIImageView *)subView;
			break;
		}
	}
    
	if ( nil == imageView )
	{
		imageView = [[[__LC_BackgroundImageView alloc] initWithFrame:self.bounds] autorelease];
		imageView.autoresizesSubviews = YES;
 		imageView.autoresizingMask = UIViewAutoresizingNone;
		imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        
		[self addSubview:imageView];
		[self sendSubviewToBack:imageView];
	}
	
	return imageView;
}

- (UIImage *)backgroundImage
{
	return self.backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)image
{
	UIImageView * imageView = self.backgroundImageView;
    
	if ( imageView )
	{
		if ( image )
		{
			imageView.image = image;
			imageView.frame = self.bounds;
			[imageView setNeedsDisplay];
		}
		else
		{
			imageView.image = nil;
			[imageView removeFromSuperview];
		}
	}
}


@end
