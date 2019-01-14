//
//  WDBLoginInfo.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class WDBLoginInfo: Mappable {
   
    var token: WDBUserToken?
    var userInfo: WDBUserInfo?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        userInfo <- map["user"]
    }
    
}

//用户Token信息
class  WDBUserToken: Mappable {
    
    var access_token:String?
    var token_type:String?
    var refresh_token:String?
    var expires_in:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        refresh_token <- map["refresh_token"]
        expires_in <- map["expires_in"]
    }
    
    
}

//用户信息
class WDBUserInfo: Mappable {
    
    var ID: Int?
    var phone: String?
    var userLevel: Int?
    var clientId: String?
    var deviceCode: String?
    var userId: String?
    var userid: String?
    var imageUrl: String?
    var payCount: CGFloat?
    var displayName: String?
    var userName:String?
    var bindStatus:Int?
    var providerid:String?
    var provideruserid:String?
    var accesstoken:String?
    var refreshtoken:String?
    var isNew: Int?    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ID <- map["id"]
        phone <- map["phone"]
        userLevel <- map["userLevel"]
        clientId <- map["clientId"]
        deviceCode <- map["deviceCode"]
        userId <- map["userId"]
        userid <- map["userid"]
        imageUrl <- map["imageurl"]
        payCount <- map["payCount"]
        displayName <- map["displayname"]
        bindStatus <- map["bindStatus"]
        accesstoken <- map["accesstoken"]
        refreshtoken <- map["refreshtoken"]
        provideruserid <- map["provideruserid"]
        providerid <- map["providerid"]
        isNew <- map["isnew"]
    }
    
}


