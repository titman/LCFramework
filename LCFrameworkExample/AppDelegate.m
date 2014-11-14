//
//  AppDelegate.m
//  LCFrameworkExample
//
//  Created by 郭历成 ( titm@tom.com ) on 14-2-19.
//  Copyright (c) 2014年 Licheng Guo iOS Developer ( http://nsobject.me ). All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "mach/mach.h"

@implementation AppDelegate

-(void) load
{
    
    // 版本检查
    [LC_AppVersion LCInstance].alertStyle = LC_APPVERSION_ALERT_STYLE_NOTIFICATION;
    [LC_AppVersion checkForNewVersion];
    
    
    
    // 设置全局HUD
    [LC_UIHudCenter setDefaultSuccessIcon:[UIImage imageNamed:@"LC_CheckFinished.png" useCache:YES]];
    [LC_UIHudCenter setDefaultFailureIcon:[UIImage imageNamed:@"LC_Error.png" useCache:YES]];
    //[LC_UIHudCenter setDefaultMessageIcon:(UIImage *)]
    //[LC_UIHudCenter setDefaultBubble:(UIImage *)]
    
    
    
    // 功能
    LC_UINavigationController * demo = [[LC_UINavigationController alloc] initWithRootViewController:[TestViewController viewController]];
    
    //设置tabbar的图片
    [demo setTabBarItemImage:[UIImage imageNamed:@"preferences_normal.png" useCache:YES]
            highlightedImage:[UIImage imageNamed:@"preferences.png" useCache:YES]];
    
    
    
    // LCFramework说明
    LC_UIWebViewController * webView = LC_AUTORELEASE([[LC_UIWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://github.com/titman/LCFramework/blob/master/README.md"]]);
    
    LC_UINavigationController * documents = [[LC_UINavigationController alloc] initWithRootViewController:webView];
    
    //设置tabbar的图片
    [documents setTabBarItemImage:[UIImage imageNamed:@"documents_normal.png" useCache:YES]
                 highlightedImage:[UIImage imageNamed:@"documents.png" useCache:YES]];
    
    
    
    NSArray * viewControllers = @[demo,documents];
    
    LC_RELEASE(demo);
    LC_RELEASE(documents);
    
    
    // TabBarController
    LC_UITabBarController * rootViewContoller = [LC_UITabBarController viewController];
    rootViewContoller.viewControllers = viewControllers;
    
    
    
    self.window.rootViewController = rootViewContoller;
    
}

#define K	(1024)
#define M	(K * 1024)
#define G	(M * 1024)

/** 测试 */
- (void)alloc50M
{
	void * block = NSZoneCalloc( NSDefaultMallocZone(), 50, M );
	if ( nil == block )
	{
		block = NSZoneMalloc( NSDefaultMallocZone(), 50 * M );
	}
	
	if ( block )
	{
		NSMutableArray * array = [[NSMutableArray array] retain];
        [array addObject:[[NSNumber numberWithUnsignedLongLong:(unsigned long long)block] retain]];
	}
}

@end