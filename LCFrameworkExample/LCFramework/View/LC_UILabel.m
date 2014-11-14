//
//  LC_UILabel.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UILabel.h"

@interface LC_UILabel ()

@property (nonatomic, assign) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation LC_UILabel

-(id) initWithCopyingEnabled:(BOOL)copyingEnabled
{
    self = [super initWithFrame:CGRectZero];
	if ( self )
	{
        self.copyingEnabled = copyingEnabled;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

-(id) initWithFrame:(CGRect)frame copyingEnabled:(BOOL)copyingEnabled
{
    self = [super initWithFrame:frame];
	if ( self )
	{
        self.copyingEnabled = copyingEnabled;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

- (id)init
{
	self = [super initWithFrame:CGRectZero];
	if ( self )
	{
        self.copyingEnabled = NO;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if ( self )
	{
        self.copyingEnabled = NO;
		[self initCopyGecognizer];
        [self defaultConfig];
	}
	return self;
}

-(void) defaultConfig
{
    self.font = [UIFont systemFontOfSize:12.0f];
    self.textAlignment = UITextAlignmentLeft;
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.lineBreakMode = UILineBreakModeTailTruncation;
    self.userInteractionEnabled = YES;
}

-(void) initCopyGecognizer
{
    if (self.copyingEnabled) {
        if (self.longPressGestureRecognizer) {
            self.longPressGestureRecognizer.enabled = YES;
            return;
        }else{
            self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
            [self addGestureRecognizer:_longPressGestureRecognizer];
        
            LC_RELEASE(_longPressGestureRecognizer);
            
            _copyMenuArrowDirection = UIMenuControllerArrowDefault;
        }
    }else{
        if (self.longPressGestureRecognizer) {
            self.longPressGestureRecognizer.enabled = NO;
        }
    }
}

-(void) setCopyingEnabled:(BOOL)copyingEnabled
{
    _copyingEnabled = copyingEnabled;
    [self initCopyGecognizer];
}

-(void) longPressGestureRecognized:(UILongPressGestureRecognizer *)rg
{
    if (rg == self.longPressGestureRecognizer)
    {
        if (rg.state == UIGestureRecognizerStateBegan)
        {
            if(![self becomeFirstResponder]){
                NSLog(@" ! UIMenuController will not work with %@ since it cannot become first responder", self);
            }

            UIMenuController * copyMenu = [UIMenuController sharedMenuController];
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = self.copyMenuArrowDirection;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.copyingEnabled)
        {
            retValue = YES;
        }
	}
    else
    {
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.copyingEnabled)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.text];
    }
}


-(void) setStrikeThroughLine:(BOOL)strikeThroughLine
{
    _strikeThroughLine = strikeThroughLine;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    if (self.strikeThroughLine)
    {
        CGSize contentSize = [self.text sizeWithFont:self.font constrainedToSize:self.frame.size];
        CGContextRef c = UIGraphicsGetCurrentContext();
        //CGFloat color[4] = {0.667, 0.667, 0.667, 1.0};
        CGContextSetStrokeColor(c, CGColorGetComponents(self.textColor.CGColor));
        CGContextSetLineWidth(c, 1);
        CGContextBeginPath(c);
        CGFloat halfWayUp = (self.bounds.size.height - self.bounds.origin.y) / 2.0;
        CGContextMoveToPoint(c, self.bounds.origin.x, halfWayUp );
        CGContextAddLineToPoint(c, self.bounds.origin.x + contentSize.width, halfWayUp);
        CGContextStrokePath(c);
    }
    
    [super drawRect:rect];
}

@end
