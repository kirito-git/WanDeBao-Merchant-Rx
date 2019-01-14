//
//  WDBTurnoverModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBTurnoverShopModel: Mappable {
    
    var shopId:Int?
    var shopName:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        shopId <- map["id"]
        shopName <- map["shopName"]
    }
}


class WDBTurnoverModel: Mappable {

    var discountId: Int?
    var times: Int?
    var redPacket: Int?
    var shopList: [WDBTurnoverShopModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        discountId <- map["discountId"]
        times <- map["times"]
        redPacket <- map["redPacket"]
        shopList <- map["shopList"]
    }
}


