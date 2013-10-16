//
//  LC_UIActivityIndicatorView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
//        self.color = [UIColor whiteColor];
//    }
#endif
}

- (void)dealloc
{	
	[super dealloc];
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
