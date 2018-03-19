//
//  Registered.swift
//  Login
//
//  Created by ChingHoi on 2018/3/18.
//  Copyright © 2018年 CHK. All rights reserved.
//

import UIKit
import LeanCloud

//注册
class Registered: ViewController {
    
    //点击空白处隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldUser.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldEmail.resignFirstResponder()
        textFieldPhoneNumber.resignFirstResponder()
    }
    //用户名,密码,邮箱地址,手机号接口
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    //注册按钮
    @IBAction override func btnRegistered(_ sender: UIButton) {
        //点击注册按钮后隐藏键盘
        textFieldUser.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldEmail.resignFirstResponder()
        textFieldPhoneNumber.resignFirstResponder()
        
        //正则匹配是否是手机号
        func checkEmail(phoneNumber: NSString) ->Bool {
            let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
            let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let isMatch:Bool = pred.evaluate(with: phoneNumber)
            return isMatch;
        }
        //正则匹配是否是email
        func checkEmail(email:NSString) ->Bool {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
            let isMatch:Bool = pred.evaluate(with: email)
            return isMatch;
        }
        if textFieldUser.text!.isEmpty && textFieldPassword.text!.isEmpty && textFieldEmail.text!.isEmpty && textFieldPhoneNumber.text!.isEmpty{
            UIAlertView.init(title: "注册失败", message: "信息不能有空", delegate: self, cancelButtonTitle: "好的").show()
        } else {
            if checkEmail(email: textFieldEmail.text! as NSString) && checkEmail(phoneNumber: textFieldPhoneNumber.text! as NSString){
                //新建一个注册用户信息
                let randomUser = LCUser()
                
                randomUser.username = LCString(textFieldUser.text!)
                randomUser.password = LCString(textFieldPassword.text!)
                randomUser.email = LCString(textFieldEmail.text!)
                randomUser.mobilePhoneNumber = LCString(textFieldPhoneNumber.text!)
                //保存用户信息,并判断提示
                randomUser.save { result in
                    switch result {
                    case .success: UIAlertView.init(title: "注册成功!", message: "你的账号：" + self.textFieldUser.text! + " 注册成功", delegate: self, cancelButtonTitle: "好的").show()
                        break
                    case .failure(let error):
                        UIAlertView.init(title: "注册失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "好的").show()
                    }
                }
            } else {
                UIAlertView.init(title: "注册失败", message: "请输入正确的邮箱或者手机号", delegate: self, cancelButtonTitle: "好的").show()
            }
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        //返回到上一个页面
        self.dismiss(animated: true,completion: nil)
    }
}

