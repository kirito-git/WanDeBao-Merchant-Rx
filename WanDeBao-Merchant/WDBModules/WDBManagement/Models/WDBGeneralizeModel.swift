//
//  WDBGeneralizeModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBGeneralizeModel: Mappable {
    
    var factorValue: Int?
    var number: Int?
    var sum: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        factorValue <- map["factorValue"]
        number <- map["number"]
        sum <- map["sum"]
        
        if factorValue is NSNull {
            factorValue = 0
        }
        if number is NSNull {
            number = 0
        }
        if sum is NSNull {
            sum = 0
        }
    }
}
