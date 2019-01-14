//
//  WDBHomePageService.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

//定义接口名
enum WDBApiHomePage {
    //商铺账单
    case shopBillList(Dic:[String:Any])
    //经营数据
    //订单金额／统计
    case ordersStatistics(Dic:[String:Any])
    //订单总数量／总金额
    case ordersCountAndSum(Dic:[String:Any])
    //券发放统计
    case discountStatistics(Dic:[String:Any])
    //券分析
    case discountAnalyze(Dic:[String:Any])
    //顾客分析
    case customerAnalyze(Dic:[String:Any])
    //翻桌率统计
    case turnoverStatistics(Dic:[String:Any])
    //翻桌券分析
    case turnoverDiscountAnalyze(Dic:[String:Any])
    //推广分析
    case generalizeAnalyze(Dic:[String:Any])
    //扫码销券-获取券信息
    case getDiscountInfo(Dic:[String:Any])
    //扫码销券-获取用户信息
    case getDiscountOwnerUserInfo(Dic:[String:Any])
    //扫码销券-销券
    case checkDiscount(Dic:[String:Any])
    //获取用户所有店铺
    case userAllShops(Dic:[String:Any])
}

extension WDBApiHomePage: TargetType, AccessTokenAuthorizable {
    
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
        case .shopBillList(Dic: _):
            return "orders/order/statistics/shoporderlist"
        case .ordersStatistics(Dic: _):
            return "orders/order/statistics/orderCount"
        case .ordersCountAndSum(Dic: _):
            return "orders/order/statistics/getCountByShopId"
        case .discountStatistics(Dic: _):
            return "promotions/discount/statistics/shopDiscountCount"
        case .discountAnalyze(Dic: _):
            return "promotions/discount/statistics/compareDiscount"
        case .customerAnalyze(Dic: _):
            return "shops/shop/statistics/compareUser"
        case .turnoverStatistics(Dic: _):
            return "shops/shop/statistics/orderShopCount"
        case .turnoverDiscountAnalyze(Dic: _):
            return "promotions/discount/statistics/overturnShopDiscountNumber"
        case let .generalizeAnalyze(Dic: dic):
            let shopid = dic["shopId"] ?? ""
            return "promotions/discount/gtstatis/\(shopid)"
        case .getDiscountInfo(Dic: let dic):
            let discountid = dic["userDiscountid"] ?? ""
            return "promotions/user/dicount/getuserdiscountbyid/\(discountid)"
        case .getDiscountOwnerUserInfo(Dic: let dic):
            let userid = dic["userId"] ?? ""
            return "users/user/getuserbyid/\(userid)"
        case .checkDiscount(Dic: let dic):
            let userid = dic["userId"] ?? ""
            let discountid = dic["userDiscountid"] ?? ""
            return "promotions/user/dicount/verifidiscount/\(userid)/\(discountid)"
        case .userAllShops(Dic: _):
            return "shops/shop/page"
        }
    }
    
    //请求header
    public var headers: [String: String]? {
        return  nil
    }
    
    //请求方法
    public var method: Moya.Method {
        switch self {
        case .shopBillList(Dic: _):
            return .get
        case .ordersStatistics(Dic: _):
            return .get
        case .ordersCountAndSum(Dic: _):
            return .get
        case .discountStatistics(Dic:_):
            return .get
        case .discountAnalyze(Dic: _):
            return .get
        case .customerAnalyze(Dic: _):
            return .get
        case .turnoverStatistics(Dic: _):
            return .get
        case .turnoverDiscountAnalyze(Dic: _):
            return .get
        case .generalizeAnalyze(Dic: _):
            return .get
        case .getDiscountInfo(Dic: _):
            return .get
        case .getDiscountOwnerUserInfo(Dic: _):
            return .get
        case .checkDiscount(Dic: _):
            return .get
        case .userAllShops(Dic:_):
            return .get
        }
    }
    
    //请求参数
    //创建请求任务
    var task: Task {
        switch self {
        case let .shopBillList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .ordersStatistics(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .discountStatistics(Dic:dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .ordersCountAndSum(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .discountAnalyze(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .customerAnalyze(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverStatistics(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverDiscountAnalyze(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .generalizeAnalyze(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .getDiscountInfo(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .getDiscountOwnerUserInfo(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .checkDiscount(Dic: _):
            return .requestPlain
        case .userAllShops(Dic: let dic):
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
