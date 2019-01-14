//
//  WDBDiscountChartModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBDiscountChartModel: Mappable {

    var time: Int?
    var useDiscountCount: Int?
    var allDiscountCount: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        time <- map["time"]
        useDiscountCount <- map["useDiscountCount"]
        allDiscountCount <- map["allDiscountCount"]
    }
}
