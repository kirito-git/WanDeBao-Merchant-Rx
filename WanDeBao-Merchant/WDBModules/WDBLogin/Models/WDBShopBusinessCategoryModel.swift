//
//  WDBShopBusinessCategoryModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/7/13.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class WDBShopBusinessCategoryModel: Mappable {
    
    var Id: Int?
    var cateName: String?
    var description: String?
    var cateIcon: String?
    var cateLevel: Int?
    var parentId: Int?
    var status: Int?
    var shopId: String?
    var type: Int?
    var seq: Int?
    var cateList: [WDBShopBusinessCategoryModel]?
    
    
    required init?(map: Map) {
  
        
    }
    
    func mapping(map: Map) {
        Id <- map["id"]
        cateName <- map["cateName"]
        description <- map["description"]
        cateIcon <- map["cateIcon"]
        cateLevel <- map["cateLevel"]
        shopId <- map["shopId"]
        parentId <- map["parentId"]
        status <- map["status"]
        type <- map["type"]
        seq <- map["seq"]
        cateList <- map["cateList"]
//        let cateListArray = map["cateList"]
//        cateList = Mapper<WDBShopBusinessCategoryModel>().mapArray(JSONArray: cateListArray.context as! [[String : Any]])
        
    }
    
}
