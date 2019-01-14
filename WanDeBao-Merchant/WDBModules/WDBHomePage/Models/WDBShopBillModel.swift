//
//  WDBShopBillModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBShopBillModel: Mappable {

    var imageurl: String?
    var displayname: String?
    var discountName: [String]?
    var totalSum: Float?
    var createTime: Int?
    var paySum: Float?
    
    var timeName: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        imageurl <- map["imageurl"]
        displayname <- map["displayname"]
        discountName <- map["discountName"]
        totalSum <- map["totalSum"]
        createTime <- map["createTime"]
        paySum <- map["paySum"]
        
        timeName = DateFormatTool.dateStringFromTimestamp(type: DateStringType.yMdHms,timestamp: Double(createTime!))
    }
}
