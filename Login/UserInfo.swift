//
//  UserInfo.swift
//  Login
//
//  Created by ChingHoi on 2018/3/19.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit
import LeanCloud

class UserInfo: ViewController {
    
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
        //获取当前登录用户的信息
        lableUserName.text = "用户名:" + (LCUser.current?.username?.value)!
        lablePhoneNum.text = "手机号:" + (LCUser.current?.mobilePhoneNumber?.value)!
        lableEmailAdd.text = "邮箱:" + (LCUser.current?.email?.value)!
        
}
@IBOutlet weak var imageViewAvatar: UIImageView!
@IBOutlet weak var lableUserName: UILabel!
@IBOutlet weak var lablePhoneNum: UILabel!
@IBOutlet weak var lableEmailAdd: UILabel!
    
    @IBAction func btnLogout(_ sender: UIButton) {
        //创建查询
        let query = LCQuery(className: "_User")
        // 指定返回 lastLoginTime 属性
//        query.whereKey("lastLoginTime", .selected)
        query.get((LCUser.current?.objectId?.value)!) { result in
            switch result {
            case .success(let todo):
                print(todo.get("createdAt")!)
            case .failure(let error):
                print(error)
            }
        }
        

        //注销登录
        LCUser.logOut()
        //返回上一界面
        self.dismiss(animated: true, completion: nil)
    }
}
