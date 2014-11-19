//
//  LC_View.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//


// Application default config
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_COLOR        LC_RGB(56, 56, 56)
#define LC_UINAVIGATIONBAR_DEFAULT_TITLE_SHADOW_COLOR LC_RGBA(0, 0, 0, 0)
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_BEFORE  nil//[UIImage imageNamed:@"LC_navbar_bg.png" useCache:YES]
#define LC_UINAVIGATIONBAR_DEFAULT_IMAGE_IOS7_LATER   nil//[UIImage imageNamed:@"LC_ios7_navbar_bg.png" useCache:YES]

#define LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR        [UIColor darkGrayColor]

#define LC_UIPULLLOADER_DEFAULT_HEIGHT (45.f)

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
#import "LC_UIPropertyPicker.h"
#import "LC_UIScrollView.h"
#import "LC_UITextField.h"
#import "LC_UIKeyBoard.h"
#import "LC_UIViewBuilder.h"
#import "LC_UICollectionView.h"
#import "LC_UICollectionViewController.h"

#import "UIViewController+LCUINavigationBar.h"
#import "UIViewController+LCTabBar.h"
#import "UIViewController+LCTitle.h"
#import "UIViewController+LCLayout.h"
#import "UIImage+LCExtension.h"
#import "UIView+LCUIViewFrame.h"
#import "UIColor+LCExtension.h"
#import "NSObject+LCHud.h"
#import "UIView+LCExtension.h"
#import "UIView+LCBackground.h"
#import "UIView+LCTag.h"
#import "UIView+LCGesture.h"
#import "UITabBarItem+LCExtension.h"
#import "UINavigationController+LCExtension.h"
#import "UIView+LCScreenShot.h"
#import "UIApplication+LCPersentViewController.h"
#import "UIImageView+LCExtension.h"



