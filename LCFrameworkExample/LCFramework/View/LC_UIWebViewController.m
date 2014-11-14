//
//  LC_WebViewController.m
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import "LC_UIWebViewController.h"

/* For nextapp */
//#import "FBShimmeringView.h"

#pragma mark - 

@interface LC_UIWebViewController () <UIWebViewDelegate,UIActionSheetDelegate>
{
    //FBShimmeringView * _shimmer;
}

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
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:animated];
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

    
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    if (self.navigationController.viewControllers.count)
    {
        [self showBarButton:NavigationBarButtonTypeLeft
                      title:@""
                      image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
                selectImage:nil];
        
        /* For next app. */
        //[self showBarButton:NavigationBarButtonTypeLeft image:[UIImage imageNamed:@"icon_back.png" useCache:YES] selectImage:nil];
        
        //NA_AUTO_SET_BAR(self.navigationController.navigationBar);

    }
    
    [self setupToolBar];
    
    self.mainWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, IOS7_OR_LATER ? 64 : 44, self.view.viewFrameWidth, self.view.viewFrameHeight - 44 - 40)] autorelease];
    self.mainWebView.delegate = self;
    self.mainWebView.scalesPageToFit = YES;
    
    if (self.URL) {
        [self.mainWebView performSelector:@selector(loadRequest:) withObject:[NSURLRequest requestWithURL:self.URL] afterDelay:0];
    }
    
    if (!IOS7_OR_LATER) {
        
        [self.view addSubview:self.mainWebView];
    }
    else{
        self.view = self.mainWebView;
    }
}

-(void) setShowDismissButton:(BOOL)showDismissButton
{
    if (showDismissButton) {
        [self showBarButton:NavigationBarButtonTypeLeft
                      title:@""
                      image:[UIImage imageNamed:@"navbar_btn_back.png" useCache:YES]
                selectImage:[UIImage imageNamed:@"navbar_btn_back_pressed.png" useCache:YES]];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
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
    
    //[self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
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
            
//            if (!_shimmer) {
//                
//                _shimmer = [[FBShimmeringView alloc] init];
//                _shimmer.frame = CGRectMake(0, 0, self.view.viewFrameWidth, 2);
//                _shimmer.shimmering = YES;
//                _shimmer.shimmeringBeginFadeDuration = 0.3;
//                _shimmer.shimmeringOpacity = 0.3;
//                [self.navigationController.toolbar addSubview:_shimmer];
//                [_shimmer release];
//                
//                UIView * heart = [[UIView alloc] initWithFrame:_shimmer.bounds];
//                heart.backgroundColor = LC_RGB(60, 163, 16);
//                
//                _shimmer.contentView = LC_AUTORELEASE(heart);
//
//            }
        }
            break;
            
        case LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH:
        {
            UIImageView * refreshImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crop_rotate.png" useCache:NO]];
            refreshImage.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshWebView)];
            [refreshImage addGestureRecognizer:tap];
            LC_RELEASE(tap);
            
            UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:refreshImage];
            LC_RELEASE(refreshImage);
            
            self.navigationItem.rightBarButtonItem = item;
            LC_RELEASE(item);
            
            //LC_REMOVE_FROM_SUPERVIEW(_shimmer, YES);
        }
            break;
            
        default:
            break;
    }
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    if (type == NavigationBarButtonTypeLeft) {
        if(![self.navigationController popViewControllerAnimated:YES]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
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
    LC_UIActionSheet * actionSheet = [[LC_UIActionSheet alloc] initWithTitle:@"更多" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拷贝链接",@"在Safari中打开",nil];
    [actionSheet showInView:LC_KEYWINDOW animated:YES];
    LC_RELEASE(actionSheet);
    
    actionSheet.actionBlock = ^(LC_UIActionSheet * sheet, int clickIndex){
        
        if (clickIndex == 0) {
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:[self.mainWebView.request.URL absoluteString]];
            
        }
        else if (clickIndex == 1){
            
            [[UIApplication sharedApplication] openURL:self.mainWebView.request.URL];
            
        }
    };
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
	
    
    NSString * obsolute = URL.absoluteString;
    
    if ([obsolute rangeOfString:@"://"].length) {
        
    }else{

        URL = [NSURL URLWithString:LC_NSSTRING_FORMAT(@"http://%@",obsolute)];
    }
    
    
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



@end
