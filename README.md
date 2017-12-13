# ZTVendorManager
[![Build Status](https://travis-ci.org/devxoul/UITextView-Placeholder.svg?branch=master)]()
[![License](https://img.shields.io/cocoapods/l/ImagePicker.svg?style=flat)]()
![](https://img.shields.io/badge/support-iOS%209.0%2B-green.svg)

基于友盟集成QQ，微信 ，微博 分享和登录功能，支付宝和微信支付功能 不包含IDFA， 适配iPhone X，兼容iOS11

## Requirements

- iOS 9+
- Xcode 9+

## Installation with CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
target 'TargetName' do

pod 'ZTVendorManager'

end

```
## Usage

### 1.配置SSO白名单，在Info.plist中添加下面代码

```HTML

<key>LSApplicationQueriesSchemes</key>
<array>
<string>wechat</string>
<string>weixin</string>
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>sinaweibosso</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkdataline</string>
<string>mqqopensdkgrouptribeshare</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>mqzoneopensdk</string>
<string>wtloginmqq</string>
<string>wtloginmqq2</string>
<string>mqqwpa</string>
<string>mqzone</string>
<string>mqzonev2</string>
<string>mqzoneshare</string>
<string>wtloginqzone</string>
<string>mqzonewx</string>
<string>mqzoneopensdkapiV2</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapi</string>
<string>mqqbrowser</string>
<string>mttbrowser</string>
</array>
<key>LSRequiresIPhoneOS</key>
<true/>
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

```

### 2.配置第三方平台URL Scheme

| 平台	 |  格式	|  举例	 |  备注 |
|:-----:|:-----:|:-----:|:----:|
| 微信 |  微信appKey	| wxdc1e388c3822c80b | -- |	
| QQ/Qzone	|   需要添加两项URL Scheme：1、"tencent"+腾讯Q互联应用appID</br>2、“QQ”+腾讯QQ互联应用appID转换成十六进制（足8位前面补0）| 	如appID：100424468 </br> 1、tencent100424468</br> 2、QQ05fc5b14|	QQ05fc5b14为100424468转十六进制而来，因不足8位向前补0，然后加"QQ"前缀|
|新浪微博|	“wb”+新浪appKey |	wb3921700954 | -- |

### 3.注册SDK

- 初始化SDK

```Objective-C
#import <ZTVendorManager.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self registerVendorSDK];
	return YES;
}

- (void)registerVendorSDK {
		//务必替换为自己的appID和key
    [ZTVendorManager setUmSocialAppkey:kUMAppKey openLog:YES];
    [ZTVendorManager setWechatAppKey:kWeChatAppID appSecret:kWeChatAppSecret];
    [ZTVendorManager setQQAppID:kTencentQQAppID appKey:kTencentQQAppKey];
    [ZTVendorManager setSinaAppKey:kTencentQQAppID appSecret:kTencentQQAppKey redirectURL:kSinaRedirectURL];
}

```

- 调用

```Objective-C
#import <ZTVendorManager.h>
//分享
ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
[ZTVendorManager shareWith:ZTVendorPlatformTypeQQ shareModel:model completionHandler:^(BOOL success, NSError * error) {

}];

```

```Objective-C
//登录
[ZTVendorManager loginWith:ZTVendorPlatformTypeQQ completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
NSLog(@"nickname:%@",model.nickname);
}];

```

```Objective-C
//支付
 ZTVendorPayModel *model = [[ZTVendorPayModel alloc] init];
    model.aliPayOrderString = @"app_id=2016022601164789&biz_content=%7B%22body%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22subject%22%3A%22Mytee%5Cu5546%5Cu57ce%5Cu5546%5Cu54c1%22%2C%22out_trade_no%22%3A%222017052397991011%22%2C%22total_amount%22%3A%22462.08%22%2C%22seller_id%22%3A%22apps%40yunys.com.cn%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22goods_type%22%3A1%7D&format=JSON&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ffashion.apiyys.com%2Fapi%2Fpay%2Falipay-notify&sign=ALod77e%2BlPMRGJlUQB6bLiZxop580a5SLcvIjSFMhnx%2FC4%2FfUXUv7r9seWzjgxA9lv0xwnVW2PdYzWJfKxC5uXtCIrBN4LWmuLN1dk%2FWFyRK12Krz1mPpIucHWY3GO52Ti3ixy4SvDSW%2FhlOU1ap2gNlQIbbGRJyofQu6lnjcq4%3D&sign_type=RSA&timestamp=2017-05-23+16%3A35%3A25&version=1.0";
    [self.payManager payOrderWith:0 orderModel:model payResultBlock:^(BOOL success,NSError *error) {
        if (success) {
            NSLog(@"支付成功");
        }else{
            NSLog(@"%@",error);
        }
    }];

```
## 你的star是我持续更新的动力!

### CocoaPods更新日志

##### 2017.12.13 (tag:1.0.2):

- 不包含IDFA(identifier for advertising)
- iPhone X适配
- 兼容iOS11
- 更新友盟v6.8.0
- 更新支付宝SDK：15.5.0
