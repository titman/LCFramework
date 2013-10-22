//
//  LC_WebViewController.m
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

#import "LC_UIWebViewController.h"

#pragma mark - 

@interface LC_UIWebViewController () <UIWebViewDelegate,UIActionSheetDelegate>

@end

#pragma mark -

@implementation LC_UIWebViewController

-(void) dealloc
{
    LC_RELEASE(_URL);
    LC_SUPER_DEALLOC();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (id)initWithAddress:(NSString *)urlString
{
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL*)pageURL
{
    LC_SUPER_INIT({
            
        self.URL = pageURL;
    
    });
}

-(id)init
{
    LC_SUPER_INIT({

        ;
    
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    if (self.navigationController.viewControllers.count && [self.navigationController.viewControllers objectAtIndex:0] != self)
    {
        [self showBarButton:NavigationBarButtonTypeLeft
                      title:@""
                      image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
                selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    }
    
    [self setupToolBar];
    
    self.mainWebView = [[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.mainWebView.delegate = self;
    self.mainWebView.scalesPageToFit = YES;
    
    if (self.URL) {
        [self.mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }
    
    self.view = self.mainWebView;
}

-(void) setupToolBar
{
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LC_WebBack.png" useCache:NO]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(goBackClicked)];
    
    UIBarButtonItem * forwardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LC_WebForward.png" useCache:NO]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(goForwardClicked)];
    
    UIBarButtonItem * actionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                          target:self
                                                                                          action:@selector(actionButtonClicked)];

    UIBarButtonItem * flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    
    NSArray * items = @[flexItem,backItem,flexItem,forwardItem,flexItem,actionItem,flexItem];
    LC_RELEASE(backItem);
    LC_RELEASE(forwardItem);
    LC_RELEASE(actionItem);
    LC_RELEASE(flexItem);
    
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    self.toolbarItems = items;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    [self setLoadingState:LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH];
}

-(void) setLoadingState:(LC_UIWEBVIEW_STATE_BUTTON_TYPE)type
{
    switch (type) {
            
        case LC_UIWEBVIEW_STATE_BUTTON_TYPE_LOADING:
        {
            LC_UIActivityIndicatorView * activity = [LC_UIActivityIndicatorView grayActivityIndicatorView];
            [activity startAnimating];

            [self showBarButton:NavigationBarButtonTypeRight custom:activity];
        }
            break;
            
        case LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH:
        {
            UIImageView * refreshImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LC_WebReload.png" useCache:NO]];
            refreshImage.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshWebView)];
            [refreshImage addGestureRecognizer:tap];
            LC_RELEASE(tap);
            
            UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:refreshImage];
            LC_RELEASE(refreshImage);
            
            self.navigationItem.rightBarButtonItem = item;
            LC_RELEASE(item);
        }
            break;
            
        default:
            break;
    }
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

-(void) goBackClicked
{
    [_mainWebView goBack];

}

-(void) goForwardClicked
{
    [_mainWebView goForward];
}

-(void) actionButtonClicked
{
    LC_UIActionSheet * actionSheet = [[LC_UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拷贝链接",@"在Safari中打开",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.navigationController.view animated:YES];
    LC_RELEASE(actionSheet);
}

-(void) refreshWebView
{
    if (self.mainWebView.request.URL) {
        [self setURL:self.mainWebView.request.URL];
    }
}

- (void)setHtml:(NSString *)string
{
	[_mainWebView loadHTMLString:string baseURL:nil];
}

- (void)setFile:(NSString *)path
{
	NSData * data = [NSData dataWithContentsOfFile:path];
    
	if ( data )
	{
		[_mainWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
	}
}

- (void)setResource:(NSString *)path
{
	NSString * extension = [path pathExtension];
	NSString * fullName = [path substringToIndex:(path.length - extension.length - 1)];
    
	NSString * path2 = [[NSBundle mainBundle] pathForResource:fullName ofType:extension];
	NSData * data = [NSData dataWithContentsOfFile:path2];
    
	if ( data )
	{
		[_mainWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF8" baseURL:nil];
	}
}

- (void)setURL:(NSURL *)URL
{
	if ( nil == URL )
		return;
	
    if (_URL) {
        [_URL release];
    }
    
    _URL = [URL retain];
    
	NSArray * cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
	for ( NSHTTPCookie * cookie in cookies ){
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
	
	[_mainWebView loadRequest:[NSURLRequest requestWithURL:URL]];
}

#pragma mark -

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self setLoadingState:LC_UIWEBVIEW_STATE_BUTTON_TYPE_LOADING];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self setLoadingState:LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self setLoadingState:LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH];
}

#pragma mark -

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    if (buttonIndex == 0) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:[self.mainWebView.request.URL absoluteString]];
        
    }
    else if (buttonIndex == 1){

        [[UIApplication sharedApplication] openURL:self.mainWebView.request.URL];
        
    }

}












@end
