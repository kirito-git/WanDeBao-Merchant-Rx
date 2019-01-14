//
//  WDBMessageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class WDBMessageViewModel {
    
    //消息数据
    let dataArray = BehaviorRelay<[WDBMessageModel]>(value:[])
    
    var endRefresh:Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        let headerDatas = headerRefresh
            .startWith(())
            .flatMapLatest{WDBMessageViewModel.messageList()}
        
        self.endRefresh = Driver.of(false)
            .flatMap{_ in headerRefresh.map{true}}
        
        //保存消息数据
        _ = headerDatas.drive(onNext:{ models in
            self.dataArray.accept(models)
        })
    }
    
    //查询消息列表
    class func messageList() ->  Driver<[WDBMessageModel]> {
        let userid = WDBGlobalDataUserDefaults.getID()
        let params = ["userId":userid,"page":1,"pageSize":"40","type":"0"] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiMessage.messageList(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBMessageModel.self, key: "result")
            .retry(1)
            .asDriver(onErrorJustReturn: [])
    }
}
