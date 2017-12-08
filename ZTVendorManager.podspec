
#https://guides.cocoapods.org/syntax/podspec.html#specification
Pod::Spec.new do |s|
s.name             = "ZTVendorManager"
s.version          = "1.0.1"
s.summary          = "QQ,微信,微博分享&登录；微信支付，支付宝支付 只需一行代码。"
s.description      = <<-DESC
QQ,微信,微博分享&登录；微信支付，支付宝支付,只需一行代码。
QQ, WeChat, Weibo share & login; WeChat payment, Alipay payment, just a line of code.

DESC
s.homepage         = "https://github.com/ShangZhengtao/ZTVendorManager"
#s.screenshots     = "https://raw.githubusercontent.com/icanzilb/EasyAnimation/master/etc/EA.png"
s.license          = 'MIT'
s.author           = { "ShangZhengtao" => "shang2net@163.com" }
s.source           = { :git => "https://github.com/ShangZhengtao/ZTVendorManager.git", :tag => s.version }
#s.social_media_url = 'https://twitter.com/icanzilb'

s.platform     = :ios, '9.0'
s.requires_arc = true

s.source_files = 'ZTVendorManager/**/*.{h,m}'


s.compiler_flags    = '-ObjC'
s.libraries         = 'c++', 'sqlite3', 'z'
s.frameworks        = 'CoreTelephony', 'CoreMotion'
s.vendored_libraries    = 'ZTVendorManager/VendorSDK/UMSocial/UMSocialSDKPlugin/libUMSocialLog.a', 'ZTVendorManager/VendorSDK/QQ/libSocialQQ.a', 'ZTVendorManager/VendorSDK/Sina/libSocialSina.a', 'ZTVendorManager/VendorSDK/WeChat/libSocialWeChat.a', 'ZTVendorManager/VendorSDK/WeChat/WechatSDK/libWeChatSDK.a'
s.vendored_frameworks   = 'ZTVendorManager/VendorSDK/AlipaySDK/AlipaySDK.framework', 'ZTVendorManager/VendorSDK/UMSocial/UMSocialSDK/UMCommon.framework', 'ZTVendorManager/VendorSDK/UMSocial/UMSocialSDK/UMShare.framework'
##资源
s.resources             = ['ZTVendorManager/VendorSDK/AlipaySDK/AlipaySDK.bundle', 'ZTVendorManager/VendorSDK/UMSocial/UMSocialSDKPlugin/UMSocialSDKPromptResources.bundle']
##第三方pod
#s.dependency 'FMDB', '~> 2.5'

end
