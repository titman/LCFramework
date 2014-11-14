//
//  LC_UIButton.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
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
		      
        [self setExclusiveTouch:YES];
        
        _enableAllEvents = YES;
		_inited = YES;        
	}
}

-(void) setSignalName:(NSString *)signalName
{
    [_signalName release];
    _signalName = [signalName retain];
    
    [self removeTarget:self action:@selector(didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
}

- (void)dealloc
{
    [_signalName release];
	[super dealloc];
}


- (void)didTouchUpInside
{
    if ( self.signalName )
    {
        [self sendUISignal:self.signalName];
    }
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
    [self setTitle:str forState:UIControlStateSelected];
}

- (UIColor *)titleColor
{
	return self.currentTitleColor;
}

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (UIFont *)titleFont
{
	return self.titleLabel.font;
}

- (void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (UIImage *)buttonImage
{
	return [self imageForState:UIControlStateNormal];
}

- (void)setButtonImage:(UIImage *)buttonImage
{
    [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:buttonImage forState:UIControlStateSelected];
}

@end
