//
//  WDBProductAddViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBProductAddViewModel {

    var shopName = Variable("")
    var shopIntro = Variable("")
    var shopPic = Variable("button_add")
    var shopPicUrl = Variable("")
    
    let confirmObservable:Observable<Bool>
    
    init() {
        let nameVaild = self.shopName.asObservable()
        .map{$0.count > 0}
        .share(replay: 1)
        
        let introVaild = self.shopIntro.asObservable()
        .map{$0.count>0}
        .share(replay: 1)
        
        let picUrlVaild = self.shopPicUrl.asObservable()
        .map{$0.count>0}
        .share(replay: 1)
        
        //合并信号
        self.confirmObservable = Observable
            .combineLatest(nameVaild,introVaild,picUrlVaild)
            {$0 && $1 && $2}
            .distinctUntilChanged()
    }
    
    //添加商品
    func addProduct(isQuality:Bool) -> Observable<Any> {
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let name = self.shopName.value
        let intro = self.shopIntro.value
        let productUrl = self.shopPicUrl.value
        let isNew = isQuality ? "0" : "1"
        let params:[String:String] = ["shopId":shopid,"name":name,"productContent":intro,"productIcoUrl":productUrl,"isnew":isNew,"type":"1","times":"0","number":"999"]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.addProduct(Dic: params)))
            .mapJSON()
            .asObservable().retry(1)
        return result
    }
    
    
}
