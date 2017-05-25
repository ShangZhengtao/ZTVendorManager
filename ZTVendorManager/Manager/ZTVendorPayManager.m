//
//  ZTPayManager.m
//  AliPayDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTVendorPayManager.h"
#import "ZTVendorPayModel.h"
#import "ZTWXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZTVendorManagerConfig.h"

const NSNotificationName kAlipayResultNotification = @"kAlipayResultNotification";

@interface ZTVendorPayManager ()<WXApiManagerDelegate>
/**
 付款回调
 */
@property (nonatomic ,copy) ZTPayResultBlock payResultBlock;

@end

@implementation ZTVendorPayManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayOrderProcessOrder:) name:kAlipayResultNotification object:nil];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAlipayResultNotification object:nil];
}

+ (void)registerWechatApi {
    [WXApi registerApp:kWeChatAppID];
}

- (void)payOrderWith:(ZTVendorPayMethod)payMethod
          orderModel:(ZTVendorPayModel *)payModel
      payResultBlock:(ZTPayResultBlock) handler{
    __weak typeof(self) weakSelf = self;
    if (payMethod == ZTVendorPayMethodAliPay) { //支付宝支付
        NSString *appScheme = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]; //scheme
        [[AlipaySDK defaultService] payOrder:payModel.aliPayOrderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if (resultDic != nil) { //web回调
                NSError *error;
                NSString *code = [resultDic objectForKey:@"resultStatus"];
                BOOL success = [code isEqualToString:@"9000"];
                if (!success) {
                    NSDictionary *userInfo = @{@"errorInfo": resultDic};
                    error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code: code.integerValue  userInfo:userInfo];
                }
                !handler ?: handler(success,error);
                [weakSelf payCallbackState:success];
            }else { //钱包回调
                _payResultBlock = handler;
            }
            
        }];
    }else if (payMethod == ZTVendorPayMethodWechatPay){ //微信支付
        [self wechatWith:payModel];
        [ZTWXApiManager sharedManager].WXPayResponseBlock = ^(PayResp *response) {
            NSError *error = nil;
            BOOL success = response.errCode == WXSuccess;
            if (!success) {
                NSDictionary *userInfo = @{@"errorInfo": response.errStr};
                error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code:response.errCode userInfo:userInfo];
            }
            !handler ?: handler (success,error);
        };
    }
}

- (void)wechatWith:(ZTVendorPayModel *)model{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = model.partnerId;
    request.openID = model.appid;
    request.prepayId= model.prepayId;
    request.package = model.package;
    request.nonceStr= model.nonceStr;
    request.timeStamp= model.timeStamp;
    request.sign= model.sign;
    [WXApi sendReq:request];
}

//支付宝钱包通知回调
- (void)alipayOrderProcessOrder:(NSNotification *)notification{
    NSDictionary *resultDic = notification.userInfo;
    NSError *error;
    NSString *code = @"500";
    BOOL success = NO;
    if (resultDic != nil) {
        code = [resultDic objectForKey:@"resultStatus"];
        success = [code isEqualToString:@"9000"];
        if (!success) {
            NSDictionary *userInfo = @{@"errorInfo": resultDic};
            error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code: code.integerValue  userInfo:userInfo];
        }
    }
    !_payResultBlock ?: _payResultBlock(success,error);
    [self payCallbackState:success];
}


- (void)payCallbackState:(BOOL)success{
    if (success) {
        NSLog(@"支付成功,等待订单确认");
    }else{
        NSLog(@"支付失败");
    }
}

@end
