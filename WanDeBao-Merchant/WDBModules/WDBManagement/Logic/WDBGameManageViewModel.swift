//
//  WDBGameManageViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya
import SwiftyJSON

class WDBGameManageViewModel {
    
    //初始化section样式的tableview数据
    let gameList = BehaviorRelay<[GameManageSection]>(value:[GameManageSection(header:"",items:[])])
    //停止刷新
    let endHeaderRefresh: Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        
        //下拉刷新请求网络
        let headerRefreshData = headerRefresh
        .startWith(())
        .flatMapLatest{WDBGameManageViewModel.shopGameList()}
        
        //停止刷新事件
        self.endHeaderRefresh = Observable<Bool>.of(false)
            .flatMap{_ in return headerRefreshData.map{_ in true} }
            .asDriver(onErrorDriveWith: Driver.empty())
        
        headerRefreshData.drive(onNext:{ items in
            self.gameList.accept([GameManageSection(header:"",items: items)])
        }).disposed(by: disposeBag)
    }
    
    //查询店铺游戏
    class func shopGameList() -> Driver<[WDBGameModel]> {
        let dic = ["a":""]
        let result = defaultProvider.rx.request(MultiTarget(WDBApiManage.shopGameList(Dic: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBGameModel.self, key: "result")
            .asDriver(onErrorDriveWith: Driver.empty())
        return result
    }
}



//创建RxDatasourse的自定义section
struct GameManageSection {
    var header: String
    var items: [Item]
}
//GameManageSection 是一个遵循 SectionModelType 协议的结构
extension GameManageSection : SectionModelType {
    
    typealias Item = WDBGameModel
    
    var identity: String {
        return header
    }
    
    init(original: GameManageSection, items: [Item]) {
        self = original
        self.items = items
    }
}
