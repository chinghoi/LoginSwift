//
//  ViewController.swift
//  Login
//
//  Created by ChingHoi on 15/7/31.
//  Copyright (c) 2018年 chinghoi. All rights reserved.
//

import UIKit
import LeanCloud

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //点击空白处隐藏键盘(全局)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //此处 ! 其他界面点击空白处会产生崩溃的bug,故修改接口为 ? (可选),见下方接口处
        textFieldUsr?.resignFirstResponder()
        textFieldPasswd?.resignFirstResponder()
    }
    //此处 ! 修改为 ?
    @IBOutlet weak var textFieldUsr: UITextField?
    @IBOutlet weak var textFieldPasswd: UITextField?
    
    //登录
    @IBAction func btnLogin(sender: AnyObject) {
        //点击登录的同时隐藏键盘
        textFieldUsr?.resignFirstResponder()
        textFieldPasswd?.resignFirstResponder()
        //正则匹配是否是手机号
        func checkPhoneNumber(phoneNumber: String) ->Bool {
            let phoneRegex: String = "1[0-9]{10}" //双引号里的1就是第一位必须是1，后续的[0-9]就是纯数字的意思,{10}就是重复10次。10次加上第一位必须为1就是11位手机号的判断。
            let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let isMatch:Bool = pred.evaluate(with: phoneNumber)
            return isMatch;
        }
        
        //判断是用户名和邮箱登录还是手机号登录
        if checkPhoneNumber(phoneNumber: (textFieldUsr?.text)!) {
            //手机号登录
            LCUser.logIn(mobilePhoneNumber: (textFieldUsr?.text)!, password: (textFieldPasswd?.text)!) { result in
                switch result {
                case .success:
                    //跳转页面
                    self.performSegue(withIdentifier: "login", sender: self)
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }else{
            //用户名和邮箱登录
            LCUser.logIn(username: (textFieldUsr?.text)!, password: (textFieldPasswd?.text)!) { result in
                switch result {
                case .success:
                    //跳转页面
                    self.performSegue(withIdentifier: "login", sender: self)
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }
    }
    //注册
    @IBAction func btnRegistered(_ sender: UIButton) {
        //跳转到注册页面
        self.performSegue(withIdentifier: "registered", sender: self)
    }
    
    //授权QQ登录
    @IBAction func qqAuth(sender: UIButton) {
        let qqUser = ShareSDK.currentUser(SSDKPlatformType.typeQQ)
        //不为空直接登录 为空进行注册
        if qqUser?.credential != nil {
            //登录
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeQQ, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    print((user?.credential.uid)!)
                    print((user?.credential.token)!)
                    //登录
                    self.login(username: (user?.credential.uid)!, password: (user?.credential.token)!, tiaozhuan: "loginToQQ")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        } else {
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeQQ, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    print((user?.credential.uid)!)
                    print((user?.credential.token)!)
                    //注册并登录
                    self.registered(username: (user?.credential.uid)!, password: (user?.credential.token)!, tiaozhuan: "loginToQQ")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        }
    }   
    //授权微信登录
    @IBAction func weChatAuth(_ sender: UIButton) {
        let wechatUser = ShareSDK.currentUser(SSDKPlatformType.typeWechat)
        //不为空直接登录 为空进行注册
        if wechatUser?.credential != nil {
            //登录
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    //登录
                    self.login(username: (user?.credential.uid)!, password: "123456", tiaozhuan: "loginToWECHAT")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        } else {
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    //注册并登录
                    self.registered(username: (user?.credential.uid)!, password: "123456", tiaozhuan: "loginToWECHAT")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        }
    }
    
    //授权微博登录
    @IBAction func sinaAuth(_ sender: UIButton) {
        let weiboUser = ShareSDK.currentUser(SSDKPlatformType.typeSinaWeibo)
        //不为空直接登录 为空进行注册
        if weiboUser?.credential != nil {
            //登录
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeSinaWeibo, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    print((user?.credential.uid)!)
                    print((user?.credential.token)!)
                    //登录
                    self.login(username: (user?.credential.uid)!, password: (user?.credential.token)!, tiaozhuan: "loginToWEIBO")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        } else {
            //此方法无论是否授权过,都会进行授权
            ShareSDK.authorize(SSDKPlatformType.typeSinaWeibo, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
                switch state{
                case SSDKResponseState.success:
                    print((user?.credential.uid)!)
                    print((user?.credential.token)!)
                    //注册并登录
                    self.registered(username: (user?.credential.uid)!, password: (user?.credential.token)!, tiaozhuan: "loginToWEIBO")
                case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
                case SSDKResponseState.cancel:  print("操作取消")
                default:
                    break
                }
            })
        }
    }
    
    //取消全部平台授权
    @IBAction func close(_ sender: UIButton) {
        ShareSDK.hasAuthorized(SSDKPlatformType.typeQQ)
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeQQ)
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeWechat)
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeSinaWeibo)
    }
    //获取当前已经授权用户
    @IBAction func searchInfo(_ sender: UIButton) {
        
        let qqUser = ShareSDK.currentUser(SSDKPlatformType.typeQQ)
        let weChatuser = ShareSDK.currentUser(SSDKPlatformType.typeWechat)
        let sinaChatuser = ShareSDK.currentUser(SSDKPlatformType.typeSinaWeibo)
        //防止 ! nil 引起崩溃
        if qqUser?.credential != nil && weChatuser?.credential != nil && sinaChatuser?.credential != nil {
            UIAlertView.init(title: "查询成功", message: "详细请看输出台", delegate: self, cancelButtonTitle: "好的").show()
            print("获取成功,qq用户信息为\(String(describing: (qqUser?.credential)!))")
            print("获取成功,微信用户信息为\(String(describing: (weChatuser?.credential)!))")
            print("获取成功,微博用户信息为\(String(describing: (sinaChatuser?.credential)!))")
        } else {
            UIAlertView.init(title: "查询失败", message: "错误:QQ微信微博至少有一个没登录", delegate: self, cancelButtonTitle: "再试一次").show()
        }
        //        //获取用户授权信息时,若授权,则查询,反之 ,将会跳转到授权页面
        //        ShareSDK.getUserInfo(SSDKPlatformType.typeQQ) { (state: SSDKResponseState, user: SSDKUser?, error: Error?)  ->
        //            Void in
        //            switch state{
        //            case SSDKResponseState.success: print("获取成功,用户信息为\(String(describing: user))\n ----- 获取凭证为\(String(describing: user?.credential))\n----- 验证平台为\(String(describing: user?.verifyType))")
        //            case SSDKResponseState.fail:    print("获取失败,错误描述:\(String(describing: error))")
        //            case SSDKResponseState.cancel:  print("操作取消")
        //            default: break
        //            }
        //        }
    }
//    //SDK达不到使用要求,不能完成第三方登录创建帐号功能,暂时不跳转绑定界面,以下可删除
//    //用户查询类
//    func userFind(uidType: String, uid: String) {
//        //创建查询
//        let query = LCQuery(className: "_User")
//        //创建返回结果
//        var count = 0
//        //包含查询
//        query.whereKey(uidType, .matchedSubstring(uid))
//        //查询"_User"表中 "uid_qq"列是否有匹配的项
//        query.find { result in
//            switch result {
//            // 查询成功 为0时 跳转绑定页面, 非0时 跳转用户中心
//            case .success(let objects):
//                count = objects.count
//                if count != 0 {
//                    //登录并跳转用户中心
//                    let user = ShareSDK.currentUser(SSDKPlatformType.typeQQ).credential.token!
//                    LCUser.logIn(sessionToken: user){ result in  //保存 并返回成功结果
//                        switch result {
//                        case .success:
//                            break
//                        case .failure(let error):
//                            UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "好的").show()
//                        }
//                    }
//                    self.performSegue(withIdentifier: "login", sender: self)
//                } else {
//                    //跳转到绑定页面,进行和服务器帐号绑定
//                    self.performSegue(withIdentifier: "binding", sender: self)
//                }
//                break
//            case .failure(let error):
//                UIAlertView.init(title: "查询绑定信息失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "好的").show()
//            }
//        }
//    }
    //登录方法
    func login(username: String, password: String, tiaozhuan: String) {
        LCUser.logIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("////////////-----------------//////////////////////")
                self.performSegue(withIdentifier: tiaozhuan, sender: self)
                break
            case .failure(let error):
                UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
            }
        }
    }
    //注册
    func registered(username: String, password: String, tiaozhuan: String) {
        //新建一个注册用户信息
        let randomUser = LCUser()
        
        randomUser.username = LCString(username)
        randomUser.password = LCString(password)
        
        //保存用户信息,并判断提示
        randomUser.save { result in
            switch result {
            case .success:
                print("//////////////////////////////////")
                self.login(username: username, password: password, tiaozhuan: tiaozhuan)
            case .failure(let error):
                UIAlertView.init(title: "第一次登录注册失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "好的").show()
            }
        }
    }
}


