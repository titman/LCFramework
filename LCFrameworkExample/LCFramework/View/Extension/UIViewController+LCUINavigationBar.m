//
//  UIViewController+UINavigationBar.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "UIViewController+LCUINavigationBar.h"

#pragma mark -

#undef	BUTTON_MIN_WIDTH
#define	BUTTON_MIN_WIDTH	(24.0f)

#undef	BUTTON_MIN_HEIGHT
#define	BUTTON_MIN_HEIGHT	(24.0f)

#pragma mark -

@interface UIViewController(UINavigationBarPrivate)
- (void)didLeftBarButtonTouched;
- (void)didRightBarButtonTouched;
@end

#pragma mark -

@implementation UIViewController(LCUINavigationBar)

+(id) viewController
{
    return [[[[self class] alloc] init] autorelease];
}

- (void)showNavigationBarAnimated:(BOOL)animated
{    
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)hideNavigationBarAnimated:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didLeftBarButtonTouched
{
    [self navigationBarButtonClick:NavigationBarButtonTypeLeft];
}

- (void)didRightBarButtonTouched
{
    [self navigationBarButtonClick:NavigationBarButtonTypeRight];
}

- (void)showBackBarButtonWithImage:(UIImage *)image selectImage:(UIImage *)selectImage
{
	CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    
	if ( buttonFrame.size.width <= BUTTON_MIN_WIDTH )
	{
		buttonFrame.size.width = BUTTON_MIN_WIDTH;
	}
    
	if ( buttonFrame.size.height <= BUTTON_MIN_HEIGHT )
	{
		buttonFrame.size.height = BUTTON_MIN_HEIGHT;
	}
    
	LC_UIButton * button = [[[LC_UIButton alloc] initWithFrame:buttonFrame] autorelease];
	button.contentMode = UIViewContentModeScaleAspectFit;
	button.backgroundColor = [UIColor clearColor];
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (selectImage) {
        [button setImage:selectImage forState:UIControlStateHighlighted];
    }
    
	button.titleFont = [UIFont boldSystemFontOfSize:13.0f];
	button.titleColor = LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR;
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:(UIView *)button] autorelease];
}

- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)name textColor:(UIColor *)textColor
{
    UIFont  * font = [UIFont systemFontOfSize:14];
    UILabel * label = [[[LC_UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 44)] autorelease];
    CGSize size = [name sizeWithFont:font byWidth:label.viewFrameWidth];
    label.frame = LC_RECT_CREATE(0, 0, size.width, size.height);
    label.text = name;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    
	if ( NavigationBarButtonTypeLeft == position )
	{
        [label addTapTarget:self selector:@selector(didLeftBarButtonTouched)];
        [self showBarButton:NavigationBarButtonTypeLeft custom:label];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
        [label addTapTarget:self selector:@selector(didRightBarButtonTouched)];
        [self showBarButton:NavigationBarButtonTypeRight custom:label];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position image:(UIImage *)image selectImage:(UIImage *)selectImage
{
	CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    
	if ( buttonFrame.size.width <= BUTTON_MIN_WIDTH )
	{
		buttonFrame.size.width = BUTTON_MIN_WIDTH;
	}
    
	if ( buttonFrame.size.height <= BUTTON_MIN_HEIGHT )
	{
		buttonFrame.size.height = BUTTON_MIN_HEIGHT;
	}
    
	LC_UIButton * button = [[[LC_UIButton alloc] initWithFrame:buttonFrame] autorelease];
	button.contentMode = UIViewContentModeScaleAspectFit;
	button.backgroundColor = [UIColor clearColor];
    button.exclusiveTouch = YES;
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (selectImage) {
        [button setImage:selectImage forState:UIControlStateHighlighted];
    }else{
        button.showsTouchWhenHighlighted = YES;
    }
    
	button.titleFont = [UIFont boldSystemFontOfSize:13.0f];
	button.titleColor = LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR;
    
//    if (IOS7_OR_LATER) {
//        
//        if (NavigationBarButtonTypeLeft == position) {
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//        }
//        else{
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//        }
//
//    }
    
    
	if ( NavigationBarButtonTypeLeft == position )
	{
		[button addTarget:self action:@selector(didLeftBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:(UIView *)button] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		[button addTarget:self action:@selector(didRightBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:(UIView *)button] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
	CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
	
	if ( buttonFrame.size.width <= BUTTON_MIN_WIDTH )
	{
		buttonFrame.size.width = BUTTON_MIN_WIDTH;
	}
	
	if ( buttonFrame.size.height <= BUTTON_MIN_HEIGHT )
	{
		buttonFrame.size.height = BUTTON_MIN_HEIGHT;
	}
    
	LC_UIButton * button = [[[LC_UIButton alloc] initWithFrame:buttonFrame] autorelease];
	button.contentMode = UIViewContentModeScaleAspectFit;
	button.backgroundColor = [UIColor clearColor];
    
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (selectImage) {
        [button setImage:selectImage forState:UIControlStateHighlighted];
    }
    
	button.title = title;
	button.titleFont = [UIFont boldSystemFontOfSize:13.0f];
	button.titleColor = LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR;
	
	if ( NavigationBarButtonTypeLeft == position )
	{
		[button addTarget:self action:@selector(didLeftBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		[button addTarget:self action:@selector(didRightBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position system:(UIBarButtonSystemItem)index
{
	if ( NavigationBarButtonTypeLeft == position )
	{
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:index
																							   target:self
																							   action:@selector(didLeftBarButtonTouched)] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:index
																								target:self
																								action:@selector(didRightBarButtonTouched)] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position custom:(UIView *)view
{
	if ( NavigationBarButtonTypeLeft == position )
	{
        if (IOS7_OR_LATER) {
            
        }
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	}
}

- (void)hideBarButton:(NavigationBarButtonType)position
{
	if ( NavigationBarButtonTypeLeft == position )
	{
		self.navigationItem.leftBarButtonItem = nil;
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = nil;
	}
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    
}


@end

