//
//  WDBAccountManager.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/25.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit


class WDBAccountManager: NSObject {

    var sid:String?
    var ID:Int?
    
    var ossInfo:YBOSSInfo?
    var loginInfo:WDBLoginInfo?
    
    var clientId:String?
    var productId:String?
    
    
    //用户信息
    
    static let sharedManger: WDBAccountManager = {
       let manager = WDBAccountManager()
        return manager
    }()
    
    private override init() {
        
    }
    
   
    
}
