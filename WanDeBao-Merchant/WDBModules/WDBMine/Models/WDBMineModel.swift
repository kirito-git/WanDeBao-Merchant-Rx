//
//  WDBMineModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBMineModel: NSObject {
    public var title: String?
    public var image: String?
}


class WDBShopOwnerInfo: Mappable {
    
    var ID: Int?
    var realName:String?
    var phone:String?
    var idCard:String?
    var idCardUrl:String?
    var idCardBackUrl:String?
    var ownerDesc:String?
    var remark:String?
    var address:String?
    var shopType:Int?
    var diningCicenceUrl:String?
    var diningSecurityUrl:String?
    var businessUrl:String?
    var shopName:String?
    var type: Int?
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        ID <- map["id"]
        realName <- map["realname"]
        phone <- map["phone"]
        idCard <- map["idCard"]
        idCardUrl <- map["idcardUrl"]
        idCardBackUrl <- map["idcardBackUrl"]
        ownerDesc <- map["ownerdesc"]
        remark <- map["remark"]
        address <- map["address"]
        shopType <- map["shopType"]
        diningCicenceUrl <- map["diningCicenceUrl"]
        diningSecurityUrl <- map["diningSecurityUrl"]
        businessUrl <- map["businessUrl"]
        shopName <- map["shopName"]
        type <- map["type"]
    }
}


















