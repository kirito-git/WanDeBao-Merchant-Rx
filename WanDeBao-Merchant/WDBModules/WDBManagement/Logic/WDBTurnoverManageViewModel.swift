//
//  WDBTurnoverManageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import SwiftyJSON
import ObjectMapper

class WDBTurnoverManageViewModel {
    
    //collection数据
    let tableDatas = BehaviorRelay<[TurnOverManageSection]>(value:[TurnOverManageSection(items:[])])
    //刷新数据
    let refreshRequest = PublishSubject<Any>()
    
    let totalNum = Variable("0")
    let givePrice = Variable("0")
    let todayGivePrice = Variable("0")
    
    //点击了结束还是开始
    let isStart = Variable(false)
    //结束或开始的提示
    let startOrEndTips = Variable("")
    
    var endRefresh: Driver<Bool>
    
    init(headerRefresh: Driver<Void>){
        
        let headerData = headerRefresh
            .startWith(())
            .flatMapLatest{WDBTurnoverManageViewModel.turnoverTableList()}
        
        //停止刷新
        self.endRefresh = Driver<Bool>.of(false)
            .flatMap{_ in headerData.map{_ in true}}
        
        //保存请求的数据
        _ = headerData.asObservable().subscribe(onNext:{ models in
            //多加一个cell 作为加号
            //字典转模型
            let model = WDBTableModel(JSON: ["tableId":"99999"])
            var array:[WDBTableModel] = models
            array.append(model!)
            self.tableDatas.accept([TurnOverManageSection(items:array)])
        })
        
        //获取翻桌率券信息
        _ = self.turnoverDiscountUseInfo().subscribe({ Event in
            let model = Event.element
            self.totalNum.value = String(describing:model?.number ?? 0)
            self.givePrice.value = String(describing:model?.factorValue ?? 0)
            self.todayGivePrice.value = String(describing:model?.sum ?? 0)
        })
        
        _ = self.refreshRequest
            .flatMapLatest{_ in WDBTurnoverManageViewModel.turnoverTableList()}
            .subscribe(onNext:{ models in
                //多加一个cell 作为加号
                //字典转模型
                let model = WDBTableModel(JSON: ["tableId":"99999"])
                var array:[WDBTableModel] = models
                array.append(model!)
                self.tableDatas.accept([TurnOverManageSection(items:array)])
            })
    }
    
    //获取翻桌率券信息
    func turnoverDiscountUseInfo() -> Observable<WDBGeneralizeModel> {
        
        let tuple = DateFormatTool.getTodayStartAndEndTimeStamp()
        let startTime = String(format:"%.0f",tuple.0 * 1000)
        let endTime = String(format:"%.0f",tuple.1 * 1000)
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"startTime":startTime,"endTime":endTime]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverDiscountUseInfo(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBGeneralizeModel.self)
            .retry(2)
    }
    
    //获取餐桌列表
    class func turnoverTableList() -> Driver<[WDBTableModel]> {
        //请求餐桌列表
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopId,"page":"1","size":"100","status":"1"]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverTableList(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBTableModel.self, key: "result")
            .retry(1)
            .asDriver(onErrorJustReturn: [])
        return result
    }
    
    //添加餐桌
    func turnoverTableAdd(tableNum:String) -> Observable<Any> {
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopId,"tableNum":tableNum,"type":"0","status":"1"]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverTableAdd(Dic: params)))
            .mapJSON().retry(2)
            .asObservable()
    }
    
    //开始还是结束
    func startOrEndTakeFoodRequest(index: Int) -> Observable<Any> {
        let model = self.tableDatas.value[0].items[index]
        var tips:String?
        var isStart:Bool?
        if model.servingStatus == 1 {
            //原状态为开始 置为结束
            tips = "是否设置结束就餐？"
            isStart = false
        }else {
            tips = "是否设置开始就餐？"
            isStart = true
        }
        self.startOrEndTips.value = tips!
        self.isStart.value = isStart!
        
        return Observable.of(())
    }
    
    //就餐开始
    func turnoverStartTakeFood(index:Int) -> Observable<Any> {
        let model = self.tableDatas.value[0].items[index]
        let tableid = String(describing: model.tableId ?? 0)
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"tableId":tableid]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverStartTakeFood(Dic: params)))
            .mapJSON()
            .asObservable()
            .retry(2)
    }
    
    //就餐结束
    func turnoverEndTakeFood(index:Int) -> Observable<Any> {
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let model = self.tableDatas.value[0].items[index]
        let tableid = String(describing: model.tableId ?? 0)
        let params = ["shopId":shopId,"tableId":tableid]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.turnoverEndTakeFood(Dic: params)))
            .mapJSON()
            .asObservable()
            .retry(2)
    }
    
}


//定义一个SectionModelType的section
struct TurnOverManageSection {
    
    var items:[Item]
}

extension TurnOverManageSection: SectionModelType {
    
    typealias Item = WDBTableModel
    
    init(original: TurnOverManageSection, items: [Item]) {
        self = original
        self.items = items
    }
}
