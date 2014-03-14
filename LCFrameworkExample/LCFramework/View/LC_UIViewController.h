//
//  LC_UIViewController.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-21.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UIViewController : UIViewController

@property (nonatomic,assign) UIView * contentView; //用于无UINavigationController作为容器的viewController中

@end
