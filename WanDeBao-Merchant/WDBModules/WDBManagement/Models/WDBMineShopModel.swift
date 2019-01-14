//
//  WDBMineShopModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/3.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBMineShopModel: Mappable {
   
    var shopId:Int?
    var shopName:String?
    var shopLogo:String?
    var shopLogo2:String?
    var shopType:Int?
    var shopAddress:String?
    var patternType:String?
    var shopPhone:String?
    var shopDesc:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        shopId <- map["id"]
        shopName <- map["shopName"]
        shopLogo <- map["shopLogo"]
        shopLogo2 <- map["shopLogo2"]
        shopType <- map["shopType"]
        shopAddress <- map["shopAddress"]
        patternType <- map["patternType"]
        shopPhone <- map["shopPhone"]
        shopDesc <- map["shopDesc"]
    }
}
