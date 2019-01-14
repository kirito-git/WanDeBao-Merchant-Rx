//
//  WDBScanResultViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/7.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBScanResultViewModel: NSObject {
    
    //查询优惠券信息
    func getDiscountInfo(dic:[String:Any]) ->  Observable<WDBDiscount2Model> {
        return defaultProvider.rx.request(MultiTarget(WDBApiHomePage.getDiscountInfo(Dic: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBDiscount2Model.self).retry(2)
    }
    
    //查询用户信息
    func getDiscountOwnerUserInfo(dic:[String:Any]) ->  Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiHomePage.getDiscountOwnerUserInfo(Dic: dic)))
            .mapJSON()
            .asObservable().retry(2)
    }
    
    //销券
    func checkDiscount(dic:[String:Any]) ->  Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiHomePage.checkDiscount(Dic: dic)))
            .mapJSON()
            .asObservable().retry(2)
    }
    
}
