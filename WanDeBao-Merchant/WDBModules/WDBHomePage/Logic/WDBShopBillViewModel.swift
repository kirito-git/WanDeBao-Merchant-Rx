//
//  WDBShopBillViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class WDBShopBillViewModel {
    
    let billList = BehaviorRelay<[WDBShopBillModel]>(value:[])
    
    var endRefresh:Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        let refreshData = headerRefresh
            .flatMapLatest{WDBShopBillViewModel.shopBillList()}
        
        self.endRefresh = Driver.of(false)
            .flatMap{_ in refreshData.map{_ in true}}
        
        _ = refreshData.drive(onNext:{ items in
            self.billList.accept(items)
        })
    }
    
    //账单
    class func shopBillList() -> Driver<[WDBShopBillModel]> {
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"page":"1","size":"100"]
        return defaultProvider.rx.request(MultiTarget(WDBApiHomePage.shopBillList(Dic:params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBShopBillModel.self, key: "result")
            .retry(1)
            .asDriver(onErrorJustReturn: [])
    }
}
