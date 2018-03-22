# LoginSwift
了解一下cocoapods, oc和swift混编的头文件添加方法(项目名-Bridging-Header.h)
第三方登录用到的:
shareSDK swift 集成文档 http://wiki.mob.com/ios%E7%AE%80%E6%B4%81%E7%89%88%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90/
[通用问题] ShareSDK各社交平台申请APPkey 的网址及申请流程汇总http://bbs.mob.com/forum.php?mod=viewthread&tid=275&page=1&extra=#pid860
(具体看QQ微信微博的申请添加方法)

注册帐号登录用到的:
LeanCloud    Swift SDK 安装指南 https://leancloud.cn/docs/sdk_setup-swift.html
swift版的SDK不支持第三方登录,集成oc版的第三方登录(SNS)时,遇到pod不上,删除pods文件夹和Podfile.lock,重新运行pod install --verbose(提前cd到项目所在跟目录)
数据存储开发指南 https://leancloud.cn/docs/leanstorage_guide-swift.html

错误码详解 https://leancloud.cn/docs/error_code.html
其中经常遇到网路故障,重现率很高也是swift版SDK的问题(官方建议用oc版)

