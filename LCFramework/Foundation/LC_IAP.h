//
//  LC_IAP.h
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
