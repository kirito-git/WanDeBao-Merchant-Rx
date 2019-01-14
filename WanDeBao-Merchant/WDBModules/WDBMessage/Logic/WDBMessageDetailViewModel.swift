//
//  WDBMessageDetailViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class WDBMessageDetailViewModel {
    
    let title = Variable("")
    let content = Variable("")
    let creatTime = Variable("")
    
    init() {
        
    }
    //查询消息内容
    func messageDetail(dic:[String:Any]) ->  Observable<Any> {
        let result = defaultProvider.rx.request(MultiTarget(WDBApiMessage.messageDetail(Dic: dic)))
            .mapJSON()
            .asObservable()
            .retry(1)
        return result
    }
}
