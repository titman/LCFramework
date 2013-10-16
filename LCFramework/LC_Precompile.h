//
//  LC_Precompile.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-12.
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


//** LCFramework version */
#undef	LC_VERSION
#define LC_VERSION				"0.1.0"

//** settings */
#define LC_LOG_ENABLE		    (1)	// 是否打开LOG
#define LC_LOG_SHOW_FIRST_LINE  (1) // 是否打印框架信息
#define LC_CRASH_REPORT         (1) // 是否打开崩溃记录
#define LC_IAP_ENABLE           (1) // 是否打开内购模块 开启后需要引入StoreKit.framework
#define LC_DEBUG_ENABLE         (1) // 是否打开DEBUG工具 三指上划开启或下划关闭

//** Import */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "LC_Vendor.h"
#import "LC_Foundation.h"
#import "LC_Network.h"
#import "LC_UIView.h"
#import "LC_Database.h"
#import "LC_UIAnimation.h"
#import "LC_Audio.h"

#import "LC_UIApplicationSkeleton.h"

#import <execinfo.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import <TargetConditionals.h>
