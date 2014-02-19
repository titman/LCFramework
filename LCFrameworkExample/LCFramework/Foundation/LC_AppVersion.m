//
//  LC_AppVersion.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_AppVersion.h"

#pragma mark -

static NSString *const appVersionAppLookupURLFormat = @"http://itunes.apple.com/%@/lookup";

#pragma mark -

@implementation NSString(LC_AppVersion)

- (NSComparisonResult)compareVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (NSComparisonResult)compareVersionDescending:(NSString *)version
{
    switch ([self compareVersion:version])
    {
        case NSOrderedAscending:
        {
            return NSOrderedDescending;
        }
        case NSOrderedDescending:
        {
            return NSOrderedAscending;
        }
        default:
        {
            return NSOrderedSame;
        }
    }
}

@end

#pragma mark -

@interface LC_AppVersion ()
{
    LC_UINavigationNotificationView * notificationView;
}

@end

#pragma mark -

@implementation LC_AppVersion

+(LC_AppVersion *) sharedInstance
{
    static dispatch_once_t once;
    static LC_AppVersion * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

-(void) dealloc
{
    self.checkFinishBlock = nil;
    self.updateButtonClickBlock = nil;
    
    LC_RELEASE_ABSOLUTE(_theNewVersionNumber);
    LC_RELEASE_ABSOLUTE(_theNewVersionURL);
    LC_RELEASE_ABSOLUTE(_applicationVersion);
    LC_RELEASE_ABSOLUTE(_appStoreCountry);
    LC_RELEASE_ABSOLUTE(_updateButtonTitle);
    LC_RELEASE_ABSOLUTE(_cancelButtonTitle);
    LC_RELEASE_ABSOLUTE(_theNewVersionDetails);
    LC_RELEASE_ABSOLUTE(_theNewVersionIconURL);
    
    [self unobserveNotification:LCUINavigationNofiticationTapReceivedNotification];
    
    LC_SUPER_DEALLOC();
}

-(LC_AppVersion *) init
{
    LC_SUPER_INIT({
    
        self.applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        if ([self.applicationVersion length] == 0)
        {
            self.applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        }
        
        self.appStoreCountry = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];

        self.autoPresentedUpdateAlert = YES;
        
        self.hasNewVersion = NO;
        self.theNewVersionDetails = nil;
        self.theNewVersionNumber = nil;
        self.theNewVersionURL = nil;
        
        self.alertStyle = LC_APPVERSION_ALERT_STYLE_ALERT;
        self.updateButtonTitle = LC_LO(@"马上更新");
        self.cancelButtonTitle = LC_LO(@"下次再说");
        
        [self observeNotification:LCUINavigationNofiticationTapReceivedNotification];
    });
}

+(void) checkForNewVersion
{
    [[LC_AppVersion sharedInstance] checkForNewVersion];
}

-(void) checkForNewVersion
{
    [self cancelRequests];

    NSString * iTunesServiceURL = [NSString stringWithFormat:appVersionAppLookupURLFormat, self.appStoreCountry];

    iTunesServiceURL = [iTunesServiceURL stringByAppendingFormat:@"?bundleId=%@",[LC_SystemInfo appIdentifier]];
    
    [self GET:iTunesServiceURL];
}

- (void) handleRequest:(LC_HTTPRequest *)request
{
    if (request.succeed) {
        
        NSDictionary * resultData = request.jsonData;
        
        if ([[resultData objectForKey:@"resultCount"] intValue] == 0) {
            
            NSLog(@"LC_AppVersion check failed : 未在appstore找到该程序的“Bundle ID : %@”对应的程序信息",[LC_SystemInfo appIdentifier]);
            
        }else{
            
            NSArray * applicationInfos = [resultData objectForKey:@"results"];
            
            __block NSInteger resultIndex = -1;
            __block NSString * newVersionNumber = nil;
            
            [applicationInfos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            
                NSString * appStoreVersion = [obj objectForKey:@"version"];

                BOOL newerVersionAvailable = ([appStoreVersion compareVersion:self.applicationVersion] == NSOrderedDescending);
            
                if (newerVersionAvailable) {
                    resultIndex = idx;
                    newVersionNumber = appStoreVersion;
                }
                
            }];
            
            if (newVersionNumber) {
                NSLog(@"LC_AppVesrsion check finished : 发现新版本 %@",newVersionNumber);
                self.hasNewVersion = YES;
                self.theNewVersionNumber  = newVersionNumber;
                self.theNewVersionURL     = [[applicationInfos objectAtIndex:resultIndex] objectForKey:@"trackViewUrl"];
                self.theNewVersionDetails = [[applicationInfos objectAtIndex:resultIndex] objectForKey:@"releaseNotes"];
                self.theNewVersionIconURL = [[applicationInfos objectAtIndex:resultIndex] objectForKey:@"artworkUrl60"];
 
            }else{
                NSLog(@"LC_AppVesrsion check finished : 未发现新版本");
//                self.hasNewVersion = NO;
//                self.theNewVersionDetails = nil;
//                self.theNewVersionNumber = nil;
//                self.theNewVersionURL = nil;
            }
        
        }
        
    }else if (request.failed){
        
        NSLog(@"LC_AppVersion check failed : %@",request.error.description);
        
    }else if (request.cancelled){

    }

    if (_checkFinishBlock) {
        _checkFinishBlock(self);
    }
    
    if (self.autoPresentedUpdateAlert) {
        [self showNewVersionUpdateAlert];
    }
}

-(void) showNewVersionUpdateAlert
{
    if (!self.hasNewVersion) {
        return;
    }
    
    
    if (self.alertStyle == LC_APPVERSION_ALERT_STYLE_ALERT) {
        
        LC_UIAlertView * alertView = [LC_UIAlertView showMessage:self.theNewVersionDetails title:LC_NSSTRING_FORMAT(@"%@:%@",LC_LO(@"发现新版本"),self.theNewVersionNumber) cancelTitle:self.cancelButtonTitle otherButtonTitle:self.updateButtonTitle];

        __block LC_AppVersion * nRetainSelf = self;
        
        alertView.clickBlock = ^(LC_UIAlertView * alertView, NSInteger clickIndex){
        
            if (clickIndex != alertView.cancelButtonIndex) {
                if (nRetainSelf.updateButtonClickBlock) {
                    nRetainSelf.updateButtonClickBlock(nRetainSelf);
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.theNewVersionURL]];
            }
        
        };
        
    }else if (self.alertStyle == LC_APPVERSION_ALERT_STYLE_NOTIFICATION){
        
        notificationView = [LC_UINavigationNotificationView notifyWithText:LC_NSSTRING_FORMAT(@"%@:%@",LC_LO(@"发现新版本"),self.theNewVersionNumber) detail:self.theNewVersionDetails andDuration:5];
        notificationView.imageView.url = self.theNewVersionIconURL;
    }
}

#pragma mark -

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:LCUINavigationNofiticationTapReceivedNotification] && notification.object == notificationView) {
        
        if (_updateButtonClickBlock) {
            _updateButtonClickBlock(self);
        }
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.theNewVersionURL]];
    }
}

#pragma mark -

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    [self resizeAlertView:alertView];
}

- (void)resizeAlertView:(UIAlertView *)alertView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) &&
        [[UIDevice currentDevice].systemVersion floatValue] < 7.0f)
    {
        CGFloat max = alertView.window.bounds.size.height - alertView.frame.size.height - 10.0f;
        CGFloat offset = 0.0f;
        for (UIView *view in alertView.subviews)
        {
            CGRect frame = view.frame;
            if ([view isKindOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel *)view;
                if ([label.text isEqualToString:alertView.message])
                {
                    label.lineBreakMode = NSLineBreakByWordWrapping;
                    label.numberOfLines = 0;
                    label.textAlignment = UITextAlignmentLeft;
                    label.alpha = 1.0f;
                    [label sizeToFit];
                    offset = label.frame.size.height - frame.size.height;
                    frame.size.height = label.frame.size.height;
                    if (offset > max)
                    {
                        frame.size.height -= (offset - max);
                        offset = max;
                    }
                    if (offset > max - 10.0f)
                    {
                        frame.size.height -= (offset - max - 10);
                        frame.origin.y += (offset - max - 10) / 2.0f;
                    }
                }
            }
            else if ([view isKindOfClass:[UITextView class]])
            {
                view.alpha = 0.0f;
            }
            else if ([view isKindOfClass:[UIControl class]])
            {
                frame.origin.y += offset;
            }
            view.frame = frame;
        }
        CGRect frame = alertView.frame;
        frame.origin.y -= roundf(offset/2.0f);
        frame.size.height += offset;
        alertView.frame = frame;
    }else{
        ;
    }
}


@end
