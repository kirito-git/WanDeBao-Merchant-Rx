//
//  WDBProductManageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class WDBProductManageViewModel {

    //列表数据
    let products = BehaviorRelay<[WDBProductModel]>(value:[])
    //重新请求一次
    let refreshRequest = PublishSubject<Any>()
    //停止刷新状态序列
    let endHeaderRefreshing: Driver<Bool>
    //viewmodel是否已经创建（viewDidLoad已经加载过了）
    let viewdidLoad = Variable(false)
    
    init(input:(headerRefresh: Driver<Void>,isQuality:Bool)) {
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(())
            .flatMapLatest{_ in WDBProductManageViewModel.getExcellentProduct(isQuality: input.isQuality)}
        
        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = Driver.merge(
            headerRefreshData.map{_ in true}
        )
        
        //重新请求一次数据
        _ = self.refreshRequest
            .flatMapLatest{_ in WDBProductManageViewModel.getExcellentProduct(isQuality: input.isQuality)}
            .subscribe(onNext:{ items in
                self.products.accept(items)
            })
        
        headerRefreshData.drive(onNext:{ items in
            self.products.accept(items)
        }).disposed(by: disposeBag)
    }
    
    //获取商品列表
    class func getExcellentProduct(isQuality:Bool) -> Driver<[WDBProductModel]> {
        let isNew = isQuality ? "0" : "1"
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let params = ["status":"1","shopId":shopId,"isnew":isNew,"type":"1","page":"1","size":"100"]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.getExcellentProduct(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBProductModel.self, key: "result").retry(2)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
    
    //删除商品
    func deleteProduct(row:Int) -> Observable<Any> {
        let model = self.products.value[row]
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let discountId = String(describing: model.productId ?? 0)
        let params = ["shopId":shopid,"ids":discountId]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.deleteProduct(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().retry(1)
    }
}
