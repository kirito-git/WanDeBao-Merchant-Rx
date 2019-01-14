//
//  JSONTools.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/2.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class JSONTools: NSObject {

    //字典转换为json
    class func jsonStringFromDataDic (dic:[String:Any]) -> String {
        
        if (!JSONSerialization.isValidJSONObject(dic)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dic, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        
        return JSONString! as String
    }
    
    //json转换为字典
    class func dicFromJsonString (json:String) -> [String:Any] {
        
        let jsonData:Data = json.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String:Any]
        }
        return [String:Any]()
    }
}
