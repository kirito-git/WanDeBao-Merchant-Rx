//
//  WDBGameManageAddViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import SwiftyJSON

class WDBGameManageAddViewModel {

    //tableview数据
    var gameSection = BehaviorRelay<[GameAddSection]>(value:[GameAddSection(header:"0",items:[])])
    //选中的商品
    var selectProducts = BehaviorRelay<[WDBProductModel]>(value:[])
    //标记数组
    var markArray = BehaviorRelay<[Bool]>(value:[])
    
    //选中的商品拼接
    var productJson = Variable("")
    //var confirmVaild: Observable<Bool>
    //可否支付
    var payVaild: Observable<Bool>
    
    var endHeaderRefresh:Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        
//        //用户选择了商品才能进行下单
//        self.confirmVaild = self.getProductJson()
//            .map{ $0.count>0 }
//            .share(replay: 1)
        
        //是否安装支付宝或者微信
        self.payVaild = Observable<Bool>.of(false)
            .map{ (_) -> Bool in
                let isInstallWX = WXApi.isWXAppInstalled()
                var isInstallAlipay = false
                if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!) {
                    isInstallAlipay = true
                }
                if !isInstallAlipay && !isInstallWX {
                    return false
                }
                return true
            }
            .share(replay: 1)
        
        //下拉刷新序列
        let headerRefreshData = headerRefresh.asObservable()
            .startWith(())
            .flatMapLatest{WDBGameManageAddViewModel.allGameList()}
        
        self.endHeaderRefresh = Observable.of(false)
            .flatMap{_ in headerRefreshData.map{_ in true}}
            .asDriver(onErrorDriveWith: Driver.empty())
        
        _ = headerRefreshData.subscribe(onNext:{ array in
            //保存列表数据
            self.gameSection.accept([GameAddSection(header:"0",items:array)])
            //初始化标记数组
            let marks = array.flatMap{_ in return false}
            self.markArray.accept(marks)
        })
        
    }
    
    //查询平台所有游戏
    class func allGameList() -> Observable<[WDBProductModel]> {
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.allGameList()))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBProductModel.self, key: "result").retry(2)
        return result
    }
    
    //下单
    func gamesAddOrder() -> Observable<WDBOrderModel> {
        
        var params = [String:Any]()
        let productjson = self.productJson.value
        let productjsonStr = JSON(productjson)
        let products = productjsonStr.rawString(.utf8, options: .init(rawValue: 0))!
        params["choosedShopProductJson"] = products
        params["takeType"] = "0"
        params["orderUnionType"] = "7"
        params["phone"] = ""
        params["shopRealName"] = WDBGlobalDataUserDefaults.getShopName()
        params["shoppingWay"] = "5"
        params["isSave"] = "1"
        params["appcode"] = "1"
        params["appid"] = "1"
        params["fromShopId"] = WDBGlobalDataUserDefaults.getShopID()
        
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.shopGameAddOrder(Dic: params)))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .asObservable()
        .mapObject(type: WDBOrderModel.self).retry(2)
    }
    
    //支付
    func gamesAddOrderPay(dic:[String:Any]) -> Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.shopGameAddOrderPay(Dic: dic)))
            .mapJSON()
            .asObservable().retry(2)
    }
    
    //tableview点击
    func tableSelect(row:Int) {
        var marks = self.markArray.value
        let isSelect = marks[row]
        marks[row] = !isSelect
        self.markArray.accept(marks)
        self.gameSection.accept(self.gameSection.value)
    }
    
    //拼接所有选中的商品 jsonStr
    func getProductJson() -> Observable<Bool> {
        var products = [[String:Any]]()
        let items = self.gameSection.value[0].items
        var selectModels = [WDBProductModel]()
        for (index,item) in items.enumerated() {
            let isSelected = self.markArray.value[index]
            if isSelected {
                let model = item
                var dicData = [String:Any]()
                dicData["ShopId"] = String(describing: model.shopId ?? 0)
                dicData["ShopProductId"] = String(describing: model.productId ?? 0)
                dicData["ShopProductName"] = model.name
                dicData["num"] = "1"
                dicData["cateId"] = String(describing: model.cateId ?? 0)
                dicData["productUrl"] = model.productIcoUrl
                dicData["showPrice"] = String(describing: model.shopPrice ?? 0.0)
                dicData["sellPrice"] = String(describing: model.price ?? 0.0)
                dicData["costPrice"] = "0"
                dicData["points"] = String(describing: model.point ?? 0)
                products.append(dicData)
                
                selectModels.append(model)
            }
        }
        //将数组转化为字符串
        let data = try? JSONSerialization.data(withJSONObject: products, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        print(strJson ?? "")
        
        let resultStr1 = strJson?.replacingOccurrences(of: "\n", with: "")
        let resultStr2 = resultStr1?.replacingOccurrences(of: "  ", with: "")
        let resultStr3 = resultStr2?.replacingOccurrences(of: "    ", with: "")
        let ch:Character = Character(UnicodeScalar(92)!)
        let resultStr4 = resultStr3?.replacingOccurrences(of: String(ch), with: "")
        
        //保存选中的商品数组
        self.selectProducts.accept(selectModels)
        //保存拼接好的字符串
        self.productJson.value = resultStr4 ?? ""
        
        return Observable<Bool>.of(selectModels.count > 0)
    }
        
    
}


//定义一个gameadd的sectionModel
struct GameAddSection {
    var header: String
    var items: [Item]
}
extension GameAddSection: SectionModelType {
    
    typealias Item = WDBProductModel
    
    var identity: String {
        return header
    }
    
    init(original: GameAddSection, items: [Item]) {
        self = original
        self.items = items
    }
}



