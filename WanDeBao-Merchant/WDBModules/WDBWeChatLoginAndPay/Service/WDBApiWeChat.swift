//
//  WDBApiWeChat.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/6.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

enum WDBApiWeChat {
    case weChatBindPhone(dict: [String:Any])
    case bindWeChat(dict: [String:Any])
}


extension WDBApiWeChat: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    //请求根路径
    public var baseURL: URL {
        return URL(string: WDB_ServerUrl)!
    }
    
    //请求路径
    public var path: String {
        switch self {
        case .weChatBindPhone(dict: _):
            return "users/user/bindphone"
        case .bindWeChat(dict: _):
            return "users/user/bindwxsocial"
        }
    }
    
    // 请求header
    public var headers: [String:String]? {
           return nil
    }
    
    // 请求方法
    public var method: Moya.Method {
        return .post
    }
    
    //创建请求任务
    public var task: Task {
        
        switch self {
        case let .weChatBindPhone(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .bindWeChat(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
    //简单的测试数据配置
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    
    

}
