//
//  LC_HudCenter.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-30.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIHud.h"

#define DEFAULT_TIMEOUT_SECONDS 2

@implementation LC_UIHud

-(void) hide
{
    [self hide:YES];
}

@end

@interface LC_UIHudCenter ()

@property (nonatomic, retain) UIImage *	bubble;
@property (nonatomic, retain) UIImage *	messageIcon;
@property (nonatomic, retain) UIImage *	successIcon;
@property (nonatomic, retain) UIImage *	failureIcon;

@end

@implementation LC_UIHudCenter

-(void) dealloc
{
    LC_RELEASE_ABSOLUTE(_bubble);
    LC_RELEASE_ABSOLUTE(_messageIcon);
    LC_RELEASE_ABSOLUTE(_successIcon);
    LC_RELEASE_ABSOLUTE(_failureIcon);
    
    LC_SUPER_DEALLOC();
}

+ (LC_UIHud *)sharedInstance
{
    static dispatch_once_t once;
    static LC_UIHud * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

+ (void)setDefaultMessageIcon:(UIImage *)image
{
    [LC_UIHudCenter sharedInstance].messageIcon = image;
}

+ (void)setDefaultSuccessIcon:(UIImage *)image
{
    [LC_UIHudCenter sharedInstance].successIcon = image;
}

+ (void)setDefaultFailureIcon:(UIImage *)image
{
    [LC_UIHudCenter sharedInstance].failureIcon = image;
}

+ (void)setDefaultBubble:(UIImage *)image
{
    [LC_UIHudCenter sharedInstance].bubble = image;
}

- (LC_UIHud *)showMessageHud:(NSString *)message inView:(UIView *)view
{
    LC_UIHud * hud = [LC_UIHud showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:DEFAULT_TIMEOUT_SECONDS];
    
    if (self.messageIcon) {
        hud.mode = MBProgressHUDModeCustomView;
        LC_UIImageView * imageView = LC_AUTORELEASE([[LC_UIImageView alloc] initWithImage:self.messageIcon]);
        [imageView sizeToFit];
        hud.customView = imageView;
    }
    
    if (self.bubble) {
        hud.color = [UIColor colorWithPatternImage:self.bubble];
    }
    
    return hud;
}

- (LC_UIHud *)showSuccessHud:(NSString *)message inView:(UIView *)view;
{
    LC_UIHud * hud = [LC_UIHud showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:DEFAULT_TIMEOUT_SECONDS];

    if (self.successIcon) {
        hud.mode = MBProgressHUDModeCustomView;
        LC_UIImageView * imageView = LC_AUTORELEASE([[LC_UIImageView alloc] initWithImage:self.successIcon]);
        [imageView sizeToFit];
        hud.customView = imageView;
    }
    
    if (self.bubble) {
        hud.color = [UIColor colorWithPatternImage:self.bubble];
    }
    
    return hud;
}

- (LC_UIHud *)showFailureHud:(NSString *)message inView:(UIView *)view
{
    LC_UIHud * hud = [LC_UIHud showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:DEFAULT_TIMEOUT_SECONDS];

    if (self.failureIcon) {
        hud.mode = MBProgressHUDModeCustomView;
        LC_UIImageView * imageView = LC_AUTORELEASE([[LC_UIImageView alloc] initWithImage:self.failureIcon]);
        [imageView sizeToFit];
        hud.customView = imageView;
    }
    
    if (self.bubble) {
        hud.color = [UIColor colorWithPatternImage:self.bubble];
    }
    
    return hud;
}

- (LC_UIHud *)showLoadingHud:(NSString *)message inView:(UIView *)view
{
    LC_UIHud * hud = [LC_UIHud showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    
    if (self.bubble) {
        hud.color = [UIColor colorWithPatternImage:self.bubble];
    }
    
    return hud;
}

- (LC_UIHud *)showProgressHud:(NSString *)message inView:(UIView *)view
{
    LC_UIHud * hud = [LC_UIHud showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeAnnularDeterminate;

    if (self.bubble) {
        hud.color = [UIColor colorWithPatternImage:self.bubble];
    }
    
    return hud;
}

@end