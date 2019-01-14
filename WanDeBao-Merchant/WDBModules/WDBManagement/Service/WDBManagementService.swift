//
//  WDBManagementService.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/24.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

//定义接口名
enum WDBApiManage {
    //获取店铺详情
    case getShopInfo(Dic:[String:Any])
    //修改店铺详情
    case changeShopInfo(Dic:[String:Any])
    //获取精品／新品列表
    case getExcellentProduct(Dic:[String:Any])
    //添加产品 精品&新品
    case addProduct(Dic:[String:Any])
    //删除商品
    case deleteProduct(Dic:[String:Any])
    //奖券管理-获取优惠券列表
    case getDiscountList(Dic:[String:Any])
    //奖券管理-添加奖券
    case discountAdd(Dic:[String:Any])
    //删除奖券
    case discountDelete(Dic:[String:Any])
    //奖券-积分管理-积分商品列表
    case intergralProductList(Dic:[String:Any])
    //奖券-积分管理-开启／关闭积分兑换
    case intergralExchangeOpen(Dic:[String:Any])
    //奖券-积分管理-添加积分商品
    case intergralProductAdd(Dic:[String:Any])
    //券-查询积分列表
    case intergralList()
    //设置翻桌率模式
    case setTurnoverType(shopId:String,pattern:String)
    //翻桌率-券使用信息查询
    case turnoverDiscountUseInfo(Dic:[String:Any])
    //翻桌率-餐桌查询
    case turnoverTableList(Dic:[String:Any])
    //翻桌率-增加新餐桌
    case turnoverTableAdd(Dic:[String:Any])
    //翻桌率-就餐开始
    case turnoverStartTakeFood(Dic:[String:Any])
    //翻桌率-就餐完成
    case turnoverEndTakeFood(Dic:[String:Any])
    //翻桌率管理-券管理
    case turnoverSearchDiscountInfo(shopId:String)
    //创建翻桌率
    case createTurnoverDiscount(Dic:[String:Any])
    //推广率-查询推广率详情
    case generalizeInfo(Dic:[String:Any])
    //推广率-创建推广率
    case createGeneralizeDiscount(Dic:[String:Any])
    //查询附近店铺
    case nearbyShopList(Dic:[String:Any])
    //游戏管理-店铺游戏
    case shopGameList(Dic:[String:Any])
    //游戏管理-平台所有游戏
    case allGameList()
    //游戏管理-添加游戏-下单
    case shopGameAddOrder(Dic:[String:Any])
    //游戏管理-添加游戏-支付
    case shopGameAddOrderPay(Dic:[String:Any])
}

extension WDBApiManage: TargetType,AccessTokenAuthorizable {
    
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
        case let .getShopInfo(Dic:dic):
            let shopid = dic["shopId"] ?? ""
            return "shops/shop/\(shopid)"
        case let .changeShopInfo(Dic:dic):
            let shopid = dic["shopId"] ?? ""
            return "shops/shop/\(shopid)"
        case .getExcellentProduct(Dic:_):
            return "shops/shop/product/page"
        case .addProduct(Dic: _):
            return "shops/shop/product"
        case .deleteProduct(Dic: let dic):
            let shopid = dic["shopId"] ?? ""
            return "shops/shop/product/\(shopid)"
        case .getDiscountList(Dic: let dic):
            let shopid = dic["shopId"] ?? ""
            return "promotions/discount/getdiscountlist/\(shopid)"
        case .discountAdd(Dic: _):
            return "promotions/discount/adddiscount"
        case let .discountDelete(Dic: dic):
            let shopid = dic["shopId"] ?? ""
            let discountId = dic["discountId"] ?? ""
            return "promotions/discount/\(shopid)/\(discountId)"
        case .intergralProductList(Dic: _):
            return "shops/shop/product/point/page"
        case .intergralExchangeOpen(Dic: _):
            return "shops/shop/startshoppoint"
        case .intergralProductAdd(Dic: _):
            return "shops/shop/product/shopvirtual"
        case .intergralList():
            return "platforms/platform/pointsDisc/findDisc"
        case .setTurnoverType(shopId: _, pattern: _):
            return "shops/shop/exchange"
        case .turnoverDiscountUseInfo(Dic: let dic):
            let shopid = dic["shopId"] ?? ""
            return "promotions/discount/turnmoney/\(shopid)"
        case .turnoverTableList(Dic: _):
            return "shops/shop/table/page"
        case .turnoverTableAdd(Dic: _):
            return "shops/shop/table"
        case .turnoverStartTakeFood(Dic: _):
            return "shops/shop/table/servingbegin"
        case .turnoverEndTakeFood(Dic: _):
            return "shops/shop/table/servingend"
        case .turnoverSearchDiscountInfo(shopId: let shopid):
            return "promotions/discount/turnover/\(shopid)"
        case .createTurnoverDiscount(Dic: _):
            return "promotions/discount/createtickets"
        case let .generalizeInfo(Dic: dic):
            let shopid = dic["shopId"] ?? ""
            return "promotions/discount/generamoney/\(shopid)"
        case .createGeneralizeDiscount(Dic: _):
            return "promotions/discount/creategeneralize"
        case .nearbyShopList(Dic: _):
            return "shops/shop/geography/local"
        case .shopGameList(Dic: _):
            return "games/shopgame/queryshopggameinfopage"
        case .allGameList():
            return "shops/shop/product/page"
        case .shopGameAddOrder(Dic: _):
            return "orders/orderunion/userbuyproduct"
        case .shopGameAddOrderPay(Dic: let dic):
            let orderPayId = dic["orderPayId"]
            let payType = dic["payType"]
            return "orderpay/payorder/\(String(describing: orderPayId))/\(String(describing: payType))"
        }
    }
    
    //请求header
    public var headers: [String: String]? {
        return  nil
    }
    
    //请求方法
    public var method: Moya.Method {
        switch self {
        case .getShopInfo(Dic:_):
            return .get
        case .changeShopInfo(Dic:_):
            return .put
        case .getExcellentProduct(Dic:_):
            return .get
        case .addProduct(Dic: _):
            return .post
        case .deleteProduct(Dic: _):
            return .delete
        case .getDiscountList(Dic: _):
            return .get
        case .discountAdd(Dic: _):
            return .post
        case .discountDelete(Dic: _):
            return .delete
        case .intergralProductList(Dic: _):
            return .get
        case .intergralExchangeOpen(Dic: _):
            return .post
        case .intergralProductAdd(Dic: _):
            return .post
        case .intergralList():
            return .get
        case .setTurnoverType(shopId: _, pattern: _):
            return .post
        case .turnoverDiscountUseInfo(Dic: _):
            return .get
        case .turnoverTableList(Dic: _):
            return .get
        case .turnoverTableAdd(Dic: _):
            return .post
        case .turnoverStartTakeFood(Dic: _):
            return .post
        case .turnoverEndTakeFood(Dic: _):
            return .post
        case .turnoverSearchDiscountInfo(shopId: _):
            return .get
        case .createTurnoverDiscount(Dic: _):
            return .post
        case .generalizeInfo(Dic: _):
            return .get
        case .createGeneralizeDiscount(Dic: _):
            return .post
        case .nearbyShopList(Dic: _):
            return .get
        case .shopGameList(Dic: _):
            return .get
        case .allGameList():
            return .get
        case .shopGameAddOrder(Dic: _):
            return .post
        case .shopGameAddOrderPay(Dic: _):
            return .post
        }
    }
    
    //请求参数
    //创建请求任务
    var task: Task {
        switch self {
        case .getShopInfo(Dic:_):
            return .requestPlain
        case let .changeShopInfo(Dic:dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .getExcellentProduct(Dic:dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .addProduct(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .deleteProduct(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .getDiscountList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .discountAdd(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .discountDelete(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .intergralProductList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .intergralExchangeOpen(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .intergralProductAdd(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .intergralList():
            return .requestPlain
        case let .setTurnoverType(shopId: shopid, pattern: pattern):
            return .requestParameters(parameters: ["shopId":shopid,"pattern":pattern], encoding: URLEncoding.default)
        case let .turnoverDiscountUseInfo(Dic:dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverTableList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverTableAdd(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverStartTakeFood(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .turnoverEndTakeFood(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .turnoverSearchDiscountInfo(shopId: _):
            return .requestPlain
        case let .createTurnoverDiscount(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .generalizeInfo(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .createGeneralizeDiscount(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .nearbyShopList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case let .shopGameList(Dic: dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .allGameList():
            return .requestParameters(parameters: ["shopId":"0"], encoding: URLEncoding.default)
        case .shopGameAddOrder(Dic: let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .shopGameAddOrderPay(Dic: let dic):
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

