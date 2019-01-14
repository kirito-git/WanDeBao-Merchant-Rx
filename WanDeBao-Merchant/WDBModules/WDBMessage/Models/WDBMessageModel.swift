//
//  WDBMessageModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBMessageModel: Mappable {

    var Id: Int?
    var title: String?
    var content: String?
    var status: Int?
    var messageType: Int?
    var createTime: Double?
    var updateTime: Double?
    var createTimeString: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        Id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        status <- map["status"]
        messageType <- map["messageType"]
        createTime <- map["createTime"]
        updateTime <- map["updateTime"]
        
        if let time = createTime {
            let createTimeStr = DateFormatTool.dateStringFromTimestamp(type: DateStringType.yMd, timestamp: Double(time)/1000)
            createTimeString = createTimeStr
        }else {
            createTimeString = ""
        }
        
    }
}
