//
//  WDBSystemViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class WDBSystemViewModel: NSObject {
    
    //获取阿里云OSS信息
    public func getOSSInfo() -> Observable<YBOSSInfo> {
        
      return defaultProvider.rx.request(MultiTarget(WDBApiSystem.getOSSInfo))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().mapObject(type: YBOSSInfo.self).retry(2)
    }
}
