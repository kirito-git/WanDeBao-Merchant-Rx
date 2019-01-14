//
//  WDBLLPayRechargeModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/25.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBLLPayRechargeModel: Mappable {
    
    var Id: Int?
    var payType: String?
    var payTypeDesc: String?
    var status: Int?
    var cachBankcard: String?
    var bankcardId: Int?
    var cashCode: String?
    var type: Int?
    var shopName: String?
    var shopId: Int?
    var chargeNotifyUrl: String?
    var createTime: Double?
    var userId: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        Id <- map["id"]
        payType <- map["payType"]
        payTypeDesc <- map["payTypeDesc"]
        status <- map["status"]
        cachBankcard <- map["cachBankcard"]
        bankcardId <- map["bankcardId"]
        cashCode <- map["cashCode"]
        type <- map["type"]
        shopName <- map["shopName"]
        shopId <- map["shopId"]
        chargeNotifyUrl <- map["chargeNotifyUrl"]
        createTime <- map["createTime"]
        userId <- map["userId"]
    }
        
}
