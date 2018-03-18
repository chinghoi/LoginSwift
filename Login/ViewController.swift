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
        
//        //获取沙盒的用户数据目录
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//        //拼接上文件名
//        let userFileName = path! + "/user.file"
//        let user0 = UserInfo()
//        let user2 = UserInfo()
//        user0.id = 0
//        user0.nickname = "chinghoi"
//        user0.email = "56465334@qq.com"
//        user0.password = "123456"
//        user0.qqbinding = false
//        user0.wechatbinding = false
//        user0.weibobinding = false
//        user2.id = 2
//        user2.nickname = "abcd"
//        user2.email = "110@qq.com"
//        user2.password = "123456"
//        user2.qqbinding = false
//        user2.wechatbinding = false
//        user2.weibobinding = false
//        //进行写文件
//        NSKeyedArchiver.archiveRootObject(user0, toFile: userFileName)
//        NSKeyedArchiver.archiveRootObject(user2, toFile: userFileName)
//        //将储存的数据进行读取
//        let userAnything = NSKeyedUnarchiver.unarchiveObject(withFile: userFileName) as! UserInfo
//        print("\(String(describing: userAnything.nickname)),\(user2.id)")
        
//        //归档
//        let data=NSMutableData()
//        let archiver=NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(["chinghoi","yzk"], forKey: "data");
//        archiver.encode("测试消息", forKey: "tip");
//        archiver.finishEncoding()
//        data.write(toFile: userFileName, atomically: true)
//
//        //反归档
//        let unarchiveData=NSData(contentsOfFile: userFileName)
//        let unarchiver=NSKeyedUnarchiver(forReadingWith: unarchiveData! as Data)
//        let decodeData=unarchiver.decodeObject(forKey: "data") as! NSArray
//        let decodeTip=unarchiver.decodeObject(forKey: "tip") as! NSString
//        NSLog("data=%@,tip=%@",decodeData,decodeTip)
        
//        let dicUser: NSDictionary = ["id":"2018","nickname":"chinghoi","sex":"男","age":"18","email":"2018@qq.com","mobile":"12345678910","status":"1","qq_binding":"0","wechat_binding":"0","weibo_binding":"0","phone_binding":"0"]
//
//        //进行写文件
//        dicUser.write(toFile: userFileName, atomically: true)
        //将储存的Plist文件数据进行读取
//        let dicUserRes = NSDictionary(contentsOfFile: userFileName)
//        print(dicUserRes ?? "dicRes 为 nil")
        
        
    }
    //点击空白处隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        textFieldUsrName.resignFirstResponder()
        textFieldPasswd.resignFirstResponder()
    }
    
    @IBOutlet weak var textFieldUsrName: UITextField!
    
    @IBOutlet weak var textFieldPasswd: UITextField!
    
    @IBAction func btnLogin(sender: AnyObject) {
//        //登陆验证成功
//        if true {
//            //进行跳转到下一个页面
//            self.performSegue(withIdentifier: "login", sender: self)
//        }else{
//            print("login fail")
//        }
        
        print("usrName is \(String(describing: self.textFieldUsrName.text))");
        print("passwdLabel is \(String(describing: self.textFieldPasswd.text))");
        
        let todo = LCObject(className: "Todo")
        //注册相关
        todo.set("title", value: "工程师周会")
        todo.set("content", value: "每周工程师会议，周一下午 2 点")
        
        todo.save { result in
            switch result {
            case .success: print("成功")
                break
            case .failure(let error):
                print("错误是:\(error)")
            }
        }
        
    }


    @IBAction func btnRegistered(_ sender: UIButton) {
        //进行跳转到注册页面
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


