//
//  WDBGeneralizeAddViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBGeneralizeAddViewModel: NSObject {

   // private let provider = MoyaProvider<WDBApiManage>(plugins:[RequestLoadingPlugin(),NetworkLogger()])
    private let disposeBag = DisposeBag()
    
    //创建推广券
    func createGeneralizeDiscount(dic:[String:Any]) -> Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.createGeneralizeDiscount(Dic: dic)))
            .mapJSON()
            .asObservable().retry(2)
    }
}
