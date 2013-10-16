//
//  LC_WebViewController.h
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

#import "LC_UIViewController.h"

typedef enum _LC_UIWEBVIEW_STATE_BUTTON_TYPE{

    LC_UIWEBVIEW_STATE_BUTTON_TYPE_LOADING = 0,
    LC_UIWEBVIEW_STATE_BUTTON_TYPE_REFRESH

}LC_UIWEBVIEW_STATE_BUTTON_TYPE;

@interface LC_UIWebViewController : LC_UIViewController

@property (nonatomic, assign) UIWebView *  mainWebView;
@property (nonatomic, retain) NSURL * URL;

- (id)initWithAddress:(NSString *) urlString;
- (id)initWithURL:(NSURL *) pageURL;

- (void)setHtml:(NSString *)string;
- (void)setFile:(NSString *)path;
- (void)setResource:(NSString *)path;

@end
