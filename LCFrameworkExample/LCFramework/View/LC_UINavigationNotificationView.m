//
//  LC_UINavigationNotificationView.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-17.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UINavigationNotificationView.h"

#pragma mark -

@interface LC_UINavigationGradientView : UIView {
}

@property (nonatomic, readonly) CAGradientLayer * gradientLayer;

@property (nonatomic, assign) NSArray *colors;
@property (nonatomic, assign) NSArray *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic,assign) NSString * type;

@end

#pragma mark -

@implementation LC_UINavigationGradientView

@dynamic gradientLayer;
@dynamic colors, locations, startPoint, endPoint, type;

// Make the view's layer a CAGradientLayer instance
+ (Class)layerClass
{
    return [CAGradientLayer class];
}



// Convenience property access to the layer help omit typecasts
- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}


#pragma mark -
#pragma mark Gradient-related properties

- (NSArray *)colors
{
    NSArray *cgColors = self.gradientLayer.colors;
    if (cgColors == nil) {
        return nil;
    }
    
    // Convert CGColorRefs to UIColor objects
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:[cgColors count]];
    for (id cgColor in cgColors) {
        [uiColors addObject:[UIColor colorWithCGColor:(CGColorRef)cgColor]];
    }
    return [NSArray arrayWithArray:uiColors];
}


// The colors property accepts an array of CGColorRefs or UIColor objects (or mixes between the two).
// UIColors are converted to CGColor before forwarding the values to the layer.
- (void)setColors:(NSArray *)newColors
{
    NSMutableArray *newCGColors = nil;
    
    if (newColors != nil) {
        newCGColors = [NSMutableArray arrayWithCapacity:[newColors count]];
        for (id color in newColors) {
            // If the array contains a UIColor, convert it to CGColor.
            // Leave all other types untouched.
            if ([color isKindOfClass:[UIColor class]]) {
                [newCGColors addObject:(id)[color CGColor]];
            } else {
                [newCGColors addObject:color];
            }
        }
    }
    
    self.gradientLayer.colors = newCGColors;
}


- (NSArray *)locations
{
    return self.gradientLayer.locations;
}

- (void)setLocations:(NSArray *)newLocations
{
    self.gradientLayer.locations = newLocations;
}

- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

- (void)setStartPoint:(CGPoint)newStartPoint
{
    self.gradientLayer.startPoint = newStartPoint;
}

- (CGPoint)endPoint
{
    return self.gradientLayer.endPoint;
}

- (void)setEndPoint:(CGPoint)newEndPoint
{
    self.gradientLayer.endPoint = newEndPoint;
}

- (NSString *)type
{
    return self.gradientLayer.type;
}

- (void) setType:(NSString *)newType
{
    self.gradientLayer.type = newType;
}

-(void) dealloc
{    
    [super dealloc];
}

@end

#pragma mark -

#define kCMNavBarNotificationHeight    44.0f
#define kCMNavBarNotificationIPadWidth 480.0f
#define RADIANS(deg) ((deg) * M_PI / 180.0f)

@interface LC_UINavigationNotificationWindow : UIWindow

@property (nonatomic, retain) NSMutableArray * notificationQueue;
@property (nonatomic, assign) UIView * currentNotification;

@end

@implementation LC_UINavigationNotificationWindow

+ (CGRect) notificationRectWithOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat statusBarHeight = 20.0f;
    if ([UIApplication sharedApplication].statusBarHidden)
        statusBarHeight = 0.0f;
    if (UIDeviceOrientationIsLandscape(orientation))
    {
        
        return CGRectMake(0.0f, statusBarHeight, [UIScreen mainScreen].bounds.size.height, kCMNavBarNotificationHeight);
    }
    
    return CGRectMake(0.0f, statusBarHeight, [UIScreen mainScreen].bounds.size.width, kCMNavBarNotificationHeight);
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_notificationQueue release];
    
    [super dealloc];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.backgroundColor = [UIColor clearColor];
        _notificationQueue = [[NSMutableArray alloc] initWithCapacity:4];
        
        UIView * topHalfBlackView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(frame),
                                                                            CGRectGetMinY(frame),
                                                                            CGRectGetWidth(frame),
                                                                            0.5 * CGRectGetHeight(frame))];
        
        topHalfBlackView.backgroundColor = [UIColor blackColor];
        topHalfBlackView.layer.zPosition = -100;
        topHalfBlackView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:topHalfBlackView];
        LC_RELEASE(topHalfBlackView);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willRotateScreen:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
        
        [self rotateStatusBarWithFrame:frame andOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    }
    
    return self;
}

- (void) willRotateScreen:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    CGRect notificationBarFrame = [LC_UINavigationNotificationWindow notificationRectWithOrientation:orientation];
    
    if (self.hidden)
    {
        [self rotateStatusBarWithFrame:notificationBarFrame andOrientation:orientation];
    }
    else
    {
        [self rotateStatusBarAnimatedWithFrame:notificationBarFrame andOrientation:orientation];
    }
}

- (void) rotateStatusBarAnimatedWithFrame:(CGRect)frame andOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self rotateStatusBarWithFrame:frame andOrientation:orientation];
                         [UIView animateWithDuration:duration
                                          animations:^{
                                              self.alpha = 1;
                                          }];
                     }];
}


- (void) rotateStatusBarWithFrame:(CGRect)frame andOrientation:(UIInterfaceOrientation)orientation
{
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);
    CGFloat statusBarHeight = 20.0f;
    if ([UIApplication sharedApplication].statusBarHidden)
        statusBarHeight = 0.0f;
    if (isPortrait)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            frame.size.width = kCMNavBarNotificationIPadWidth;
        }
        
        if (orientation == UIDeviceOrientationPortraitUpsideDown)
        {
            frame.origin.y = [UIScreen mainScreen].bounds.size.height - kCMNavBarNotificationHeight - statusBarHeight;
            self.transform = CGAffineTransformMakeRotation(RADIANS(180.0f));
        }
        else
        {
            self.transform = CGAffineTransformIdentity;
        }
    }
    else
    {
        frame.size.height = frame.size.width;
        frame.size.width  = kCMNavBarNotificationHeight;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            frame.size.height = kCMNavBarNotificationIPadWidth;
        }
        
        if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            frame.origin.x = [UIScreen mainScreen].bounds.size.width - frame.size.width - statusBarHeight;
            self.transform = CGAffineTransformMakeRotation(RADIANS(90.0f));
        }
        else
        {
            frame.origin.x = frame.origin.x + statusBarHeight;
            self.transform = CGAffineTransformMakeRotation(RADIANS(-90.0f));
        }
    }
    
    self.frame = frame;
    CGPoint center = self.center;
    if (isPortrait)
    {
        center.x = CGRectGetMidX([UIScreen mainScreen].bounds);
    }
    else
    {
        center.y = CGRectGetMidY([UIScreen mainScreen].bounds);
    }
    self.center = center;
}

@end


#pragma mark -


static CGFloat const __imagePadding = 8.0f;
static LC_UINavigationNotificationWindow * __notificationWindow = nil;

@interface LC_UINavigationNotificationView ()

@property (nonatomic, assign) UITapGestureRecognizer *tapGestureRecognizer;

+ (void) showNextNotification;
+ (UIImage*) screenImageWithRect:(CGRect)rect;

@end

#pragma mark -

@implementation LC_UINavigationNotificationView

- (void) setBackgroundColor:(UIColor *)color
{
    _contentView.colors = @[(id)[color CGColor],
                            (id)[color CGColor]];
}

- (void) dealloc
{
    [self removeGestureRecognizer:_tapGestureRecognizer];
    
    [super dealloc];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        CGFloat notificationWidth = [LC_UINavigationNotificationWindow notificationRectWithOrientation:orientation].size.width;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        _contentView = [[LC_UINavigationGradientView alloc] initWithFrame:self.bounds];
        _contentView.colors = @[(id)[[UIColor colorWithWhite:0.99f alpha:1.0f] CGColor],
                                (id)[[UIColor colorWithWhite:0.9f  alpha:1.0f] CGColor]];
        
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _contentView.layer.cornerRadius = 0.0f;
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
        [_contentView release];
        
        _imageView = [[LC_UIImageView alloc] initWithFrame:CGRectMake(6, self.center.y-28/2, 28, 28)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 4.0f;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        [_imageView release];
        
        UIFont *textFont = [UIFont boldSystemFontOfSize:14.0f];
        UIFont *detailFont = [UIFont systemFontOfSize:13.0f];

        CGRect textFrame = CGRectMake(__imagePadding + CGRectGetMaxX(_imageView.frame),
                                      (self.viewFrameHeight-textFont.lineHeight-detailFont.lineHeight)/2,
                                      notificationWidth - __imagePadding * 2 - CGRectGetMaxX(_imageView.frame),
                                      textFont.lineHeight);
        _textLabel = [[UILabel alloc] initWithFrame:textFrame];
        _textLabel.font = textFont;
        _textLabel.numberOfLines = 1;
        _textLabel.textAlignment = UITextAlignmentLeft;
        _textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _textLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:_textLabel];
        [_textLabel release];
        
        CGRect detailFrame = CGRectMake(CGRectGetMinX(textFrame),
                                        CGRectGetMaxY(textFrame),
                                        notificationWidth - __imagePadding * 2 - CGRectGetMaxX(_imageView.frame),
                                        detailFont.lineHeight);
        
        _detailTextLabel = [[UILabel alloc] initWithFrame:detailFrame];
        _detailTextLabel.font = detailFont;
        _detailTextLabel.numberOfLines = 1;
        _detailTextLabel.textAlignment = UITextAlignmentLeft;
        _detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _detailTextLabel.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:_detailTextLabel];
        [_detailTextLabel release];
    }
    
    return self;
}

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                    andDetail:(NSString*)detail
{
    return [self notifyWithText:text
                         detail:detail
                    andDuration:2.0f];
}

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                       detail:(NSString*)detail
                                  andDuration:(NSTimeInterval)duration
{
    return [self notifyWithText:text
                         detail:detail
                          image:nil
                    andDuration:duration];
}

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                       detail:(NSString*)detail
                                        image:(UIImage*)image
                                  andDuration:(NSTimeInterval)duration
{
    return [self notifyWithText:text
                         detail:detail
                          image:image
                       duration:duration];
}

+ (LC_UINavigationNotificationView *) notifyWithText:(NSString*)text
                                       detail:(NSString*)detail
                                        image:(UIImage*)image
                                     duration:(NSTimeInterval)duration
{
    if (__notificationWindow == nil)
    {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        CGRect frame = [LC_UINavigationNotificationWindow notificationRectWithOrientation:orientation];
        __notificationWindow = [[LC_UINavigationNotificationWindow alloc] initWithFrame:frame];
        __notificationWindow.hidden = NO;
    }
    CGRect bounds = __notificationWindow.bounds;
    LC_UINavigationNotificationView * notification = [[LC_UINavigationNotificationView alloc] initWithFrame:bounds];
    
    notification.textLabel.text = text;
    notification.detailTextLabel.text = detail;
    notification.imageView.image = image;
    notification.duration = duration;
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:notification
                                                                         action:@selector(handleTap:)];
    notification.tapGestureRecognizer = gr;
    [notification addGestureRecognizer:gr];
    
    [__notificationWindow.notificationQueue addObject:notification];
    
    if (__notificationWindow.currentNotification == nil)
    {
        [self showNextNotification];
    }
    
    return notification;
}

- (void) handleTap:(UITapGestureRecognizer *)gestureRecognizer
{    
    [[NSNotificationCenter defaultCenter] postNotificationName:LCUINavigationNofiticationTapReceivedNotification
                                                        object:self];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:[self class]
                                             selector:@selector(showNextNotification)
                                               object:nil];
    
    [LC_UINavigationNotificationView showNextNotification];
}

+ (void) showNextNotification
{
    UIView *viewToRotateOut = nil;
    CGRect frame = __notificationWindow.frame;
    UIImage *screenshot = [self screenImageWithRect:frame];
    
    if (__notificationWindow.currentNotification)
    {
        viewToRotateOut = __notificationWindow.currentNotification;
    }
    else
    {
        viewToRotateOut = [[UIImageView alloc] initWithFrame:__notificationWindow.bounds];
        ((UIImageView *)viewToRotateOut).image = screenshot;
        [__notificationWindow addSubview:viewToRotateOut];
        __notificationWindow.hidden = NO;
    }
    
    UIView *viewToRotateIn = nil;
    
    if ([__notificationWindow.notificationQueue count] > 0)
    {
        viewToRotateIn = __notificationWindow.notificationQueue[0];
    }
    else
    {
        viewToRotateIn = [[UIImageView alloc] initWithFrame:__notificationWindow.bounds];
        ((UIImageView *)viewToRotateIn).image = screenshot;
    }
    
    viewToRotateIn.layer.anchorPointZ = 11.547f;
    viewToRotateIn.layer.doubleSided = NO;
    viewToRotateIn.layer.zPosition = 2;
    
    CATransform3D viewInStartTransform = CATransform3DMakeRotation(RADIANS(-120), 1.0, 0.0, 0.0);
    viewInStartTransform.m34 = -1.0 / 200.0;
    
    viewToRotateOut.layer.anchorPointZ = 11.547f;
    viewToRotateOut.layer.doubleSided = NO;
    viewToRotateOut.layer.zPosition = 2;
    
    CATransform3D viewOutEndTransform = CATransform3DMakeRotation(RADIANS(120), 1.0, 0.0, 0.0);
    viewOutEndTransform.m34 = -1.0 / 200.0;
    
    [__notificationWindow addSubview:viewToRotateIn];
    __notificationWindow.backgroundColor = [UIColor blackColor];
    
    viewToRotateIn.layer.transform = viewInStartTransform;
    
    if ([viewToRotateIn isKindOfClass:[LC_UINavigationNotificationView class]] )
    {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:__notificationWindow.bounds];
        bgImage.image = screenshot;
        [viewToRotateIn addSubview:bgImage];
        LC_RELEASE(bgImage);
        [viewToRotateIn sendSubviewToBack:bgImage];
        __notificationWindow.currentNotification = viewToRotateIn;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         viewToRotateIn.layer.transform = CATransform3DIdentity;
                         viewToRotateOut.layer.transform = viewOutEndTransform;
                     }
                     completion:^(BOOL finished) {
                         [viewToRotateOut removeFromSuperview];
                         [__notificationWindow.notificationQueue removeObject:viewToRotateOut];
                         if ([viewToRotateIn isKindOfClass:[LC_UINavigationNotificationView class]])
                         {
                             LC_UINavigationNotificationView *notification = (LC_UINavigationNotificationView *)viewToRotateIn;
                             [self performSelector:@selector(showNextNotification)
                                        withObject:nil
                                        afterDelay:notification.duration];
                             
                             __notificationWindow.currentNotification = notification;
                             [__notificationWindow.notificationQueue removeObject:notification];
                         }
                         else
                         {
                             [viewToRotateIn removeFromSuperview];
                             __notificationWindow.hidden = YES;
                             __notificationWindow.currentNotification = nil;
                         }
                         
                         __notificationWindow.backgroundColor = [UIColor clearColor];
                     }];
}

+ (UIImage *) screenImageWithRect:(CGRect)rect
{
    CALayer *layer = [[UIApplication sharedApplication] keyWindow].layer;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, scale);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale
                      , rect.size.width * scale, rect.size.height * scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], rect);
    UIImage *croppedScreenshot = [UIImage imageWithCGImage:imageRef
                                                     scale:screenshot.scale
                                               orientation:screenshot.imageOrientation];
    CGImageRelease(imageRef);
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIImageOrientation imageOrientation = UIImageOrientationUp;
    
    switch (orientation)
    {
        case UIDeviceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationDown;
            break;
        case UIDeviceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationRight;
            break;
        case UIDeviceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationLeft;
            break;
        default:
            break;
    }
    
    return [[[UIImage alloc] initWithCGImage:croppedScreenshot.CGImage
                                      scale:croppedScreenshot.scale
                                orientation:imageOrientation] autorelease];
}


@end
