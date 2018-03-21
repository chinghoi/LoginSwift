//
//  Binding.swift
//  Login
//
//  Created by ChingHoi on 2018/3/20.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit
import LeanCloud

//第三方登录未注册时跳转界面
class Binding: ViewController {
    //服务器帐号数据接口
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //绑定服务器和第三方平台帐号
    @IBAction func btnBinding(_ sender: UIButton) {
        //点击绑定的同时隐藏键盘+
        textFieldUser.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        //返回主页
        self.dismiss(animated: true, completion: nil)
        //正则匹配是否是手机号
        func checkPhoneNumber(phoneNumber: String) ->Bool {
            let phoneRegex: String = "1[0-9]{10}" //双引号里的1就是第一位必须是1，后续的[0-9]就是纯数字的意思,{10}就是重复10次。10次加上第一位必须为1就是11位手机号的判断。
            let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let isMatch:Bool = pred.evaluate(with: phoneNumber)
            return isMatch;
        }
        //判断是用户名和邮箱登录还是手机号登录
        if checkPhoneNumber(phoneNumber: (textFieldUser.text)!) {
            //手机号登录
            LCUser.logIn(mobilePhoneNumber: (textFieldUser.text)!, password: (textFieldPassword.text)!) { result in
                switch result {
                case .success:
                    //添加uid
                    self.loginSuccess()
                    //跳转页面
                    self.performSegue(withIdentifier: "bindingUserInfo", sender: self)
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }else{
            //用户名和邮箱登录
            LCUser.logIn(username: (textFieldUser.text)!, password: (textFieldPassword.text)!) { result in
                switch result {
                case .success:
                    //添加uid
                    self.loginSuccess()
                    //跳转页面
                    self.performSegue(withIdentifier: "bindingUserInfo", sender: self)
                case .failure(let error):
                    UIAlertView.init(title: "登录失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
                }
            }
        }
    }
    //登录成功 添加数据 调用的函数
    func loginSuccess() {
        //在LeanCloud云端给当前登录的账号加入uid数据
        let uid = ShareSDK.currentUser(SSDKPlatformType.typeQQ).uid  //得到uid
        LCUser.current?.set("uid_qq", value: uid!)  //设置服务器端相应数据
        LCUser.current?.save { result in  //保存 并返回成功结果
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    //返回主页
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

