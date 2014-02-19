//
//  LC_IAP.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-8.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#if defined(LC_IAP_ENABLE) && LC_IAP_ENABLE

#import "LC_IAP.h"
#import <StoreKit/StoreKit.h>

#define AuthenticationServer @"https://buy.itunes.apple.com/verfyReceipt"

#pragma mark -

@interface LC_IAP ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property(nonatomic,retain) SKProductsRequest * productsRequest;
@property(nonatomic,retain) NSString * productsIdentfiter;
@property(nonatomic,assign) BOOL isProcessing;
@property(nonatomic,assign) LC_UIHud * hud;

@end

#pragma mark -

@implementation LC_IAP

-(void) dealloc
{
    self.payFinishedBlock = nil;
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    LC_RELEASE(_productsIdentfiter);
    LC_RELEASE(_productsRequest);
    
    [super dealloc];
}

+ (LC_IAP *)sharedInstance
{
    static dispatch_once_t once;
    static LC_IAP * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

-(id) init
{
    self = [super init];
    
    if (self) {
        
        self.openTheSecondValidation = YES;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}

-(void) buyProductWithIdentifier:(NSString *)identifier
{
    //检查网络
    if ([[LC_Network sharedInstance] isNetwork] == NO) {
        [LC_UIAlertView showMessage:LC_LO(@"请检查网络") cancelTitle:LC_LO(@"确定")];
        return;
    }
    
    //检测标示符
    if (LC_NSSTRING_IS_INVALID(identifier)) {
        [LC_UIAlertView showMessage:LC_LO(@"标示符是无效的") cancelTitle:LC_LO(@"确定")];
        return;
    }
    
    //检测用户设置状态
    if ([SKPaymentQueue canMakePayments] == NO){
        [LC_UIAlertView showMessage:LC_LO(@"该用户禁止应用内付费") cancelTitle:LC_LO(@"确定")];
        return;
    }
    
    //检测状态
    if (self.isProcessing) {
        [LC_UIAlertView showMessage:LC_LO(@"正在处理上一次购买") cancelTitle:LC_LO(@"确定")];
        return;
    }
    
    //开始获取商品信息
    _isProcessing = YES;
    self.productsIdentfiter = identifier;
    
    [self getProductInfoWithIdentifier:identifier];
    
    //状态框
    self.hud = [self showLoadingHud:LC_LO(@"正在请求商品...")];
    self.hud.dimBackground = YES;
}

-(void) getProductInfoWithIdentifier:(NSString *)identfier
{
    NSSet * set = [NSSet setWithObjects:identfier,nil];
    self.productsRequest = [[[SKProductsRequest alloc] initWithProductIdentifiers:set] autorelease];
    self.productsRequest.delegate = self;
    [self.productsRequest start];
}

#pragma mark -

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    self.hud.detailsLabelText = LC_LO(@"正在购买商品,请保持网络畅通...");
    
    NSArray * myProduct = response.products;
    
    if (myProduct.count == 0) {
        
        [LC_UIAlertView showMessage:LC_LO(@"不能获取到该商品的信息,购买失败") cancelTitle:LC_LO(@"确定")];
        [self.hud hide:YES];
        self.hud = nil;
        
        _isProcessing = NO;
        return;
    }
    
    //开始内购
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    [LC_UIAlertView showMessage:[error localizedDescription] cancelTitle:LC_LO(@"确定")];
    [self.hud hide:YES];
    self.hud = nil;
    
    _isProcessing = NO;
}

-(void) requestDidFinish:(SKRequest *)request
{
    ;
}

#pragma mark -

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
                //交易完成
            case SKPaymentTransactionStatePurchased:
                
                if (self.openTheSecondValidation) {
                    [self completeTransaction:transaction];
                }else{
                    if (self.payFinishedBlock) {
                        self.payFinishedBlock(self,NO,YES,transaction.error,transaction);
                    }
                }
                
                break;
                
                //交易失败
            case SKPaymentTransactionStateFailed:
                
                [self failedTransaction:transaction];
                
                break;
                
                //已经购买过该商品
            case SKPaymentTransactionStateRestored:
                
                //[self restoreTransaction:transaction];
                
                //商品添加进列表
            case SKPaymentTransactionStatePurchasing:
                
                break;
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    _isProcessing = NO;
    [self.hud hide:YES];
    self.hud = nil;
    
    
    NSString * product = transaction.payment.productIdentifier;
    
    //标示符长度必须大于0
    if ([product length] > 0) {
        
        //标示符必须符合格式: com.wuxiantai.wuxianchang.xxx
        NSArray * components = [product componentsSeparatedByString:@"."];
        
        if (components.count >= 4) {
            
            //进行二次订单验证
            if ([self putStringToItunes:transaction.transactionReceipt url:AuthenticationServer]) {
                
                //购买成功
                if (self.payFinishedBlock) {
                    self.payFinishedBlock(self,NO,YES,nil,transaction);
                }
                
            }
            else
            {
                //再次进行沙盒验证
                if ([self putStringToItunes:transaction.transactionReceipt url:@"https://sandbox.itunes.apple.com/verifyReceipt"])
                {
                    //购买成功
                    if (self.payFinishedBlock) {
                        self.payFinishedBlock(self,YES,YES,nil,transaction);
                    }
                }else
                {
                    //验证未通过 （作弊程序）
                    [LC_UIAlertView showMessage:LC_LO(@"购买失败") cancelTitle:LC_LO(@"确定")];
                    
                    if (self.payFinishedBlock) {
                        self.payFinishedBlock(self,NO,NO,[NSError errorWithDomain:@"LCFramewordk : 内购订单验证失败。(可能为作弊程序)" code:10000 userInfo:nil],transaction);
                    }
                }
            }
        }
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    
    _isProcessing = NO;
    [self.hud hide:YES];
    self.hud = nil;
    
    [LC_UIAlertView showMessage:LC_NSSTRING_FORMAT(@"%@ : %@",LC_LO(@"购买失败"),transaction.error) cancelTitle:@"确定"];
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        ;
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    if (self.payFinishedBlock) {
        self.payFinishedBlock(self,NO,NO,transaction.error,transaction);
    }
}

//验证
-(BOOL) putStringToItunes:(NSData*) iapData url:(NSString *)URL{
    
    NSString * encodingStr = [ASIHTTPRequest base64forData:iapData];
    
    NSMutableURLRequest * request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [encodingStr length]] forHTTPHeaderField:@"Content-Length"];
    
    NSDictionary * body = [NSDictionary dictionaryWithObjectsAndKeys:encodingStr, @"receipt-data", nil];
    [request setHTTPBody:[[body JSONString] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSHTTPURLResponse * urlResponse=nil;
    NSError * errorr=nil;
    NSData * receivedData = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&urlResponse
                                                              error:&errorr];
    
    //解析
    NSString * results = [[[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSDictionary * dic = [results objectFromJSONString];
    
    if([dic objectForKey:@"status"]){
        
        // status= @"0" 是验证收据成功
        if ([[dic objectForKey:@"status"] integerValue] == 0) {
            
            return true;
            
        }
    }
    
    return false;
}


@end

#endif
