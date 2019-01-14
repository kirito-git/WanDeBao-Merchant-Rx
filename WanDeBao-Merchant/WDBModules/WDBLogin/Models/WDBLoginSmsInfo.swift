//
//  WDBLoginSmsInfo.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBLoginSmsInfo: Mappable {
    
    var value: String?
    var content: String?
    var sid: String?
    var ID: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        value <- map["value"]
        content <- map["content"]
        sid <- map["sid"]
        ID <- map["id"]
        
    }
    
}


