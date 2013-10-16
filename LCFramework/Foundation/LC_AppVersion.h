//
//  LC_AppVersion.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
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
