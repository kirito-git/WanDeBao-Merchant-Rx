//
//  ApiLogin.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/21.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

//定义接口名
enum WDBApiLogin {
    case getHash(phone:String, type:Int)
    case getCode(phone:String, type:Int, hashCode:String)
    case verifyCodeLogin(Dict: [String:Any]) //推荐使用这种
     case weChatLogin(dict: [String:Any])
//    case registerStore(Dict: [String:Any])
//    case queryCheckStatus(phone:String, userId:Int)
//    case verifyOldPhoneNumber(Dict: [String:Any])
//    case changePhoneNumber(Dict: [String:Any])
    case refreshToken(Dict: [String:Any])
    //case getBusinessCategory(Dict: [String:Any])
}

extension WDBApiLogin: TargetType {

   //服务器跟路径
    public var baseURL: URL {
        return URL(string: WDB_ServerUrl)!
    }

    //请求路径
    public var path: String {
        switch self {
        case .getHash(phone: _, type: _):
            return "code/hash"
        case .getCode(phone: _, type: _, hashCode: _):
            return "code/sms"
        case .verifyCodeLogin(Dict: _):
            return "authentication/phone"
        case .weChatLogin(dict: _):
            return "auth/weixinapp_wandebao"
//        case .registerStore(Dict: _):
//            return "shops/shop/owner"
//        case let .queryCheckStatus(phone, userId):
//            return "shops/shop/owner/\(userId)/\(phone)"
//        case .verifyOldPhoneNumber(Dict: _):
//            return "users/user/getusercert"
//        case .changePhoneNumber(Dict: _):
//            return "users/user/changeuserphone"
        case .refreshToken(Dict: _):
            return "oauth/token"
//        case .getBusinessCategory(Dict: _):
//            return "shops/shop/product/cate/findAllProductCate"
        }
    }
    //请求header
    public var headers: [String: String]? {
        return nil
 }
    
    //请求方法
    public var method: Moya.Method {
      switch self {
         case .getCode(phone: _, type: _, hashCode: _),.getHash(phone: _, type: _):
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
      case let .getHash(phone, type):
            return .requestParameters(parameters:["phone": phone, "type": type], encoding: URLEncoding.default)
      case .getCode(phone: let phone, type: let type, hashCode: let hashCode):
            return .requestParameters(parameters: ["phone": phone, "type": type, "hashCode": hashCode], encoding: URLEncoding.default)
     case  let .verifyCodeLogin(dict):
           return .requestParameters(parameters: dict, encoding: URLEncoding.default)
     case let .refreshToken(dict):
        return .requestParameters(parameters: dict, encoding: URLEncoding.default)
     case let .weChatLogin(dict):
        return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }

    //编码
    public var parameterEncoding: ParameterEncoding {
         return URLEncoding.default
     }
    
    // 是否开启Alomofire认证
     public var validate: Bool {
        return false
     }
    
    //可以自定义参数
    public var show:Bool {
         //是否显示转圈加载提示
         return true
    }
    
    
}

