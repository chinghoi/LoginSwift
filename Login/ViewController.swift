//
//  ViewController.swift
//  Login
//
//  Created by ChingHoi on 15/7/31.
//  Copyright (c) 2015年 CHK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取沙盒的用户数据目录
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        //拼接上文件名
        let fileName = path! + "/MyPlist.plist"
        let dic: NSDictionary = ["name":"jaki","age":"28"]
        //进行写文件
        dic.write(toFile: fileName, atomically: true)
        //将储存的Plist文件数据进行读取
        let dicRes = NSDictionary(contentsOfFile: fileName)
        print(dicRes ?? "dicRes 为 nil")
        
        
    }
    
    
    //获取授权用户信息
 
    @IBAction func OAuth(sender: UIButton) {
//        ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: nil) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
//            
//        }
        //获取授权
        ShareSDK.getUserInfo(SSDKPlatformType.typeQQ) { (state: SSDKResponseState, user: SSDKUser?, error: Error?) in
            switch state{
            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.credential))")
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
    }
    @IBAction func searchInfo(_ sender: UIButton) {
        //获取当前授权用户
        let user = ShareSDK.currentUser(SSDKPlatformType.typeQQ)
        print("获取成功,用户信息为\(String(describing: user))")
//        //获取用户授权信息时,若授权,则查询,反之,将会跳转到授权页面
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


