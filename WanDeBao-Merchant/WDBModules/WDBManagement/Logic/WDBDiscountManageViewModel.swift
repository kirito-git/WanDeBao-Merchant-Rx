//
//  WDBDiscountViewModel.swift
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

class WDBDiscountManageViewModel {
    
    //列表数据 有初始值
    let dataArray = BehaviorRelay<[WDBDiscountModel]>(value:[])
    //添加优惠券时 选择优惠券类型
    let discountTypes = BehaviorRelay<[String]>(value: ["8","5","4","6"])
    //刷新请求 viewWillAppear的时候刷新
    var refreshRequest = PublishSubject<Any>()
    
    var endHeaderRefresh: Driver<Bool>
    
    init(headerRefresh: Driver<Void>) {
        
        let headerRefreshData =  headerRefresh
            .startWith(())
            .flatMapLatest{ _ in WDBDiscountManageViewModel.getDiscountList() }
        
        self.endHeaderRefresh = Driver<Bool>.just(false)
            .flatMap{_ in headerRefreshData.map{_ in true} }
            .asDriver(onErrorDriveWith: Driver.empty())
        
        //刷新请求
        _ = self.refreshRequest.asObservable()
            .flatMapLatest{ _ in WDBDiscountManageViewModel.getDiscountList() }
            .subscribe(onNext:{ models in
                self.dataArray.accept(models)
            })
        
        //获取数据
        _ = headerRefreshData.asObservable()
            .subscribe(onNext:{ models in
                self.dataArray.accept(models)
            })
    }
    
    //获取优惠券列表
    class func getDiscountList() -> Driver<[WDBDiscountModel]> {
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"page":"1","size":"100"]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.getDiscountList(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBDiscountModel.self, key: "result").retry(2)
            .asDriver(onErrorJustReturn: [])
    }
    
    //删除优惠券
    func discountDelete(row:Int) -> Observable<Any> {
        let model = self.dataArray.value[row]
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let discountId = String(describing: model.discount?.discountId ?? 0)
        let params = ["shopId":shopid,"discountId":discountId]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.discountDelete(Dic: params)))
            .mapJSON()
            .asObservable().retry(2)
    }
}
