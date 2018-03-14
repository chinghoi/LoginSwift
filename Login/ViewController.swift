//
//  ViewController.swift
//  ShareSDK简洁版-Swift
//
//  Created by lisk@uuzu.com on 15/7/31.
//  Copyright (c) 2015年 MOB. All rights reserved.
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
        ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: [:]) { (state : SSDKResponseState, user : SSDKUser?, error : Error?) in
            
        }
        //授权
        ShareSDK.authorize(SSDKPlatformType.typeWechat, settings: nil, onStateChanged: { (state : SSDKResponseState, user : SSDKUser?, error : Error?) -> Void in
            
            switch state{
                
            case SSDKResponseState.success: print("授权成功,用户信息为\(String(describing: user))\n ----- 授权凭证为\(String(describing: user?.credential))")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
                
            default:
                break
            }
        })
    }
}


