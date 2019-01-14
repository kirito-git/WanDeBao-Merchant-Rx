//
//  WDBTableModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBTableModel: Mappable {

    var tableId: Int?
    var tableNum: String?
    var type: Int?
    var status: Int?
    var createTime: Double?
    var servingStatus: Int?
    var cutdownTime: Double?
    var tableCode: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tableId <- map["id"]
        tableNum <- map["tableNum"]
        type <- map["type"]
        status <- map["status"]
        createTime <- map["createTime"]
        servingStatus <- map["servingStatus"]
        cutdownTime <- map["cutdownTime"]
        tableCode <- map["tableCode"]
    }
}
