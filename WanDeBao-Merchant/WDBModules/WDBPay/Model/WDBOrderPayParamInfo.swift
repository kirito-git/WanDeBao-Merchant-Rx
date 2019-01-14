//
//  WDBOrderPayParamInfo.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBOrderPayParamInfo: Mappable {
    
    var isOtherPay: Int?
    var nonceStr: String?
    var partnerId: String?
    var payOrderId: String?
    var paySign: String?
    var prepayId: String?
    var timeStamp: String?
    var sign:String?
    var package:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        isOtherPay <- map["isOtherPay"]
        nonceStr <- map["nonceStr"]
        partnerId <- map["partnerId"]
        payOrderId <- map["payOrderId"]
        paySign <- map["paySign"]
        prepayId <- map["prepayId"]
        timeStamp <- map["timeStamp"]
        sign <- map["sign"]
        package <- map["package"]
    }
    
    
    
    
    
    
    
    
    
}
