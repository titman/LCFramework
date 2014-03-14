//
//  LC_IAP.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page ( http://nsobject.me/copyright.rtf ).
//
//
//  暂不支持商品恢复
//  收据验证开启时,将会用返回的凭证在Apple服务器进行验证。

#import <Foundation/Foundation.h>

#if defined(LC_IAP_ENABLE) && LC_IAP_ENABLE

@class LC_IAP;
@class SKPaymentTransaction;

typedef void (^LC_IAP_PAY_FINISHEDBLOCK)( LC_IAP * iap, BOOL isSanbox, BOOL paySuccessed, NSError * error,SKPaymentTransaction * transaction); /** transaction.transactionReceipt is the receipt */

@interface LC_IAP : NSObject

/** 开启后将进行收据验证 default is YES */
@property(nonatomic,assign) BOOL openTheSecondValidation;

@property(nonatomic,copy) LC_IAP_PAY_FINISHEDBLOCK payFinishedBlock;

+(LC_IAP *) sharedInstance;

-(void) buyProductWithIdentifier:(NSString *)identifier;

@end

#endif
