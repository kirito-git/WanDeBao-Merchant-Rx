//
//  WDBDiscountModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/25.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBDiscountModel: Mappable {

    var conditionList: conditionList?
    var factorList: factorList?
    var discount: discount?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        conditionList <- map["conditionList"]
        factorList <- map["factorList"]
        discount <- map["discount"]
    }
}

//设置子映射
class conditionList: Mappable {
    
    var downLimitSum: Int?
    var upLimitSum: Int?
    var number: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        downLimitSum <- map["downLimitSum"]
        upLimitSum <- map["upLimitSum"]
        number <- map["number"]
    }
}

class factorList: Mappable {
    
    var discountSum: Int?
    var factorType: Int?
    var factorValue: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        discountSum <- map["discountSum"]
        factorType <- map["factorType"]
        factorValue <- map["factorValue"]
    }
}

//设置子映射
class discount: Mappable {
    
    var discountId: Int?
    var type: Int?
    var discountName: String?
    var startTime: Double?
    var endTime: Double?
    var typeName: String?
    var endDateText: String?
    var times: Int?
    var limitDay: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        discountId <- map["id"]
        type <- map["type"]
        discountName <- map["discountName"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        times <- map["times"]
        
        if type == 2 {
            typeName = "抵扣券"
        }else if type == 8 {
            typeName = "免单券"
        }else if type == 4 {
            typeName = "实物券"
        }else if type == 5 {
            typeName = "满减券"
        }else if type == 6 {
            typeName = "折扣券"
        }else {
            typeName = "优惠券"
        }
        
        if endTime == nil {
            endDateText = ""
        }else {
            let timeStr = DateFormatTool.dateStringFromTimestamp(type:DateStringType.yMdHms ,timestamp: Double(endTime!))
            endDateText = timeStr
        }
        if (times == 0) || (times == nil) {
            limitDay = "永久有效"
        }else {
            limitDay = "有效期\(String(describing:times ?? 0))分"
        }
        
//        let endtime = endTime ?? 0
//        if endtime == 0 {
//            limitDay = "永久有效"
//        }else {
//            let nowdate = NSDate.init(timeIntervalSinceNow: 0)
//            let nowTimeinterval = nowdate.timeIntervalSince1970 * 1000
//
//            if endtime > nowTimeinterval {
//                limitDay = "已过期"
//            }else {
//                let time = (endTime ?? 0) - nowTimeinterval
//                let day:Double = time/(60*60*24)/1000
//                let intDay = String(format: "%.0f",day)
//                print(day)
//                limitDay = "有效期\(String(intDay))天"
//            }
//        }
        
    }
    
}




