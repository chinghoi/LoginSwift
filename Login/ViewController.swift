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
    //点击空白处隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        textFieldUsr?.resignFirstResponder()
        textFieldPasswd?.resignFirstResponder()
    }
    
    @IBOutlet weak var textFieldUsr: UITextField?
    
    @IBOutlet weak var textFieldPasswd: UITextField?
    
    //登录相关
    @IBAction func btnLogin(sender: AnyObject) {
        //MARK:- 正则匹配是否是email
        func checkEmail(phoneNumber: NSString) ->Bool {
            let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
            let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let isMatch:Bool = pred.evaluate(with: phoneNumber)
            return isMatch;
        }
        
        //判断是用户名登录还是手机号登录
        if checkEmail(phoneNumber: "\(String(describing: textFieldUsr?.text))" as NSString) {
            //手机号登录
            LCUser.logIn(mobilePhoneNumber: "13577778888", password: "leancloud") { result in
                switch result {
                case .success:
                    self.performSegue(withIdentifier: "login", sender: self)  //跳转页面
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }else{
            //用户名登录
            LCUser.logIn(username: (textFieldUsr?.text)!, password: (textFieldPasswd?.text)!) { result in
                switch result {
                case .success:
                    self.performSegue(withIdentifier: "login", sender: self)  //跳转页面
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }
    }
    //进行跳转到注册页面
    @IBAction func btnRegistered(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registered", sender: self)
    }
    
    @IBAction func sinaAuth(_ sender: UIButton) {
        //获取授权
        ShareSDK.getUserInfo(SSDKPlatformType.typeSinaWeibo) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
            switch state{
            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.uid))")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
            default:
                break
            }
        }
    }
    @IBAction func weChatAuth(_ sender: UIButton) {
        //获取授权
        ShareSDK.getUserInfo(SSDKPlatformType.typeWechat) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
            switch state{
            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.uid))")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
            default:
                break
            }
        }
    }
    
    //获取授权用户信息
    @IBAction func qqAuth(sender: UIButton) {
//        ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: nil) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
//            
//        }
        //获取授权
        ShareSDK.getUserInfo(SSDKPlatformType.typeQQ) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
            switch state{
            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.uid))")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
            default:
                break
            }
        }
//      //此方法无论授权成功与否都会进行授权
//        ShareSDK.authorize(SSDKPlatformType.typeQQ, settings: nil, onStateChanged: { (state: SSDKResponseState, user: SSDKUser?, error: Error?) -> Void in
//
//            switch state{
//            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.credential))")
//            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
//            case SSDKResponseState.cancel:  print("操作取消")
//            default:
//                break
//            }
//        })
    }
    @IBAction func close(_ sender: UIButton) {
        //取消授权
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeQQ)
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeWechat)
        ShareSDK.cancelAuthorize(SSDKPlatformType.typeSinaWeibo)
    }
    @IBAction func searchInfo(_ sender: UIButton) {
        //获取当前授权用户
        
        let qqUser = ShareSDK.currentUser(SSDKPlatformType.typeQQ)
        print("获取成功,qq用户信息为\(String(describing: qqUser?.uid))")
        
        let weChatuser = ShareSDK.currentUser(SSDKPlatformType.typeWechat)
        print("获取成功,qq用户信息为\(String(describing: weChatuser?.uid))")
        
        let sinaChatuser = ShareSDK.currentUser(SSDKPlatformType.typeSinaWeibo)
        print("获取成功,微博用户信息为\(String(describing: sinaChatuser?.uid))")
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
}


