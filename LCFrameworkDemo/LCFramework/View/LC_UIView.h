//
//  LC_View.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
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


// Application default config
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_COLOR        LC_COLOR_W_RGB(101, 104, 107, 1)
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_SHADOW_COLOR LC_COLOR_W_RGB(0, 0, 0, 0)
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE  [UIImage imageNamed:@"LC_navbar_bg.png" useCache:YES]
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER   [UIImage imageNamed:@"LC_ios7_navbar_bg.png" useCache:YES]

#define LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR        [UIColor darkGrayColor]

#define LC_UIPULLLOADER_DEFAULT_HEIGHT (30.f)

#define LC_TABLE_DEFAULT_STYLE            (UITableViewStyleGrouped)
#define LC_TABLE_DEFAULT_BACKGROUND_COLOR ([UIColor whiteColor])

// import
#import "LC_UIButton.h"
#import "LC_UINavigationController.h"
#import "LC_UIViewController.h"
#import "LC_UINavigationNotificationView.h"
#import "LC_UIPullLoader.h"
#import "LC_UITableView.h"
#import "LC_UITableViewCell.h"
#import "LC_UITableViewController.h"
#import "LC_UIActivityIndicatorView.h"
#import "LC_UIActionSheet.h"
#import "LC_UILabel.h"
#import "LC_UIWebViewController.h"
#import "LC_UIBadgeView.h"
#import "LC_UIImageView.h"
#import "LC_UIAlertView.h"
#import "LC_UIHud.h"
#import "LC_UITextView.h"
#import "LC_UIGraphView.h"
#import "LC_UITabBar.h"
#import "LC_UITabBarController.h"
#import "LC_UISideMenu.h"
#import "LC_UIImagePickerViewController.h"

#import "UIViewController+UINavigationBar.h"
#import "UIViewController+TabBar.h"
#import "UIViewController+Title.h"
#import "UIViewController+Layout.h"
#import "UIImage+Extension.h"
#import "UIView+UIViewFrame.h"
#import "UIColor+Extension.h"
#import "NSObject+Hud.h"
#import "UIView+Extension.h"
#import "UIView+Background.h"
#import "UIView+Tag.h"
#import "UIView+TapGesture.h"
#import "UITabBarItem+Extension.h"


@interface LC_UIView : UIView



@end
