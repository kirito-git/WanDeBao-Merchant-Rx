//
//  WDBManagementViewModel.swift
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

class WDBManagementViewModel {
    
    //配置collection数据
    let dataArray = BehaviorRelay<[ManageIndexSection]>(value:[ManageIndexSection(items:[])])
    
    var totalIncome = Variable("0")
    var monthIncome = Variable("0")
    var monthOrders = Variable("0")
    
    init() {
        //初始化cell数据
        let titles:Array = ["店铺管理","精品管理","新品管理","游戏管理","奖券管理","翻桌率/推广管理"]
        let images:Array = ["manage_icon_shop","manage_icon_qualitygoods","manage_icon_newgoods","manage_icon_game","manage_icon_tickets","manage_icon_turnrate"]
        var array = [ManageCellModel]()
        for i in 0..<titles.count {
            let model = ManageCellModel()
            model.title = titles[i]
            model.icon = images[i]
            array.append(model)
        }
        self.dataArray.accept([ManageIndexSection(items:array)])
    }
    
    func ordersCountAndSum() -> Observable<Any> {
        
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let tuple:(Double,Double,Int,Int) = DateFormatTool.currentDaysOfMonthCount()
        let startTimestamp = String(format:"%.0f", tuple.0 * 1000)
        let endTimestamp = String(format:"%.0f", tuple.1 * 1000)
        let params = ["shopId":shopid,"startTime":startTimestamp,"endTime":endTimestamp]
        
        let result = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.ordersCountAndSum(Dic:params)))
                    .filterSuccessfulStatusCodes()
                    .mapJSON()
                    .asObservable()
        result.subscribe(onNext:{ response in
            let dic = response as! [String:Any]
            if (dic["totalSum"] is NSNull) == false {
                self.monthIncome.value = String(describing:dic["totalSum"] ?? "0")
            }
            if (dic["orderNumber"] is NSNull) == false {
                self.monthOrders.value = String(describing:dic["orderNumber"] ?? "0")
            }
        })
        return result
    }
    
    
    func ordersCountAndSum2() -> Observable<Any> {
        //最初的时间戳 此处应为创建店铺的时间戳 2018.1.1
        let tuple:(Double,Double,Int,Int) = DateFormatTool.currentDaysOfMonthCount()
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let shop_createTimestamp = "1514736000000"
        let endTimestamp = String(format:"%.0f", tuple.1 * 1000)
        let params = ["shopId":shopid,"startTime":shop_createTimestamp,"endTime":endTimestamp]
        
        let result = defaultProvider.rx.request(MultiTarget(WDBApiHomePage.ordersCountAndSum(Dic:params)))
                    .filterSuccessfulStatusCodes()
                    .mapJSON()
                    .asObservable()
        result.subscribe(onNext:{ response in
            let dic = response as! [String:Any]
            if (dic["totalSum"] is NSNull) == false {
                self.totalIncome.value = String(describing:dic["totalSum"]!)
            }
        })
        return result
    }
    
    func pushToVCUrl(index:Int) -> String {
        switch index {
        case 0:
            return NavigatorURLShopManage
        case 1:
            return NavigatorURLQualityGoodsManagement
        case 2:
            return NavigatorURLQualityGoodsManagement
        case 3:
            return NavigatorURLGameManagement
        case 4:
            return NavigatorURLDiscountManage
        case 5:do {
                let turnoverType = WDBGlobalDataUserDefaults.getShopTurnoverType()
                if turnoverType == "0" {
                    //翻桌率
                    return NavigatorURLTurnoverManagement
                }else if turnoverType == "1" {
                    //推广模式
                    return NavigatorURLExpand
                }else if turnoverType == "2" {
                    //未启用
                    return NavigatorURLTurnoverSet
                }
            }
        default:
            return ""
        }
        return ""
    }
}


