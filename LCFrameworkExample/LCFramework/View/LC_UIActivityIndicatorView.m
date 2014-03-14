//
//  LC_UIActivityIndicatorView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIActivityIndicatorView.h"

@implementation LC_UIActivityIndicatorView

+(LC_UIActivityIndicatorView *) whiteActivityIndicatorView
{
    return LC_AUTORELEASE([[LC_UIActivityIndicatorView alloc] init]);
}

+(LC_UIActivityIndicatorView *) grayActivityIndicatorView
{
    return LC_AUTORELEASE([[LC_UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]);
}

-(void) dealloc
{
    [super dealloc];
}

- (id)init
{
	self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
	self = [super initWithActivityIndicatorStyle:style];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (void)initSelf
{
    self.hidden = YES;
    self.alpha = 0.0f;
    self.hidesWhenStopped = YES;
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    
#if defined(__IPHONE_5_0)
//    if ( IOS5_OR_LATER )
//    {
//        self.color = [UIColor grayColor];
//    }
#endif
}

- (BOOL)animating
{
	return self.isAnimating;
}

- (void)setAnimating:(BOOL)flag
{
	if ( flag )
	{
		[self startAnimating];
	}
	else
	{
		[self stopAnimating];
	}
}

- (void)startAnimating
{
	if ( self.isAnimating )
		return;
		
	self.hidden = NO;
	self.alpha = 1.0f;
	
	[super startAnimating];    
}

- (void)stopAnimating
{
	if ( NO == self.isAnimating )
		return;
        
	self.hidden = YES;
	self.alpha = 0.0f;
    
	[super stopAnimating];    
}

@end
