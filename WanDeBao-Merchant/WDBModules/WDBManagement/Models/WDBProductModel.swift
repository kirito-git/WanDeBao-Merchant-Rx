//
//  WDBProductModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper


class WDBProductModel: Mappable {

    var productId: Int?
    var shopId: Int?
    var name: String?
    var cateId: Int?
    var cateName: String?
    var productContent: String?
    var productImgUrl: String?
    var productIcoUrl: String?
    var shopPrice: Double?
    var sellPrice: Double?
    var price: Double?
    var type: Int?
    var times: Int?
    var timesType: Int?
    var number: Int?
    var point: Int?
    var createTime: Double?
    var updateTime: Double?
    var isSelectProduct: Bool = false
    
    
    
    
    var timesTypeName: String?
    var discountTypeName: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        productId <- map["id"]
        shopId <- map["shopId"]
        name <- map["name"]
        cateId <- map["cateId"]
        cateName <- map["cateName"]
        productContent <- map["productContent"]
        productImgUrl <- map["productImgUrl"]
        productIcoUrl <- map["productIcoUrl"]
        shopPrice <- map["shopPrice"]
        sellPrice <- map["sellPrice"]
        price <- map["price"]
        type <- map["type"]
        times <- map["times"]
        timesType <- map["timesType"]
        number <- map["number"]
        point <- map["point"]
        createTime <- map["createTime"]
        updateTime <- map["updateTime"]
        
        
        if type == 2 {
            discountTypeName = "抵扣券"
        }else if type == 8 {
            discountTypeName = "免单券"
        }else if type == 4 {
            discountTypeName = "实物券"
        }else if type == 5 {
            discountTypeName = "满减券"
        }else if type == 6 {
            discountTypeName = "折扣券"
        }else {
            discountTypeName = "优惠券"
        }
        
        if timesType == 0 {
            timesTypeName = "\(String(describing:times ?? 0))年"
        }else if timesType == 1 {
            timesTypeName = "\(String(describing:times ?? 0))月"
        }else if timesType == 2 {
            timesTypeName = "\(String(describing:times ?? 0))日"
        }else if timesType == 3 {
            timesTypeName = "\(String(describing:times ?? 0))分钟"
        }
    }
}
