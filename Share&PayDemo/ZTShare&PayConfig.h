//
//  ZTShare&PayConfig.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#ifndef ZTShare_PayConfig_h
#define ZTShare_PayConfig_h

//UMeng
static NSString * const kUMAppKey = @"56ab0494e0f55a8fbe003644";

//Vendor: Sina
static NSString * const kSinaAppKey = @"1901241120";
static NSString * const kSinaRedirectURL =  @"http://sns.whalecloud.com/sina2/callback";
static NSString * const kSinaAppSecret = @"d4628c27a9060e6bb16b05803b909424";

//Vendor:Tencnet QQ
static NSString * const kTencentQQAppID = @"1105151880"; //0x41DF4788
static NSString * const kTencentQQAppKey = @"huLVBLX3q86ZsqN5";

//Vendor:WeChat
static NSString * const kWeChatAppID = @"wx9d022487205c4ada";
static NSString * const kWeChatAppSecret = @"d7cc3983cf0782f8511cee3dc5d6c5c0";
static NSString * const kWeChatAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact, snsapi_base";
static NSString * const kWeChatStateCode = @"10017179517";


#endif /* ZTShare_PayConfig_h */
