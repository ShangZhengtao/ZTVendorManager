//
//  ZTVendorManager.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//  https://github.com/ShangZhengtao/ZTVendorManager.git

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
 友盟SDK 注册

 @param umSocialAppkey 友盟应用Appkey
 */
+ (void)setUmSocialAppkey:(NSString *)umSocialAppkey
                  openLog:(BOOL)isLog;

/**
 微信SDK 注册

 @param appKey appKey
 @param appSecret appSecret
 */
+ (void)setWechatAppKey:(NSString *)appKey
              appSecret:(NSString *)appSecret;

/**
 QQSDK 注册

 @param appID appID
 @param appKey appKey
 */
+ (void)setQQAppID:(NSString *)appID
            appKey:(NSString *)appKey;

/**
 微博SDK 注册

 @param appKey appKey
 @param appSecret appSecret 
 */
+ (void)setSinaAppKey:(NSString *)appKey
            appSecret:(NSString *)appSecret
          redirectURL:(NSString *)url;





/**
 第三方授权登录

 @param platform 第三方平台
 @param handler 回调
 */
+ (void)loginWith:(ZTVendorPlatformType)platform
 completionHandler:(ZTVendorLoginBlock)handler;

/**
 社会化分享

 @param platform 第三方平台
 @param model 分享内容
 @param handler 回调
 */
+ (void)shareWith:(ZTVendorPlatformType)platform
       shareModel:(ZTVendorShareModel *)model
 completionHandler:(ZTVendorShareBlock)handler;

@end
