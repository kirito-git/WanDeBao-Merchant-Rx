//
//  WDBIntergralManageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class WDBDiscountIntegralExchangeViewModel {
    
    //初始化列表数据
    let intergralList = BehaviorRelay<[WDBProductModel]>(value:[])
    //返回主动请求
    let refreshRequest = PublishSubject<Any>()
    //是否返回此页面
    let isViewDidLoad = Variable(false)
    //是否开启积分兑换
    let openExchange = Variable(false)
    //tableview高度
    let tableHeight = Variable(SCREEN_HEIGHT-kNavibarH-iPhoneXBottomBarH)
    
    let endRefresh:Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        let headerData = headerRefresh
        .startWith(())
            .flatMapLatest{ _ in WDBDiscountIntegralExchangeViewModel.intergralProductList()}
        
        self.endRefresh = Driver<Bool>.of(false)
            .flatMap{_ in return headerData.map{_ in true}}
            .asDriver(onErrorDriveWith: Driver.empty())
       
        //返回时主动请求一次
        _ = self.refreshRequest
            .flatMapLatest{ _ in WDBDiscountIntegralExchangeViewModel.intergralProductList()}
            .subscribe(onNext:{ models in
                self.intergralList.accept(models)
            })
        
        _ = headerData.asObservable().subscribe(onNext:{ models in
            self.intergralList.accept(models)
        })
    }
    
    //积分商品列表
    class func intergralProductList() -> Driver<[WDBProductModel]> {
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"types":"5","status":"1"]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.intergralProductList(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBProductModel.self, key: "result").retry(2)
            .asDriver(onErrorJustReturn: [])
    }
    
    //开启／关闭积分兑换
    func intergralExchangeOpen() -> Observable<Any> {
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        var startPoint = "0"
        if !self.openExchange.value {
            startPoint = "1"
        }
        let params = ["shopId":shopid,"startPoint":startPoint]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.intergralExchangeOpen(Dic:params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().retry(1)
        result.subscribe(onNext: { (resp) in
            let respData:[String:Any] = resp as! [String:Any]
            if respData["error_mesg"] == nil {
                if startPoint == "0" {
                    //关闭成功
                    self.openExchange.value = false
                    self.tableHeight.value = SCREEN_HEIGHT-kNavibarH-iPhoneXBottomBarH
                }else {
                    //开启成功
                    self.openExchange.value = true
                    self.tableHeight.value = SCREEN_HEIGHT-kNavibarH-iPhoneXBottomBarH-50
                }
            }
        }, onError: {error in
            if startPoint == "0" {
                //关闭失败
                self.openExchange.value = true
                self.tableHeight.value = SCREEN_HEIGHT-kNavibarH-iPhoneXBottomBarH-50
            }else {
                //开启失败
                self.openExchange.value = false
                self.tableHeight.value = SCREEN_HEIGHT-kNavibarH-iPhoneXBottomBarH
            }
            print(error)
        }, onCompleted: nil, onDisposed: nil)
        return result
    }
    
    //添加积分商品
    func intergralProductAdd(dic:[String:Any]) -> Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.intergralProductAdd(Dic: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().retry(1)
    }
    
    //删除积分商品
    func deleteIntergralProduct(row:Int) -> Observable<Any> {
        let model = self.intergralList.value[row]
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let discountId = String(describing: model.productId ?? 0)
        let params = ["shopId":shopid,"ids":discountId]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.deleteProduct(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        return result
    }
}
