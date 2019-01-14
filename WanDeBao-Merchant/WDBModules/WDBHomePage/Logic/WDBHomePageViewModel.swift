//
//  WDBHomePageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/24.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import SwiftyJSON
import ObjectMapper

class WDBHomePageViewModel {
    
    //cell数据
    var homeCellDats = BehaviorRelay<[Int]>(value:[0,1,2,3,4])
    
    var chart1Models = [WDBOrderChartModel]() //经营统计
    var chart2Models = [WDBDiscountChartModel]() //券统计
    var chart3Models = [0.0,0.0,0.0,0.0,0.0,0.0,0.0] //翻桌率统计
    
    var shopsArray = [WDBMineShopModel]()
    
    let cellHeights = ["380","300","242","300","242"]
    
    //一区
    let totalSum = Variable("0")
    let orderNumber = Variable("0")
    //三区
    let allDiscountCount = Variable("0")
    let useDiscountCount = Variable("0")
    let oldUser = Variable("0")
    let newUser = Variable("0")
    //五区
    let allDiscountCount5 = Variable("0")
    let useDiscountCount5 = Variable("0")
    let oldUser5 = Variable("0")
    let newUser5 = Variable("0")
    
    let endRefresh = Variable(false)
    //重新请求首页数据
    var refreshRequest = PublishSubject<Any>()
        
    //*************** 网络请求需要的数据 *******************
    
    //本月月初和月末的日期
    let startTimestamp = Variable("")
    let endTimestamp = Variable("")
    //本月天数
    let currentMonthDays = Variable(30)
    //昨日起始时间
    let yesterdayStartTimestamp = Variable("")
    let yesterdayEndTimestamp = Variable("")
    //最近七小时的小时数组
    let recent7Hours = BehaviorRelay<[Int]>(value:[])
    //最近七小时起始时间戳
    let recent7HourStartTimestamp = Variable("")
    let recent7HourEndTimestamp = Variable("")
    
    init() {
        
        //返回本月月初时间戳 月末时间戳 今日日期  本月天数
        let tuple:(Double,Double,Int,Int) = DateFormatTool.currentDaysOfMonthCount()
        //本月月初日期
        startTimestamp.value = String(format:"%.0f", tuple.0 * 1000)
        //本月月末日期
        endTimestamp.value = String(format:"%.0f", tuple.1 * 1000)
        //print("\(startTimestamp)--\(endTimestamp)")
        //当前天数
        currentMonthDays.value = tuple.3
        //昨日起始结束时间
        let yesterdayTuple = DateFormatTool.getYesterdayTimeStamp()
        //昨日开始时间
        yesterdayStartTimestamp.value = String(format: "%.0f",yesterdayTuple.0 * 1000)
        //昨日结束时间
        yesterdayEndTimestamp.value = String(format: "%.0f",yesterdayTuple.1 * 1000)
        //最近7小时的小时数组
        let recent7HourArray = DateFormatTool.getCurrentHourTimestamp()
        recent7Hours.accept(recent7HourArray)
        //获取最近7小时的起始和结束时间
        let recent7HourTuple = DateFormatTool.getRecent7HourStartTimeAndEndTime()
        //7小时之前的时间戳
        recent7HourStartTimestamp.value = String(format: "%.0f",recent7HourTuple.0 * 1000)
        //现在的时间戳
        recent7HourEndTimestamp.value = String(format:"%.0f",recent7HourTuple.1 * 1000)
        
        //刷新数据
        _ = refreshRequest.flatMapLatest{_ in self.combineRequest().asObservable()}
            .subscribe(onNext:{
                self.homeCellDats.accept([0,1,2,3,4])
            })
    }
    
    func combineRequest() -> Driver<Void> {
        
        //经营数据 此处是昨日的数据
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result1 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.ordersCountAndSum(Dic:params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        _ = result1.subscribe(onNext:{ response in
            if let resp = response as? [String:Any] {
                let totalsum = resp["totalSum"]
                if !(totalsum is NSNull) && totalsum != nil {
                    self.totalSum.value = String(describing: totalsum ?? 0)
                }
                let ordernumber = resp["orderNumber"]
                if !(ordernumber is NSNull) && ordernumber != nil {
                    self.orderNumber.value = String(describing: ordernumber ?? 0)
                }
            }
            self.endRefresh.value = true
        })
        
        //经营统计图
        let params2 = ["shopId":shopid,"startTime":startTimestamp.value,"endTime":endTimestamp.value,"status":"5"]
        let result2 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.ordersStatistics(Dic:params2)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBOrderChartModel.self)
            .retry(1)
        _ = result2.subscribe(onNext:{ array in
            let newArray = self.resetChart1Data(array: array)
            self.chart1Models = newArray
        })
        
        //券发放统计 最近7小时
        let params3 = ["shopId":shopid,"startTime":recent7HourStartTimestamp.value,"endTime":recent7HourEndTimestamp.value]
        let result3 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.discountStatistics(Dic:params3)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBDiscountChartModel.self)
            .retry(1)
        _ = result3.subscribe(onNext:{array in
            let newArray = self.resetChart2Data(array: array)
            self.chart2Models = newArray
        })

        //券分析 昨日
        let params4 = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result4 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.discountAnalyze(Dic:params4)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        _ = result4.subscribe(onNext:{ response in
            if let resp = response as? [String:Any] {
                self.allDiscountCount.value = String(describing: resp["allDiscountCount"] ?? 0)
                self.useDiscountCount.value = String(describing: resp["useDiscountCount"] ?? 0)
            }
        })
        
        //顾客分析
        let params5 = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result5 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.customerAnalyze(Dic:params5)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        _ = result5.subscribe(onNext:{ response in
            if let resp = response as? [String:Any] {
                self.oldUser.value = String(describing:resp["oldUser"] ?? 0)
                self.newUser.value = String(describing:resp["newUser"] ?? 0)
            }
        })
        
        //翻桌率统计
        let params6 = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result6 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.turnoverStatistics(Dic:params6)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBTurnoverChartModel.self)
            .retry(1)
        _ = result6.subscribe(onNext:{array in
            self.chart3Models = self.resetChart3Data(array: array)
        })
        
        //翻桌券分析
        let params7 = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result7 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.turnoverDiscountAnalyze(Dic:params7)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        _ = result7.subscribe(onNext:{response in
            if let resp = response as? [String:Any] {
                self.allDiscountCount5.value = String(describing:resp["allDiscountCount"] ?? 0)
                self.useDiscountCount5.value = String(describing:resp["useDiscountCount"] ?? 0)
            }
        })

        //推广分析
        let params8 = ["shopId":shopid,"startTime":yesterdayStartTimestamp.value,"endTime":yesterdayEndTimestamp.value]
        let result8 = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.generalizeAnalyze(Dic:params8)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .retry(1)
        _ = result8.subscribe(onNext:{response in
            if let resp = response as? [String:Any] {
                self.oldUser5.value = String(describing:resp["oldUser"] ?? 0)
                self.newUser5.value = String(describing:resp["newUser"] ?? 0)
            }
        })
        
//        //并行序列 在后台线程中执行
//        let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)        Observable<Any>.combineLatest(observable1,observable2,observable3,observable4,observable5,observable6,observable7,observable8)
//            .observeOn(concurrentScheduler)
//            .subscribeOn(MainScheduler())
//            .subscribe(onNext:{ resp in
//
//            })
        return Driver.of(())
    }

    //用户店铺列表
    func userAllShops() -> Observable<[WDBMineShopModel]> {
        let userid = WDBGlobalDataUserDefaults.getID()
        let params = ["userId":userid]
        return defaultProvider.rx.request(MultiTarget(WDBApiHomePage.userAllShops(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBMineShopModel.self, key: "result")
            .retry(1)
    }
    
    //经营统计数据处理
    func resetChart1Data(array:[WDBOrderChartModel]) -> [WDBOrderChartModel] {
        
        var dataArray = [WDBOrderChartModel]()
        
        for i in 0...self.currentMonthDays.value {
            //遍历30次
            var dic = ["time":Int(0),"totalSum":Float(0.0),"day":Int(i)] as [String : Any]
            
            for model in array {
                let time = Double(model.time!)
                //根据时间戳 转化为天
                let day = DateFormatTool.getDayFromTimestamp(timestamp: time)
                if day == i {
                    //如果有此日的数据
                    dic = ["time":model.time!,"totalSum":model.totalSum!,"day":day] as [String : Any]
                }
            }
            let model = Mapper <WDBOrderChartModel>().map(JSON: dic)
            dataArray.append(model!)
        }
        
        return dataArray
    }
    
    //奖券统计数据处理
    func resetChart2Data(array:[WDBDiscountChartModel]) -> [WDBDiscountChartModel] {
        
        var dataArray = [WDBDiscountChartModel]()
        
        for i in 0..<self.recent7Hours.value.count {
            var dic = ["time":Int(0),"useDiscountCount":Int(0),"allDiscountCount":Int(0)] as [String : Any]
            
            for model in array {
                let time_h = DateFormatTool.getHourFromTimestamp(timestamp: Double(model.time!))
                if time_h == self.recent7Hours.value[i] {
                    //返回数据有此小时数据
                    dic = ["time":model.time!,"useDiscountCount":model.useDiscountCount!,"allDiscountCount":model.allDiscountCount!] as [String : Any]
                }
            }
            
            let newmodel = Mapper <WDBDiscountChartModel>().map(JSON: dic)
            dataArray.append(newmodel!)
        }
        
        return dataArray
    }
    
    //翻桌率统计数据处理
    func resetChart3Data (array:[WDBTurnoverChartModel]) -> [Double]{
        
        //保存不同段位的订单数
        var dataArray = [Double]()
        for i in 0...6 {
            //默认此段位订单数0
            var orders = 0
            if i == 6 {
                for model in array {
                    let time = model.time ?? 0
                    let ratio = time/60/30
                    if ratio >= 6 {
                        orders += 1
                    }
                }
            }else {
                for model in array {
                    let time = model.time ?? 0
                    let ratio = time/60/30
                    if i == ratio {
                        orders += 1
                    }
                }
            }
            dataArray.append(Double(orders))
        }
//        print(dataArray)
        return dataArray
    }
    
}





////单元格类型
//enum HomeSectionItem {
//    case HomeSection1Cell(dataDic:[String:Any],charts:[WDBOrderChartModel])
//    case HomeSection2Cell(recent7:[Int],charts:[WDBDiscountChartModel])
//    case HomeSection3Cell(topDic:[String:Any],bottomDic:[String:Any])
//    case HomeSection4Cell(times:[Float])
//    case HomeSection5Cell(topDic:[String:Any],bottomDic:[String:Any])
//}
//
////自定义Section
//struct MyHomeSectionSection {
//    var items: [HomeSectionItem]
//}
//
//extension MyHomeSectionSection : SectionModelType {
//
//    typealias Item = HomeSectionItem
//
//    init(original: MyHomeSectionSection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}

