//
//  ZTVendorShareModel.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTVendorShareModel : NSObject

/**
 缩略图
 */
@property(nonatomic, copy)NSString *thumbURL;

/**
 标题
 */
@property(nonatomic, copy)NSString *title;

/**
 描述
 */
@property(nonatomic, copy)NSString *descr;

/**
 跳转URL
 */
@property(nonatomic, copy)NSString *webURL;

@end
