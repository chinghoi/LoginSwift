//
//  Registered.swift
//  Login
//
//  Created by ChingHoi on 2018/3/18.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit
import LeanCloud

//注册
class Registered: ViewController {
    
    //点击空白处隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldUser.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
    }
    //用户名,密码,邮箱地址接口
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    //注册按钮
    @IBAction override func btnRegistered(_ sender: UIButton) {
        //点击注册按钮后隐藏键盘
        textFieldUser.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        
        //新建一个注册用户信息
        let randomUser = LCUser()
        
        randomUser.username = LCString(textFieldUser.text!)
        randomUser.password = LCString(textFieldPassword.text!)
        randomUser.email = LCString(textFieldEmail.text!)
        
        //保存用户信息,并判断提示
        randomUser.save { result in
            switch result {
            case .success: UIAlertView.init(title: "注册成功!", message: "你的账号：" + self.textFieldUser.text! + " 注册成功", delegate: self, cancelButtonTitle: "好的").show()
                break
            case .failure(let error):
                UIAlertView.init(title: "注册失败", message: "错误:\(error)", delegate: self, cancelButtonTitle: "再试一次").show()
            }
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        //返回到上一个页面
        self.dismiss(animated: true,completion: nil)
    }
}

