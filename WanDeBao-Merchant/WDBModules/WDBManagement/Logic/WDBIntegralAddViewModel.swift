//
//  WDBInteralAddViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import SwiftyJSON

class WDBIntergralAddViewModel {
    
    //列表数据 优惠券
    let discountList = BehaviorRelay<[WDBDiscountModel]>(value:[])
    //积分列表
    let intergrals = BehaviorRelay<[WDBIntergralModel]>(value:[])
    //停止刷新
    let endRefresh:Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        
        //优惠券列表 在优惠券viewModel中
        let headerData = headerRefresh
            .startWith(())
            .flatMapLatest{_ in WDBDiscountManageViewModel.getDiscountList()}
        
        self.endRefresh = Driver<Bool>.of(false)
            .flatMap{_ in return headerData.map{_ in true}}
        
        _ = headerData.asObservable().subscribe(onNext:{models in
            self.discountList.accept(models)
        })
        
        //积分列表
        _ = Observable<Void>.of(())
            .startWith(())
            .flatMapLatest{_ in self.intergralProductList()}
            .subscribe(onNext:{ models in
                self.intergrals.accept(models)
            })
    }
    
    //积分列表
    func intergralProductList() -> Observable<[WDBIntergralModel]> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.intergralList()))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBIntergralModel.self)
            .retry(1)
    }
    
    //添加积分商品
    func intergralProductAdd(intergral: WDBIntergralModel,choseModel:WDBDiscountModel) -> Observable<Any> {
        let discountModel = choseModel
        let intergralModel = intergral
        let name = discountModel.discount?.discountName ?? ""
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let type = String(describing: discountModel.discount?.type ?? 0)
        let times = String(describing:discountModel.discount?.times ?? 0)
        let timesType = "3"
        let point = String(describing: intergralModel.value!)
        let targetId = String(describing: intergralModel.intergralId!)
        let number = String(describing: discountModel.conditionList?.number ?? 0)
        let params = ["name":name,"shopId":shopId,"type":type,"times":times,"timesType":timesType,"point":point,"targetId":targetId,"number":number] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.intergralProductAdd(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
    }
}
