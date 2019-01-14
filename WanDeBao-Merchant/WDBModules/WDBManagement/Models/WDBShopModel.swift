//
//  WDBShopModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper


class WDBShopModel: Mappable {
    
    var shopId: Int?
    var shopName: String?
    var distance: Int?
    var longitude: Double?
    var latitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        shopId <- map["shopId"]
        shopName <- map["shopName"]
        distance <- map["distance"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }
}
