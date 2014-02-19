//
//  LC_View.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//


// Application default config
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_COLOR        LC_COLOR_W_RGB(101, 104, 107, 1)
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_SHADOW_COLOR LC_COLOR_W_RGB(0, 0, 0, 0)
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE  [UIImage imageNamed:@"LC_navbar_bg.png" useCache:YES]
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER   [UIImage imageNamed:@"LC_ios7_navbar_bg.png" useCache:YES]

#define LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR        [UIColor darkGrayColor]

#define LC_UIPULLLOADER_DEFAULT_HEIGHT (30.f)

#define LC_TABLE_DEFAULT_STYLE            (UITableViewStyleGrouped)
#define LC_TABLE_DEFAULT_BACKGROUND_COLOR ([UIColor whiteColor])


@interface LC_UIView : UIView



@end


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
#import "LC_UITopNotificationView.h"
#import "LC_UISearchBar.h"
#import "LC_UITapMaskView.h"
#import "LC_UIBlurView.h"


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
#import "UINavigationController+Extension.h"
