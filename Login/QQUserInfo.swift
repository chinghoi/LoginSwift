//
//  UserInfo.swift
//  Login
//
//  Created by ChingHoi on 2018/3/19.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit
import LeanCloud

//QQ用户信息
class QQUserInfo: ViewController {
    
    let username = ShareSDK.currentUser(SSDKPlatformType.typeQQ).credential.uid!
    let password = ShareSDK.currentUser(SSDKPlatformType.typeQQ).credential.token!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载头像------
        let qqUser = ShareSDK.currentUser(SSDKPlatformType.typeQQ)
        //网址可选值String转URL
        let url = URL(string: (qqUser?.icon)!)
        //数据化网址
        let data = try! Data(contentsOf: url!)
        //通过数据流初始化图片
        let newImage = UIImage(data: data)
        //添加图片到image视图
        imageViewAvatar.addSubview(UIImageView(image:newImage))
        //------------
        //在服务器获取当前登录用户的信息
        
        lableUserName.text = "用户名:" + (qqUser?.nickname)!
        
        switch (qqUser?.gender)! {
        case 0:
            lableGender.text = "性别: 男"
        case 1:
            lableGender.text = "性别: 女"
        case 2:
            lableGender.text = "性别: 未知"
        default:
            break
        }

        //登录成功,在LeanCloud云端次数加一
        let loginCount   = LCUser.current?.get("loginCount")  // 通过当前登录用户的loginCount字段读取登录次数(此字段为自己在网页管理端新建)
        var count = loginCount?.intValue!  //将数据Int化
        count! = count! + 1  //登录成功本地自增一
        LCUser.current?.set("loginCount", value: count!)  //设置服务器端相应数据
        LCUser.current?.save { result in  //保存 并返回成功结果
            switch result {
            case .success:print("++++++------------------+++++++++++++++++++++++++")
                break
            case .failure(let error):
                print(error)
            }
        }
        //在界面显示登录次数
        lableLoginCount.text = "当前登录次数:" + String(count!)
        
        //登录成功,先读取上次登录时间
        let loginTime   = LCUser.current?.get("lastLoginTime")?.dateValue  // 通过当前登录用户的lastLoginTime字段读取登录时间(此字段为自己在网页管理端新建)
        let timeFormatter0 = DateFormatter()
        //设置日期格式
        timeFormatter0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //判断上次登录时间是否为空
        if loginTime != nil {
            //转换为String
            let strLastLoginTime = timeFormatter0.string(from: loginTime!) as String
            //在界面显示上次登录时间
            lableLastLoginTime.text = strLastLoginTime
        } else {
            lableLastLoginTime.text = "第一次登录"
        }
        
        let date = Date()
        let timeFormatter = DateFormatter()
        //设置日期格式
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //转换为String
        let strNowTime = timeFormatter.string(from: date) as String
        //转换为LCDate(LeanCloud可识别的格式)
        let reminder = dateWithString(string: strNowTime)
        //上传到服务器端相应位置
        LCUser.current?.set("lastLoginTime", value: reminder)
        LCUser.current?.save { result in  //保存 并返回成功结果
            switch result {
            case .success:print("----------------------+++++++++++++++++++++++++++++++")
                break
            case .failure(let error):
                print(error)
            }
        }
        
    }
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lableUserName: UILabel!
    @IBOutlet weak var lableGender: UILabel!
    @IBOutlet weak var lableLoginCount: UILabel!
    @IBOutlet weak var lableLastLoginTime: UILabel!
    //数据转换操作 String -> LCDate
    func dateWithString(string: String) -> LCDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = LCDate(dateFormatter.date(from: string)!)
        return date
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        
        //注销登录
        LCUser.logOut()
        //返回主界面
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
