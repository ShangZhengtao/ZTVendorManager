//
//  ZTVendorManager.m
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTVendorManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ZTVendorManagerConfig.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation ZTVendorManager

+ (void)registerVendorSDK{
    [self configSharePlatforms];
}

//+ (void)registerVendorSDKForLogin{
//    [self configSharePlatforms];
//}
//
//+ (void)registerVendorSDKForShare {
//    [self configSharePlatforms];
//}

+ (void)registerVendorSDKForPay {
    [WXApi registerApp:kWeChatAppID];
}
/**
 设置分享平台appkey
 */
+ (void)configSharePlatforms
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:NO];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMAppKey];
    // 微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWeChatAppID appSecret:kWeChatAppSecret redirectURL:@""];
    // QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kTencentQQAppID appSecret:kTencentQQAppKey redirectURL:@""];
    // 微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppKey  appSecret:kSinaAppSecret redirectURL:kSinaRedirectURL];
}


+ (void)loginWith:(ZTVendorPlatformType)platform
 completionHandler:(ZTVendorLoginBlock)handler {
    NSInteger type = platform;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:[self getCurrentVC] completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        ZTVendorAccountModel *model = [[ZTVendorAccountModel alloc]init];
        model.uid           = resp.uid;
        model.openid        = resp.openid;
        model.accessToken   = resp.accessToken;
        model.refreshToken  = resp.refreshToken;
        model.expiration    = resp.expiration;
        model.nickname      = resp.name;
        model.gender        = resp.unionGender;
        model.iconurl       = resp.iconurl;
        model.originalResponse = resp.originalResponse;
        
        !handler ?: handler(model,error);
    }];
}

+ (void)shareWith:(ZTVendorPlatformType)platform
      shareModel:(ZTVendorShareModel *)model
completionHandler:(ZTVendorShareBlock)handler {
    
    NSInteger type = platform;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.title descr:model.descr thumImage:model.thumbURL];
    shareObject.webpageUrl = model.webURL;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:[self getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            !handler ?: handler(NO,error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            !handler ?: handler(YES,nil);
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
               
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end

