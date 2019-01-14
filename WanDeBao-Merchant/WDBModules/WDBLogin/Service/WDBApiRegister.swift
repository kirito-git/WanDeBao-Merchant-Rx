//
//  WDBApiRegister.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/7/9.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import Moya
import Alamofire

//定义接口名
enum WDBApiRegister {
    case registerStore(Dict: [String:Any])
    case queryCheckStatus(phone:String, userId:Int)
    case verifyOldPhoneNumber(Dict: [String:Any])
    case changePhoneNumber(Dict: [String:Any])
    case getBusinessCategory(Dict: [String:Any])
}

extension WDBApiRegister: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    //服务器跟路径
    public var baseURL: URL {
        return URL(string: WDB_ServerUrl)!
    }
    
    //请求路径
    public var path: String {
        switch self {
        case .registerStore(Dict: _):
            return "shops/shop/owner"
        case let .queryCheckStatus(phone, userId):
            return "shops/shop/owner/\(userId)/\(phone)"
        case .verifyOldPhoneNumber(Dict: _):
            return "users/user/getusercert"
        case .changePhoneNumber(Dict: _):
            return "users/user/changeuserphone"
        case .getBusinessCategory(Dict: _):
            return "shops/shop/product/cate/findAllProductCate"
        }
    }
    //请求header
    public var headers: [String: String]? {
        return nil
    }
    //请求方法
    public var method: Moya.Method {
        switch self {
        case .queryCheckStatus(phone: _, userId: _), .getBusinessCategory(Dict: _):
            return .get
        default:
            return .post
        }
    }
    
    //简单的测试数据配置
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    //创建请求任务
    public var task: Task {
        
        switch self {
        case  let .registerStore(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .verifyOldPhoneNumber(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .changePhoneNumber(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .getBusinessCategory(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    //编码
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // 是否开启Alomofire认证
    public var validate: Bool {
        return true
    }
    
    //可以自定义参数
    public var show:Bool {
        //是否显示转圈加载提示
        return true
    }
    
    
}
