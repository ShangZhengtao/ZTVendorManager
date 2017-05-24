//
//  ZTShare&PayConfig.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#ifndef ZTShare_PayConfig_h
#define ZTShare_PayConfig_h

//UMeng https://i.umeng.com
static NSString * const kUMAppKey = @"59126acacae7e72a4b001a1c";

//Vendor: Sina http://open.weibo.com
static NSString * const kSinaAppKey = @"427975783";
static NSString * const kSinaRedirectURL =  @"http://sns.whalecloud.com/sina2/callback";
static NSString * const kSinaAppSecret = @"975144dcda0487b4e36a48f85d98c8e0";

//Vendor:Tencnet QQ http://open.qq.com
static NSString * const kTencentQQAppID = @"1105151880"; //0x41DF4788
static NSString * const kTencentQQAppKey = @"huLVBLX3q86ZsqN5";

//Vendor:WeChat  https://open.weixin.qq.com
static NSString * const kWeChatAppID = @"wx9d022487205c4ada";
static NSString * const kWeChatAppSecret = @"d7cc3983cf0782f8511cee3dc5d6c5c0";
static NSString * const kWeChatAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact, snsapi_base";
static NSString * const kWeChatStateCode = @"10017179517";

#endif /* ZTShare_PayConfig_h */
