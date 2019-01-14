//
//  WDBGameModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBGameModel: Mappable {

    var wdbGame: wdbGame?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        wdbGame <- map["wdbGame"]
    }
}

class wdbGame: Mappable {
    
    var id: Int?
    var gameName: String?
    var gameIcon: String?
    var gameDesc: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        gameName <- map["gameName"]
        gameIcon <- map["gameIcon"]
        gameDesc <- map["gameDesc"]
    }
}
