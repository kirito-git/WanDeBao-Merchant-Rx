//
//  WDBApiPay.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/4.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya

enum WDBApiPay {
    case orderPay(dict: [String:Any])
}

extension WDBApiPay: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    //服务器根路径
    public var baseURL: URL {
        return URL(string: WDB_ServerUrl)!
    }
    
    //请求路径
    public var path: String {
        switch self {
        case let .orderPay(dict):
            let orderPayId = dict["orderPayId"] as! String
            let payType = dict["payType"] as! String
            
            return "orders/orderpay/payorder/\(orderPayId)/\(payType)"
      }
    }
    
    //请求方式
    public var method: Moya.Method {
        switch self {
        case  .orderPay(dict: _):
             return .get
      }
    }
    
    //请求的header
    public var headers: [String : String]? {
        return nil
    }
    
     //请求任务
    public var task: Task {
        switch self {
        case let .orderPay(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
    
    //简单的测试数据配置
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
}

