//
//  ZTVendorManager.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTVendorShareModel.h"
#import "ZTVendorPayModel.h"
#import "ZTVendorAccountModel.h"
#import "ZTVendorPayManager.h"
typedef NS_ENUM(NSInteger,ZTVendorPlatformType)
{
    ZTVendorPlatformTypeSina = 0,
    ZTVendorPlatformTypeWechat = 1,
    ZTVendorPlatformTypeWechatFriends = 2,
    ZTVendorPlatformTypeQQ = 4,
    ZTVendorPlatformTypeQzone = 5
};

typedef void (^ZTVendorLoginBlock)(ZTVendorAccountModel *, NSError *);
typedef void (^ZTVendorShareBlock)(BOOL, NSError *);

@interface ZTVendorManager : NSObject

/**
 通用注册三方SDK方法
 */
+ (void)registerVendorSDK;

/**
 仅集成支付功能调用此方法
 */
+ (void)registerVendorSDKForPay;

/**
 第三方授权登录

 @param platform 第三方平台
 @param handler 回调
 */
+ (void)loginWith:(ZTVendorPlatformType) platform
 completionHandler:(ZTVendorLoginBlock) handler;

/**
 社会化分享

 @param platform 第三方平台
 @param model 分享内容
 @param handler 回调
 */
+ (void)shareWith:(ZTVendorPlatformType) platform
       shareModel:(ZTVendorShareModel *)model
 completionHandler:(ZTVendorShareBlock) handler;

@end
