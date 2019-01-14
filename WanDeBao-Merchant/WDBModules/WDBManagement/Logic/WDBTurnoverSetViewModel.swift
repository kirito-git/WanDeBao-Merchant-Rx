//
//  WDBTurnoverSetViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBTurnoverSetViewModel: NSObject {

    var pattern:String = "2"
    
    private let provider = MoyaProvider<WDBApiManage>(plugins:[RequestLoadingPlugin(),NetworkLogger()])
    private let disposeBag = DisposeBag()
    
    //设置翻桌率模式
    func setTurnoverType(shopId:String,pattern:String) -> Observable<Any> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.setTurnoverType(shopId:shopId,pattern:pattern)))
            .mapJSON()
            .asObservable().retry(2)
    }
    
    func switchValueChanged (isOn:Bool) {
        pattern = isOn ? "0" : "2"
    }
    
    func turnoverSwitchClick (isSelect:Bool) {
        pattern = isSelect ? "1" : "0"
    }
}
