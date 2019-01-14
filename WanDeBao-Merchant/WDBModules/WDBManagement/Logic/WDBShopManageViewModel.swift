//
//  WDBShopManageViewModel.swift
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

class WDBShopManageViewModel {
    
    let shopName = Variable("")
    let phone = Variable("")
    let address = Variable("")
    let des = Variable("")
    let shopLogoUrl = Variable("")
    let shopPicUrl = Variable("")
    let cateIds = Variable("")
    let shopId = Variable("")
    
    //提交按钮可用序列
    let confirmVaild:Observable<Bool>
    
    init() {
        self.shopId.value = WDBGlobalDataUserDefaults.getShopID()
//        self.shopLogo.value = "button_add"
//        self.shopPic.value = "button_add"
        
        //商铺名是否有效
        let nameVaild = shopName.asObservable()
            .map({ $0.count > 0 })
            .share(replay: 1)
        
        //电话号码是否有效
        let phoneVaild = phone.asObservable()
            .map { $0.count == 11 }
            .share(replay: 1)
        
        //店铺介绍
        let introVaild = des.asObservable()
            .map{ $0.count > 0 }
            .share(replay: 1)
        
        //店铺地址
        let addressVaild = address.asObservable()
            .map{ $0.count > 0 }
            .share(replay: 1)
        
        //店铺logo
        let logoVaild = shopLogoUrl.asObservable()
            .map{ $0.count > 0 }
            .share(replay: 1)
        
        //分类
        let cateVaild = cateIds.asObservable()
            .map{ $0.count > 0 }
            .share(replay: 1)
        
        
        //按钮是否有效
        self.confirmVaild = Observable
            .combineLatest(nameVaild,phoneVaild,introVaild,addressVaild,logoVaild,cateVaild){
                $0 && $1 && $2 && $3 && $4 && $5
            }
        
    }
    
    //修改店铺请求
    func changeShopInfo() -> Observable<Any> {
        let params = ["shopId":self.shopId.value,"shopName":self.shopName.value,"shopLogo":self.shopLogoUrl.value,"shopAddress":self.address.value,"shopPhone":self.phone.value,"shopDesc":self.des.value,"ownerType":"0","cateIds":self.cateIds.value]
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.changeShopInfo(Dic:params)))
            .mapJSON()
            .asObservable()
    }
    
    //获取店铺详情请求
    func getShopInfo() -> Observable<WDBMineShopModel>{
        let shopinfoParams = ["shopId":self.shopId.value]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.getShopInfo(Dic: shopinfoParams)))
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBMineShopModel.self)
        result.subscribe(onNext:{ model in
                self.shopName.value = model.shopName ?? ""
                self.phone.value = model.shopPhone ?? ""
                self.address.value = model.shopAddress ?? ""
                self.des.value = model.shopDesc ?? ""
                self.shopLogoUrl.value = model.shopLogo ?? ""
                self.shopId.value = String(describing: model.shopId ?? 0)
            })
            .disposed(by: disposeBag)
        return result
    }
    
}
