//
//  ZTVendorPayModel.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTVendorPayModel : NSObject

/** 支付宝签名串*/
@property (nonatomic, copy) NSString *aliPayOrderString;

/**-----微信----**/
@property (nonatomic, copy) NSString *partnerId;
@property (nonatomic, copy) NSString *prepayId;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *appkey;
@property (nonatomic, copy) NSString *codeUrl;
@property (nonatomic) UInt32 timeStamp;

@end
