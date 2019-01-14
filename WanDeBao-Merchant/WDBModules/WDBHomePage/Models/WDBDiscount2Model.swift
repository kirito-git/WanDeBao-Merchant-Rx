//
//  WDBDiscount2Model.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/7.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBDiscount2Model: Mappable {
    
    var userDiscountCondition: userDiscountCondition?
    var userDiscount: userDiscount?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        userDiscountCondition <- map["userDiscountCondition"]
        userDiscount <- map["userDiscount"]
    }
}

class userDiscountCondition: Mappable {
    
    var factorValue: Float?
    var downLimitNum: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        factorValue <- map["factorValue"]
        downLimitNum <- map["downLimitNum"]
    }
}


class userDiscount: Mappable {
    
    var Id: Int?
    var userId: Int?
    var shopId: Int?
    var discountName: String?
    var status: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        Id <- map["id"]
        userId <- map["userId"]
        shopId <- map["shopId"]
        discountName <- map["discountName"]
        status <- map["status"]
    }
}
