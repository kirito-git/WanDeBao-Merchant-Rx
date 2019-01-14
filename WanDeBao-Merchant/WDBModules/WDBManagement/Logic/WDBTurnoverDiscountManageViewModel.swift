//
//  WDBTurnoverManageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON
import ObjectMapper

class WDBTurnoverDiscountManageViewModel {

    var times = Variable("")
    var price = Variable("")
    let toshopIds = Variable("")
    
    var confirmVaild: Observable<Bool>
    
    let choseStoreList = BehaviorRelay<[WDBShopModel]>(value:[])
    
    init() {
        self.confirmVaild = Observable.of(times,price,toshopIds)
            .map{$0.value.count > 0}
        
        _ = self.turnoverSearchDiscountInfo().subscribe(onNext:{ model in
            //获取上次设置
            self.times.value = String(describing: model.redPacket!)
            self.price.value = String(describing: model.times!)
            let dataArray = self.WDBShopModelFromWDBTurnoverShopModel(array: model.shopList!)
            self.choseStoreList.accept(dataArray)
            self.initShopIds(array: model.shopList!)
        })
    }
    
    //查询上一次设置
    func turnoverSearchDiscountInfo() -> Observable<WDBTurnoverModel> {
        let shopid:String = WDBGlobalDataUserDefaults.getShopID()
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverSearchDiscountInfo(shopId: shopid)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBTurnoverModel.self)
            .retry(1)
        return result
    }
    
    //创建翻桌率
    func createTurnoverDiscount() -> Observable<Any> {
        let shopids = self.toshopIds.value
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let redPacket = self.price.value
        let times = self.times.value
        let params = ["shopId":shopid,"times":times,"redPacket":redPacket,"toshopIds":shopids]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.createTurnoverDiscount(Dic: params)))
            .mapJSON()
            .asObservable()
            .retry(1)
    }
    
    //初始化shopids
    func initShopIds(array:[WDBTurnoverShopModel]) -> String {
        var shopIds = ""
        for i in 0..<array.count {
            let model = array[i]
            let shopid = String(describing:model.shopId ?? 0)
            if shopIds.count == 0 {
                shopIds.append(String(format:"%@",shopid))
            }else {
                shopIds.append(String(format:",%@",shopid))
            }
        }
        print(shopIds)
        self.toshopIds.value = shopIds
        return shopIds
    }
    
    
    //将WDBTurnoverShopModel 转化为 WDBShopModel
    func  WDBShopModelFromWDBTurnoverShopModel(array:[WDBTurnoverShopModel]) -> [WDBShopModel] {
        var models = [WDBShopModel]()
        for i in 0..<array.count {
            let turnoverModel = array[i]
            var dic = [String:Any]()
            dic["shopId"] = turnoverModel.shopId ?? 0
            dic["shopName"] = turnoverModel.shopName
            let newModel = WDBShopModel(JSONString:JSONTools.jsonStringFromDataDic(dic: dic))
            models.append(newModel!)
        }
        return models
    }

}
