//
//  WDBMessageService.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

//定义接口名
enum WDBApiMessage {
    //消息列表
    case messageList(Dic:[String:Any])
    //消息详情
    case messageDetail(Dic:[String:Any])
}

extension WDBApiMessage: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    //服务器根路径
    public var baseURL: URL {
        return URL(string: WDB_ServerUrl)!
    }
    
    //请求路径
    public var path: String {
        switch self {
        case .messageList(Dic: _):
            return "systems/system/message/findMessage"
        case .messageDetail(Dic:let dic):
            let id = dic["id"] as! String
            return "systems/system/message/findContentById/\(id)"
        }
    }
    
    //请求header
    public var headers: [String: String]? {
        return  nil
    }
    
    //请求方法
    public var method: Moya.Method {
        switch self {
        case .messageList(Dic: _):
            return .get
        case .messageDetail(Dic: _):
            return .get
        }
    }
    
    //请求参数
    //创建请求任务
    var task: Task {
        switch self {
        case let .messageList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .messageDetail(Dic: let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        }
    }
    
    //编码
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var validate: Bool {
        return false
    }
}

