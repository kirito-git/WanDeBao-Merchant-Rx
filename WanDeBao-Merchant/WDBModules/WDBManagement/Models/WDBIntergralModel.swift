//
//  WDBIntergralModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/2.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBIntergralModel: Mappable {

    var intergralId: Int?
    var type: Int?
    var typeDesc: String?
    var value: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        intergralId <- map["id"]
        type <- map["type"]
        typeDesc <- map["typeDesc"]
        value <- map["value"]
    }
}
