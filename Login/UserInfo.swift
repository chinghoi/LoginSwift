//
//  User.swift
//  Login
//
//  Created by ChingHoi on 2018/3/16.
//  Copyright © 2018年 MOB. All rights reserved.
//

import UIKit

//参考资料 Swift从入门到精通 作者：张益珲

//遵守NScoding协议
class UserInfo: NSObject, NSCoding {
    //添加用户属性
    var id: NSInteger = 0
    var nickname: String?
    var email: String?
    var password: String?
    var qqbinding: Bool = false
    var wechatbinding: Bool = false
    var weibobinding: Bool = false
//    var age : NSInteger = 0
    //构造方法
    override init() {
        super.init()
    }
    
    //归档方法
    func encode(with aCoder: NSCoder) {
        //        aCoder.encode(age, forKey: "age")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nickname, forKey: "nickname")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(qqbinding, forKey: "qqbinding")
        aCoder.encode(wechatbinding, forKey: "wechatbinding")
        aCoder.encode(weibobinding, forKey: "weibobinding")
    }
    
    //解归档方法
    required init?(coder aDecoder: NSCoder) {
        super.init()
        //        self.age = NSInteger(aDecoder.decodeInt32(forKey: "age"))
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
        self.qqbinding = aDecoder.decodeBool(forKey: "qqbinding")
        self.wechatbinding = aDecoder.decodeBool(forKey: "wechatbinding")
        self.weibobinding = aDecoder.decodeBool(forKey: "weibobinding")

    }

    
}

