//
//  AppDelegate+ZTVendorHelper.m
//  Share&PayDemo
//
//  Created by apple on 2017/5/24.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "AppDelegate+ZTVendorHelper.h"
#import "ZTVendorManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZTWXApiManager.h"
#import <objc/runtime.h>
@implementation AppDelegate (ZTVendorHelper)

+ (void)load{
    [super load];
    [self swizzleMethod:self originmethod:@selector(application:openURL:options:) newMethod:@selector(myApplication:openURL:options:)];
    [self swizzleMethod:self originmethod:@selector(application:openURL:sourceApplication:annotation:) newMethod:@selector(myApplication:openURL:sourceApplication:annotation:)];
}

+ (void)swizzleMethod:(Class)targetClass originmethod:(SEL) origin newMethod:(SEL) new{
    Method originMethod =  class_getInstanceMethod(targetClass, origin);
    Method newMethod = class_getInstanceMethod(targetClass, new);
    //已经存在返回NO 添加成功返回 YES
    BOOL hasAdd = class_addMethod(targetClass, origin, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (hasAdd) {
        //原始方法的实现不存在 被添加上新的方法实现 新方法替换为空实现
        id block = ^BOOL(id self){
            return NO;
        };
        IMP imp =  imp_implementationWithBlock(block);
        class_replaceMethod(targetClass, new, imp, method_getTypeEncoding(originMethod));
    }else {
        method_exchangeImplementations(originMethod, newMethod);
    }
}

// iOS9 之前系统
- (BOOL)myApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayResultNotification object:nil userInfo:resultDic];
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他SDK的回调
        return [self myApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)myApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayResultNotification object:nil userInfo:resultDic];
            NSLog(@"result = %@",resultDic);
        }];
    }
    //分享回调
    BOOL shareResult = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    //微信
    BOOL wecharResult = [WXApi handleOpenURL:url delegate:[ZTWXApiManager sharedManager]];
    BOOL other = [self myApplication:app openURL:url options:options];
    return  wecharResult || shareResult || other;
}


@end
