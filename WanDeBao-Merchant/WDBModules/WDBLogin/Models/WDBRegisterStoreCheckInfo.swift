//
//  WDBRegisterStoreCheckInfo.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBRegisterStoreCheckInfo: Mappable {
   
    var status: Int? //-1 未提交 0提交 1通过 2不通过
    var msg: String?
    var shopInfo: WDBShopInfo?
    
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        shopInfo <- map["wdbShop"]
    }
    
}

class WDBShopInfo: Mappable {
    
    var ID: Int?
    var shopName: String?
    var shopLogo: String?
    var shopAddress: String?
    var createTime: Double?
    var endTime: Double?
    var updateTime: Double?
    var patternType: Int?
    var ownerId: Int?
    
    
    
    var isNew: Int?
    
    
    
    
    
    required init?(map: Map) {
        
    }
    
    
     func mapping(map: Map) {
        ID <- map["id"]
        shopName <- map["shopName"]
        shopLogo <- map["shopLogo"]
        shopAddress <- map["shopAddress"]
        createTime <- map["createTime"]
        endTime <- map["endTime"]
        updateTime <- map["updateTime"]
        isNew <- map["isNew"]
        patternType <- map["patternType"]
        ownerId <- map["ownerId"]
        
    }

    
}
