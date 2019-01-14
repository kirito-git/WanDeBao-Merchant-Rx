//
//  WDBChartDataModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBOrderChartModel: Mappable {

    var time: Int?
    var totalSum: Float?
    //自定义
    var day: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        time <- map["time"]
        totalSum <- map["totalSum"]
        //自定义
        day <- map["day"]
    }
}
