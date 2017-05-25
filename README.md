# ZTVendorManager
基于友盟集成QQ，微信 ，微博 分享和登录功能，支付宝和微信支付功能


#### 下载Demo 中的ZTVendorManager 文件夹 拖入项目中

- 配置项目 添加依赖库

</br>

在Other Linker Flags加入-ObjC ，注意不要写为-Objc

</br>

![img](http://upload-images.jianshu.io/upload_images/6145764-ff3f387ca303f9a7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

添加依赖库

![img](http://upload-images.jianshu.io/upload_images/6145764-675298d106978052.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

</br>

![img](http://upload-images.jianshu.io/upload_images/6145764-a3956ad0528dd036.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

没问题的话应该能编译成功了😜

- 配置Info.plist 添加下面代码  配置SSO白名单
</br>

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

- 配置第三方平台URL Scheme 
</br>


| 平台	 |  格式	|  举例	 |  备注 |
|:-----:|:-----:|:-----:|:----:|
| 微信 |  微信appKey	| wxdc1e388c3822c80b | -- |	
| QQ/Qzone	|   需要添加两项URL Scheme：1、"tencent"+腾讯Q互联应用appID</br>2、“QQ”+腾讯QQ互联应用appID转换成十六进制（足8位前面补0）| 	如appID：100424468 </br> 1、tencent100424468</br> 2、QQ05fc5b14|	QQ05fc5b14为100424468转十六进制而来，因不足8位向前补0，然后加"QQ"前缀|
|新浪微博|	“wb”+新浪appKey |	wb3921700954 | -- |

</br>

终于配置完😆

</br>

### 代码部分
</br>

- 替换自己的第三方 appid  和 appkey

```Objective-C
/UMeng https://i.umeng.com
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

```

- 初始化SDK

```Objective-C
#import "ZTVendorManager.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[ZTVendorManager registerVendorSDK];
return YES;
}

```

- 调用

```Objective-C
#import "ZTVendorManager.h"
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
