//
//  LC_Precompile.h
//  LCFramework

//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-9-12.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//


//** LCFramework version */
#undef	LC_VERSION
#define LC_VERSION				"0.1.3"

//** settings */
#define LC_LOG_ENABLE		     (1) // 是否打开LOG
#define LC_CRASH_REPORT_ENABLE   (1) // 是否打开崩溃记录
#define LC_IAP_ENABLE            (0) // 是否打开内购模块 开启后需要引入StoreKit.framework
#define LC_AUDIO_ENABLE          (1) // 是否打开音频模块 开启后需要引入AVFoundation.framework
#define LC_DEBUG_ENABLE          (1) // 是否打开DEBUG工具 二指上划开启或下划关闭
#define LC_ERROR_FILE_LOG_ENABLE (0) // 是否将ERROR保存至本地

//** Import */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "LC_Vendor.h"
#import "LC_Foundation.h"
#import "LC_Network.h"
#import "LC_UISignal.h"
#import "LC_UIView.h"
#import "LC_Database.h"
#import "LC_UIAnimation.h"
#import "LC_Audio.h"

#import "LC_UIApplication.h"

#import <execinfo.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import <TargetConditionals.h>
#import "NSObject+LCProperty.h"
