//
//  LC_SystemInfo.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import "LC_Precompile.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

    #define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
    #define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
    #define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
    #define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
    #define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#else

    #define IOS7_OR_LATER   (NO)
    #define IOS6_OR_LATER	(NO)
    #define IOS5_OR_LATER	(NO)
    #define IOS4_OR_LATER	(NO)
    #define IOS3_OR_LATER	(NO)

#endif

@interface LC_SystemInfo : NSObject

+ (NSString *)appVersion;
+ (NSString *)appIdentifier;
+ (NSString *)deviceModel;
+ (NSString *)deviceUUID;

+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;

+ (BOOL)isPhone35;
+ (BOOL)isPhoneRetina35;
+ (BOOL)isPhoneRetina4;
+ (BOOL)isPad;
+ (BOOL)isPadRetina;
+ (BOOL)isScreenSize:(CGSize)size;

//** 模拟内存警告 */
+ (void)simulateLowMemoryWarning;

//** 程序运行次数 */
+ (int) applicationRunsNumber;

//** CPU占用 */
+ (float) applicationCUPUsage;

//** 可用内存 */
+ (unsigned long long) bytesOfFreeMemory;

//** 使用内存 */
+ (unsigned long long) bytesOfUsedMemory;

//** 最大内存 */
+ (unsigned long long) bytesOfTotalMemory;


@end
