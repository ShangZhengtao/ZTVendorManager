//
//  ZTPayManager.h
//  AliPayDemo
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN const NSNotificationName  kAlipayResultNotification;

typedef NS_ENUM(NSInteger,ZTVendorPayMethod)
{
    ZTVendorPayMethodAliPay     = 0,
    ZTVendorPayMethodWechatPay  = 1
};

typedef void(^ZTPayResultBlock)(BOOL success,NSError *);
@class ZTVendorPayModel;
@interface ZTVendorPayManager : NSObject

/**
 注册微信SDK
 */
+ (void)registerWechatApi;
/**
 发起支付

 @param payMethod   付款方式 0 支付宝 1 微信
 @param payModel    付款参数
 @param handler     付款回调
 */
- (void)payOrderWith:(ZTVendorPayMethod) payMethod
          orderModel:(ZTVendorPayModel *)payModel
      payResultBlock:(ZTPayResultBlock)  handler;



@end
