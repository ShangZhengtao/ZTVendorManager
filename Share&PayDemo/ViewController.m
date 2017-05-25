//
//  ViewController.m
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ViewController.h"
#import "ZTVendorManager.h"
//app_id=2016022601164789&biz_content=%7B%22body%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22subject%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22out_trade_no%22%3A%222017052397991011%22%2C%22total_amount%22%3A%22462.08%22%2C%22seller_id%22%3A%22apps%40yunys.com.cn%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22goods_type%22%3A1%7D&format=JSON&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ffashion.apiyys.com%2Fapi%2Fpay%2Falipay-notify&sign=ALod77e%2BlPMRGJlUQB6bLiZxop580a5SLcvIjSFMhnx%2FC4%2FfUXUv7r9seWzjgxA9lv0xwnVW2PdYzWJfKxC5uXtCIrBN4LWmuLN1dk%2FWFyRK12Krz1mPpIucHWY3GO52Ti3ixy4SvDSW%2FhlOU1ap2gNlQIbbGRJyofQu6lnjcq4%3D&sign_type=RSA&timestamp=2017-05-23+16%3A35%3A25&version=1.0

@interface ViewController ()
@property (nonatomic, strong) ZTVendorPayManager *payManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payManager = [[ZTVendorPayManager alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//支付
- (IBAction)aliPayButtonTapped:(UIButton *)sender {
    
    ZTVendorPayModel *model = [[ZTVendorPayModel alloc] init];
    model.aliPayOrderString = @"app_id=2016022601164789&biz_content=%7B%22body%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22subject%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22out_trade_no%22%3A%222017052397991011%22%2C%22total_amount%22%3A%22462.08%22%2C%22seller_id%22%3A%22apps%40yunys.com.cn%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22goods_type%22%3A1%7D&format=JSON&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ffashion.apiyys.com%2Fapi%2Fpay%2Falipay-notify&sign=ALod77e%2BlPMRGJlUQB6bLiZxop580a5SLcvIjSFMhnx%2FC4%2FfUXUv7r9seWzjgxA9lv0xwnVW2PdYzWJfKxC5uXtCIrBN4LWmuLN1dk%2FWFyRK12Krz1mPpIucHWY3GO52Ti3ixy4SvDSW%2FhlOU1ap2gNlQIbbGRJyofQu6lnjcq4%3D&sign_type=RSA&timestamp=2017-05-23+16%3A35%3A25&version=1.0";
    [self.payManager payOrderWith:0 orderModel:model payResultBlock:^(BOOL success,NSError *error) {
        if (success) {
            NSLog(@"支付成功");
        }else{
            NSLog(@"%@",error);
        }
    }];
}


- (IBAction)wechatPayButtonTapped:(UIButton *)sender {
    
    ZTVendorPayModel *model = [[ZTVendorPayModel alloc] init];
    model.timeStamp = 1495528775;
    model.partnerId = @"1315923801";
    model.prepayId = @"wx2017052316393786541b3d9f0025699422";
    model.package = @"Sign=WXPay";
    model.nonceStr = @"0dafe2cad92c228816a13add3c08108d";
    model.sign = @"B765700116024576DCB656DB8D9B305C";
    model.appid = @"wx9d022487205c4ada";
    [self.payManager payOrderWith:1 orderModel:model payResultBlock:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"支付成功");
        }else{
            NSLog(@"%@",error);
        }
        
    }];
}

//分享
- (IBAction)QQshareButtonTapped:(UIButton *)sender {
    ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
    [ZTVendorManager shareWith:ZTVendorPlatformTypeQQ shareModel:model completionHandler:^(BOOL success, NSError * error) {
        
    }];
}
- (IBAction)wechatShareButtonTapped:(UIButton *)sender {
    ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
    [ZTVendorManager shareWith:ZTVendorPlatformTypeWechat shareModel:model completionHandler:^(BOOL success, NSError * error) {
        
    }];
}

- (IBAction)sinaShareButtonTapped:(UIButton *)sender {
    ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
    [ZTVendorManager shareWith:ZTVendorPlatformTypeSina shareModel:model completionHandler:^(BOOL success, NSError * error) {
        
    }];
    
}

//登录
- (IBAction)QQloginin:(UIButton *)sender {
    [ZTVendorManager loginWith:ZTVendorPlatformTypeQQ completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
    
}

- (IBAction)wechatLogin:(UIButton *)sender {
    [ZTVendorManager loginWith:ZTVendorPlatformTypeWechat completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
}

- (IBAction)sinaLogin:(UIButton *)sender {
    [ZTVendorManager loginWith:ZTVendorPlatformTypeSina completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
}

@end
