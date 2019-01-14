//
//  WDBMyBankCardInfoModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBMyBankCardInfoModel: Mappable {
    
    var Id: Int?
    var bankId: String?
    var type: Int?
    var bankCard: String?
    var bankName: String?
    var bankUsername: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Id <- map["id"]
        bankId <- map["bankId"]
        type <- map["type"]
        bankCard <- map["bankCard"]
        bankName <- map["bankName"]
        bankUsername <- map["bankUsername"]
    }
}
