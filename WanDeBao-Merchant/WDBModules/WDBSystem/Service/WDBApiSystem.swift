//
//  WDBApiSystem.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Alamofire

 enum WDBApiSystem {
    case getOSSInfo //获取阿里云信息
    case uploadClientIdToServerWith(Dict: [String:Any]) // 上传clientId
 }

extension WDBApiSystem: TargetType, AccessTokenAuthorizable {
    
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
        case .getOSSInfo:
            return "systems/system/file/ossinfo"
        case let .uploadClientIdToServerWith(dict):
             let userId = dict["userId"] ?? ""
            return "users/user/setClinetId/\(userId)"
        }
    }
    
    // 请求header
    public var headers: [String:String]? {
        switch self {
        case .uploadClientIdToServerWith(Dict: _):
              return ["Authorization": "Basic dGVzdDp0ZXN0"]
        default:
             return ["Content-Type":"application/json"]
        }
        
    }
    
    // 请求方法
    public var method: Moya.Method {
        switch self {
        case .getOSSInfo:
            return .get
        case .uploadClientIdToServerWith(Dict: _):
            return .post
        }
    }
    
    //创建请求任务
    public var task: Task {
        switch self {
        case .getOSSInfo:
            return .requestPlain
        case let .uploadClientIdToServerWith(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
     //简单的测试数据配置
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    
}


