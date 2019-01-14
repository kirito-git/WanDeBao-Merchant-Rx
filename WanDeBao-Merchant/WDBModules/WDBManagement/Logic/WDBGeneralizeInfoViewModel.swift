//
//  WDBGeneralizeInfoViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

//推广率详情
import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBGeneralizeInfoViewModel: NSObject {

    private let provider = MoyaProvider<WDBApiManage>(plugins:[RequestLoadingPlugin(),NetworkLogger()])
    private let disposeBag = DisposeBag()
    
    //推广详情
    func generalizeInfo(dic:[String:Any]) -> Observable<WDBGeneralizeModel> {
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.generalizeInfo(Dic: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBGeneralizeModel.self).retry(2)
    }
}
