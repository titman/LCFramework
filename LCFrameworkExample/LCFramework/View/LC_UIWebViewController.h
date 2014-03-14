//
//  LC_WebViewController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIViewController.h"

typedef enum _LC_UIWEBVIEW_STATE_BUTTON_TYPE{

    LC_UIWEBVIEW_STATE_BUTTON_TYPE_LOADING = 0,
    LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH

}LC_UIWEBVIEW_STATE_BUTTON_TYPE;

@interface LC_UIWebViewController : LC_UIViewController

@property (nonatomic, assign) UIWebView *  mainWebView;
@property (nonatomic, retain) NSURL * URL;
@property (nonatomic, assign) BOOL showDismissButton;

- (id)initWithAddress:(NSString *) urlString;
- (id)initWithURL:(NSURL *) pageURL;

- (void)setHtml:(NSString *)string;
- (void)setFile:(NSString *)path;
- (void)setResource:(NSString *)path;

@end
