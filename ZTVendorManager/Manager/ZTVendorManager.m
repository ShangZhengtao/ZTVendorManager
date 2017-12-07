//
//  ZTVendorManager.m
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTVendorManager.h"
#import <UMShare/UMShare.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation ZTVendorManager

+ (void)setUmSocialAppkey:(NSString *)umSocialAppkey openLog:(BOOL)isLog {
    
    [[UMSocialManager defaultManager] openLog:isLog];
    [[UMSocialManager defaultManager] setUmSocialAppkey:umSocialAppkey];
    NSString *alipayVersion = [[AlipaySDK defaultService] currentVersion];
    UMSocialLogInfo(@"支付宝SDK：%@",alipayVersion);
}

+ (void)setWechatAppKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appKey appSecret:appSecret redirectURL:@""];
}

+ (void)setQQAppID:(NSString *)appID appKey:(NSString *)appKey {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appID appSecret:appKey redirectURL:@""];
}

+ (void)setSinaAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)url {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:appKey  appSecret:appSecret redirectURL:url];
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

