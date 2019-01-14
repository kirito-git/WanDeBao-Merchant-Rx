//
//  WDBRegisterStoreViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBRegisterStoreViewModel: NSObject {

     let storeName = Variable("")
     let storeAddress = Variable("")
     let storePhone = Variable("")
    
     var validedStoreName: Observable<Bool>
     var validedStoreAddress: Observable<Bool>
     var validedStorePhone: Observable<Bool>
    
     override init() {
        
        validedStoreName = storeName.asObservable().map({ (storeName) in
             return storeName.count > 4
        })
        
        validedStoreAddress = storeAddress.asObservable().map({ (storeAddress) in
            return storeAddress.count > 4
        })
        
        validedStorePhone = storePhone.asObservable().map({ (storePhone) in
             return storePhone.count == 11
        })
    }
    
    
    func registerStore(paramDic: [String:Any]) -> Observable<Response> {
         return defaultProvider.rx.request(MultiTarget(WDBApiRegister.registerStore(Dict: paramDic))).filter(statusCode: 200).asObservable().retry(2)
    }
    
    func getPickerData() -> Observable<[WDBShopBusinessCategoryModel]> {
         let paramDic = ["type": 1] as [String:Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiRegister.getBusinessCategory(Dict:paramDic)))
        .filterSuccessfulStatusCodes()
        .asObservable()
        .mapArray(type: WDBShopBusinessCategoryModel.self).retry(2)
    }
    
    
}
