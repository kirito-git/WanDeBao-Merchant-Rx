//
//  WDBDiscountManageAddViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class WDBDiscountManageAddViewModel {

    let discountType = Variable("")
    let limitTime = Variable("")
    let num = Variable("")
    //满减
    let downlimitSum = Variable("")
    let downSum = Variable("")
    //免单
    let mdPrice = Variable("")
    //赠品
    let swName = Variable("")
    //折扣
    let factorValue = Variable("")
    //输入有效性
    let inputVaild = Variable(false)
    
    init() {
    }
    
    //添加优惠券
    func discountAdd(params:[String:Any]) -> Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.discountAdd(Dic: params)))
            .mapJSON()
            .asObservable()
            .retry(2)
    }
    
    //获取优惠券请求参数
    func getRequestParams() -> Observable<[String:Any]> {
        
        let current_Type = self.discountType.value
        var factorvalue = ""
        var discountName = ""
        let times = self.limitTime.value
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        var factorType = ""
        let number = self.num.value
        var level = ""
        let isGroup = "0"
        let isDisct = "0"
        let discountOrder = "1"
        var params:[String:String]!
        
        
        //有效性判断
        let numVaild = self.num.asObservable()
            .map{$0.count>0}
            .share(replay: 1)
        let limitTimeVaild = self.limitTime.asObservable()
            .map{$0.count>0}
            .share(replay: 1)
        
        if current_Type == "8" {
            //免单
            factorvalue = self.mdPrice.value
            discountName = "\(self.mdPrice.value)免单券"
            factorType = "1"
            level = "1"
            params = ["type":current_Type,"factorvalue":factorvalue,"discountName":discountName,"times":times,"shopId":shopid,"factorType":factorType,"number":number,"level":level,"isGroup":isGroup,"isDisct":isDisct,"discountOrder":discountOrder]
            
            let contentVaild = self.mdPrice.asObservable()
                .map{$0.count>0}
                .share(replay: 1)
            
            _ = Observable.combineLatest(numVaild,limitTimeVaild,contentVaild){$0 && $1 && $2}
                .subscribe(onNext:{ vaild in
                    self.inputVaild.value = vaild
                })
            
        }else if current_Type == "5" {
            //满减
            let downLimitSum = self.downlimitSum.value
            factorvalue = self.downSum.value
            discountName = "满\(downLimitSum)减\(factorvalue)"
            factorType = "1"
            level = "3"
            
            params = ["type":current_Type,"downLimitSum":downLimitSum,"factorvalue":factorvalue,"discountName":discountName,"times":times,"shopId":shopid,"factorType":factorType,"number":number,"level":level,"isGroup":isGroup,"isDisct":isDisct,"discountOrder":discountOrder]
            
            
            let downlimitSumVaild = self.downlimitSum.asObservable()
                .map{$0.count>0}
                .share(replay: 1)
            let downSumVaild = self.downSum.asObservable()
                .map{$0.count>0}
                .share(replay: 1)
            
            _ = Observable.combineLatest(numVaild,limitTimeVaild,downlimitSumVaild,downSumVaild){$0 && $1 && $2 && $3}
                .subscribe(onNext:{ vaild in
                    self.inputVaild.value = vaild
                })
            
        }else if current_Type == "4" {
            //实物
            factorvalue = "0"
            discountName = self.swName.value
            factorType = "4"
            level = "1"
            
            params = ["type":current_Type,"factorvalue":factorvalue,"discountName":discountName,"times":times,"shopId":shopid,"factorType":factorType,"number":number,"level":level,"isGroup":isGroup,"isDisct":isDisct,"discountOrder":discountOrder]
            
            let swNameVaild = self.swName.asObservable()
                .map{$0.count>0}
                .share(replay: 1)
            
            _ = Observable.combineLatest(numVaild,limitTimeVaild,swNameVaild){$0 && $1 && $2}
                .subscribe(onNext:{ vaild in
                    self.inputVaild.value = vaild
                })
            
        }else if current_Type == "6" {
            //折扣
            let factorVal = Float(self.factorValue.value)! / 10.0
            factorvalue = String(format: "%g",factorVal)
            discountName = "\(self.factorValue.value)折券"
            factorType = "2"
            level = "2"
            
            params = ["type":current_Type,"factorvalue":factorvalue,"discountName":discountName,"times":times,"shopId":shopid,"factorType":factorType,"number":number,"level":level,"isGroup":isGroup,"isDisct":isDisct,"discountOrder":discountOrder]
            
            let factorValueVaild = self.factorValue.asObservable()
                .map{$0.count>0}
                .share(replay: 1)
            
            _ = Observable.combineLatest(numVaild,limitTimeVaild,factorValueVaild){$0 && $1 && $2}
                .subscribe(onNext:{ vaild in
                    self.inputVaild.value = vaild
                })
        }
        print("请求参数",params)
        return Observable<[String:Any]>.just(params)
    }
    
}
