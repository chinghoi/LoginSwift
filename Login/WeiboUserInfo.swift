//
//  UserInfo.swift
//  Login
//
//  Created by ChingHoi on 2018/3/19.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit
import LeanCloud

//微博用户信息
class WeiboUserInfo: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载头像------
        let wiboUser = ShareSDK.currentUser(SSDKPlatformType.typeSinaWeibo)
        //网址可选值String转URL
        let url = URL(string: (wiboUser?.icon)!)
        //数据化网址
        let data = try! Data(contentsOf: url!)
        //通过数据流初始化图片
        let newImage = UIImage(data: data)
        //添加图片到image视图
        imageViewAvatar.addSubview(UIImageView(image:newImage))
        //------------
        //在服务器获取当前登录用户的信息
        
        lableUserName.text = "用户名:" + (wiboUser?.nickname)!
        
        switch (wiboUser?.gender)! {
        case 0:
            lableGender.text = "性别: 男"
        case 1:
            lableGender.text = "性别: 女"
        case 2:
            lableGender.text = "性别: 未知"
        default:
            break
        }
        let aboutMe = wiboUser?.aboutMe
        if aboutMe != nil {
            lableAboutMe.text = "用户简介:" + (wiboUser?.aboutMe)!
        } else {
            lableAboutMe.text = "用户简介: 无信息"
        }
        
        
        let birthday   = wiboUser?.birthday
        let timeFormatter0 = DateFormatter()
        //设置日期格式
        timeFormatter0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //判断生日信息是否为空,防止程序崩溃
        if birthday != nil {
            //转换为String
            let strbirthday = timeFormatter0.string(from: birthday!) as String
            //在界面显示生日信息
            lableBirthday.text = "生日:" + strbirthday
        } else {
            lableBirthday.text = "无生日信息"
        }
        
    }
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lableUserName: UILabel!
    @IBOutlet weak var lableGender: UILabel!
    @IBOutlet weak var lableAboutMe: UILabel!
    @IBOutlet weak var lableBirthday: UILabel!
    
    
    @IBAction func btnLogout(_ sender: UIButton) {
        
        //注销登录
        LCUser.logOut()
        //返回主界面
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

