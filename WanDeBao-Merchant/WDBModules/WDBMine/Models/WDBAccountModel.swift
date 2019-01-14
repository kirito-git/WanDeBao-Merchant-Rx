//
//  WDBAccountModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/3.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBAccountModel: Mappable {

    var accountId: Int?
    var userId: Int?
    var shopId: Int?
    var createTime: Double?
    var updateTime: Double?
    var account: Float?
    var accountPriseSum: Float?
    var accountFrozenSum: Float?
    var accountUncashSum: Float?
    var accountCashSum: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        accountId <- map["id"]
        userId <- map["userId"]
        shopId <- map["shopId"]
        createTime <- map["createTime"]
        updateTime <- map["updateTime"]
        account <- map["account"]
        accountPriseSum <- map["accountPriseSum"]
        accountFrozenSum <- map["accountFrozenSum"]
        accountUncashSum <- map["accountUncashSum"]
        accountCashSum <- map["accountCashSum"]
        
    }
}
