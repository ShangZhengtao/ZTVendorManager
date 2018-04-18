//
//  NSObject+AppDelegate.m
//  Share&PayDemo
//
//  Created by apple on 2017/12/12.
//

#import "NSObject+AppDelegate.h"
#import "ZTVendorManager.h"
#import <UMShare/UMShare.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZTWXApiManager.h"
#import <objc/runtime.h>

@implementation NSObject (AppDelegate)

+ (void)load {
    Class appDelegate = NSClassFromString(@"AppDelegate");
    if (appDelegate == nil) {
        NSLog(@" AppDelegate Not Found , ZTVendorManager unavailable !");
        return;
    }
    [self swizzleMethod:appDelegate originmethod:@selector(application:openURL:options:) newMethod:@selector(myApplication:openURL:options:)];
    [self swizzleMethod:appDelegate originmethod:@selector(application:openURL:sourceApplication:annotation:) newMethod:@selector(myApplication:openURL:sourceApplication:annotation:)];
}

+ (void)swizzleMethod:(Class)targetClass originmethod:(SEL) origin newMethod:(SEL) new {
    //获取用户AppDelegate中自己实现的方法
    Method originMethod =  class_getInstanceMethod(targetClass, origin);
    Method newMethod    =  class_getInstanceMethod([self class], new);
    //已经存在返回NO 添加成功返回 YES
    BOOL hasAdd = class_addMethod(targetClass, origin, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (hasAdd) { //原始方法用户自己没有实现，（添加原始方法，具体实现内容为新的方法实现）
        //新方法替换为空实现
        id block = ^BOOL(id self){
            return NO;
        };
        IMP imp =  imp_implementationWithBlock(block);
        class_replaceMethod(targetClass, new, imp, method_getTypeEncoding(newMethod));
    }else { //原始方法存在 （交换新旧方法内部实现）
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
    //分享回调
    BOOL shareResult = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    //微信支付
    BOOL wechatResult = [WXApi handleOpenURL:url delegate:[ZTWXApiManager sharedManager]];
    //其他SDK的回调
    BOOL other = [self myApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return wechatResult || shareResult || other;;
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
    BOOL wechatResult = [WXApi handleOpenURL:url delegate:[ZTWXApiManager sharedManager]];
    //其他SDK的回调
    BOOL other = [self myApplication:app openURL:url options:options];
    return  wechatResult || shareResult || other;
}

@end
