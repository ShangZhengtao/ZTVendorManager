//
//  ZTVendorAccountModel.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTVendorAccountModel : NSObject

@property(nonatomic, copy) NSString  *nickname;
@property(nonatomic, copy) NSString  *iconurl;
@property(nonatomic, copy) NSString  *gender;

@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *openid;
@property(nonatomic, copy) NSString *accessToken;
@property(nonatomic, copy) NSString *refreshToken;
@property(nonatomic, strong) NSDate *expiration;
//第三方原始数据
@property(nonatomic, strong) id originalResponse;

@end
