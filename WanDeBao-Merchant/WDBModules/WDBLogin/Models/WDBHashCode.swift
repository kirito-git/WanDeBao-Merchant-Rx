//
//  WDBHashCode.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/24.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBHashCode: Mappable {
    
    var hashCode: String?
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        hashCode <- map["hashCode"]
    }
    
}
