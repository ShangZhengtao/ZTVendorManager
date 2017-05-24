//
//  ZTVendorShareModel.m
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTVendorShareModel.h"

@implementation ZTVendorShareModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"请设置分享标题";
        self.descr = @"请设置分享内容描述";
        self.webURL = @"https://www.baidu.com";
        self.thumbURL = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    }
    return self;
}
@end
