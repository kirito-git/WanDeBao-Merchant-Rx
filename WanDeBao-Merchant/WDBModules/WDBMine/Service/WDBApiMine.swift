//
//  WDBApiMine.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Alamofire


enum WDBApiMine {
    case queryAccount(Dict:[String:Any])
    case changeUserAvatar(Dict:[String:Any])
    case getUserInfo(userId:String)
    case getStoreOwnerInfo(ownerId:Int)
    //银行卡列表
    case getUserBankList(Dict:[String:Any])
    //绑定银行卡
    case bindUserBankCard(Dict:[String:Any])
    //连连充值
    case llpayRecharge(Dict:[String:Any])
    //提现
    case applyCash(Dict:[String:Any])
    //续费
    case queryIsHaveFreeTryService(shopId:String)
    case openStoreTryService(Dict:[String:Any])
    case queryStoreRenewalProductList(Dict:[String:Any])
    //统计线上金额和推广金额
    case getOnlineMoneyAndPromotionMoney(Dict:[String:Any])
    //意见反馈
    case suggestionFeedback(Dict:[String:Any])
    
}

extension WDBApiMine: TargetType, AccessTokenAuthorizable {
    
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
        case .queryAccount(Dict: _):
             return "shops/shop/account"
        case .changeUserAvatar(Dict: _):
            return "users/user/sethead"
        case let .getUserInfo(userId):
            return "users/user/\(userId)"
        case let .getStoreOwnerInfo(ownerId):
            return "shops/shop/owner/\(ownerId)"
        case .getUserBankList(Dict: _):
            return "shops/shop/card/list"
        case .bindUserBankCard(Dict: _):
            return "shops/shop/card"
        case .llpayRecharge(Dict: _):
            return "shops/shop/cash/recharge"
        case .applyCash(Dict: _):
            return "shops/shop/cash/applyCash"
        case .openStoreTryService(Dict: _):
            return "shops/shop/nst"
        case .queryStoreRenewalProductList(Dict: _):
            return "shops/shop/product/page"
        case let .queryIsHaveFreeTryService(shopId):
            return "shops/shop/ftp/\(shopId)"
        case .suggestionFeedback(Dict: _):
            return "platforms/platform/feedback/saveFeedback"
        case .getOnlineMoneyAndPromotionMoney(Dict: _):
            return "orders/order/statistics/getProxyPaySum"
        }
    }
    
    //请求header
    public var headers: [String:String]? {
        return nil
    }
    
    //请求方法
    public var method: Moya.Method {
         switch self {
        case .queryAccount(Dict: _),.getUserInfo(userId: _),.getStoreOwnerInfo(ownerId: _),.queryIsHaveFreeTryService(shopId: _),.queryStoreRenewalProductList(Dict: _),.getOnlineMoneyAndPromotionMoney(Dict: _),.getUserBankList(Dict: _):
             return .get
        case .changeUserAvatar(Dict: _),.openStoreTryService(Dict: _),.suggestionFeedback(Dict: _),.bindUserBankCard(Dict: _),.llpayRecharge(Dict: _),.applyCash(Dict: _):
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
        case let .queryAccount(dict):
             return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .changeUserAvatar(dict):
             return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .getUserInfo(userId):
            return .requestParameters(parameters: ["userId":userId], encoding: URLEncoding.default)
        case let .getStoreOwnerInfo(shopId):
            return .requestParameters(parameters: ["ownerId":shopId], encoding: URLEncoding.default)
        case .getUserBankList(Dict: let dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case .bindUserBankCard(Dict: let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .llpayRecharge(Dict: let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .applyCash(Dict: let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .queryStoreRenewalProductList(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .openStoreTryService(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .queryIsHaveFreeTryService(shopId):
            return .requestParameters(parameters:["shopId":shopId], encoding: URLEncoding.default)
        case let .suggestionFeedback(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .getOnlineMoneyAndPromotionMoney(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
    
    
}
