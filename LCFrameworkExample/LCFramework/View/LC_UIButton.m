//
//  LC_UIButton.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIButton.h"

#pragma mark -

@implementation LC_UIButton
{
	BOOL				_inited;
}

@dynamic title;
@dynamic titleColor;
@dynamic titleFont;

- (id)init
{
	self = [super init];
	if ( self )
	{
		[self initSelf];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
	if ( NO == _inited )
	{
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeCenter;
		self.adjustsImageWhenDisabled = YES;
		self.adjustsImageWhenHighlighted = YES;
        self.titleLabel.textAlignment = UITextAlignmentCenter;

		self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
		        
		_inited = YES;        
	}
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
}

- (void)dealloc
{
    
	[super dealloc];
}

#pragma mark -

- (NSString *)title
{
	return self.currentTitle;
}

- (void)setTitle:(NSString *)str
{
    [self setTitle:str forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateHighlighted];    
}

- (UIColor *)titleColor
{
	return self.currentTitleColor;
}

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (UIFont *)titleFont
{
	return self.titleLabel.font;
}

- (void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (UIImage *)image
{
	return self.currentImage;
}

- (void)setImage:(UIImage *)img
{
	[self setImage:img forState:self.state];
	[self setNeedsLayout];
}

@end
