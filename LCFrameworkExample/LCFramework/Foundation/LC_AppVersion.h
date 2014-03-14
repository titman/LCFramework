//
//  LC_AppVersion.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//

#import <Foundation/Foundation.h>



@class LC_AppVersion;

typedef enum _LC_APPVERSION_ALERT_STYLE {
    
    LC_APPVERSION_ALERT_STYLE_ALERT = 0,
    LC_APPVERSION_ALERT_STYLE_NOTIFICATION,
    
} LC_APPVERSION_ALERT_STYLE;

typedef void (^LC_AppVersionCheckFinishBlock)( LC_AppVersion * appVersion );
typedef void (^LC_AppVersionUpdateButtonClickBlock)( LC_AppVersion * appVersion );



#pragma mark -



@interface LC_AppVersion : NSObject


@property(nonatomic,retain) NSString * applicationVersion;
@property(nonatomic,retain) NSString * appStoreCountry;


// Action blocks
@property(nonatomic,copy) LC_AppVersionCheckFinishBlock       checkFinishBlock;
@property(nonatomic,copy) LC_AppVersionUpdateButtonClickBlock updateButtonClickBlock;


// Setting UI
@property(assign) BOOL autoPresentedUpdateAlert; //是否自动弹出升级提示框 default is YES
@property(assign) LC_APPVERSION_ALERT_STYLE alertStyle;
@property(nonatomic,retain) NSString * updateButtonTitle;
@property(nonatomic,retain) NSString * cancelButtonTitle;


@property(nonatomic,assign) BOOL hasNewVersion;


// If hasNewVersion is YES
@property(nonatomic,retain) NSString * theNewVersionNumber;
@property(nonatomic,retain) NSString * theNewVersionURL;
@property(nonatomic,retain) NSString * theNewVersionDetails;
@property(nonatomic,retain) NSString * theNewVersionIconURL;


+(LC_AppVersion *) sharedInstance;


+(void) checkForNewVersion;
-(void) checkForNewVersion;

@end
