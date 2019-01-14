//
//  WDBOrderModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/6.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBOrderModel: Mappable {

    var orderUnionVoList: [Any]?
    var orderPay: orderPay?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        orderUnionVoList <- map["orderUnionVoList"]
        orderPay <- map["orderPay"]
    }
}

class orderPay: Mappable {
    
    var id: Int?
    var payType: Int?
    var discountSum: Int?
    var payActualAllSum: Double?
    var payActualCode: String?
    var userId: Int?
    var createTime: Int?
    var updateTime: Int?
    var orderType: Int?
    var allPoints: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        payType <- map["payType"]
        discountSum <- map["discountSum"]
        payActualAllSum <- map["payActualAllSum"]
        payActualCode <- map["payActualCode"]
        userId <- map["userId"]
        createTime <- map["createTime"]
        updateTime <- map["updateTime"]
        orderType <- map["orderType"]
        allPoints <- map["allPoints"]
    }
}

