//
//  WDBNearbyShopViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBNearbyShopViewModel: NSObject {
    
    var shopsArray:[WDBShopModel] = []
    var markArray:[Bool] = []
    
    var choseArray:[WDBShopModel] = []
    var shopsStr:String = ""
    
    private let provider = MoyaProvider<WDBApiManage>(plugins:[RequestLoadingPlugin(),NetworkLogger()])
    private let disposeBag = DisposeBag()
    
    func nearbyShopList(dic:[String:Any]) -> Observable<[WDBShopModel]> {
        
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.nearbyShopList(Dic: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapArray(type: WDBShopModel.self, key: "result").retry(2)
    }
    
    //初始化mark数组
    func initMarkArray(originArray:[WDBShopModel]) {
        self.shopsArray = originArray
        for _ in originArray {
            markArray.append(false)
        }
//        print("-----\(markArray)----\(originArray)")
    }
    
    //处理选中的数据 返回元组类型 let tuple = ([],String)
    func getChoseData() -> ([WDBShopModel],String) {
        
        let shops:[WDBShopModel]! = self.shopsArray
        if  shops.count == 0{
            return ([WDBShopModel](),"")
        }
        //初始化数组 接受选中的店铺
        var choseShops = [WDBShopModel]()
        //初始化字符串  拼接选中的shopid
        var shopIds = [String]()
        //用户是否选中
        var hasSelect = false
        
        for i in 0...(shops.count-1) {
            let isSelect = markArray[i]
            if isSelect {
                //选中
                choseShops.append(shops[i])
                
                //拼接shopid
                let model:WDBShopModel = shops[i]
                let shopid =  "\(String(describing: model.shopId ?? 0))"
                shopIds.append(shopid)
                
                hasSelect = true
            }
        }
        if hasSelect {
            //将数组转化为,拼接的字符串
            let shopidsString:String = shopIds.joined(separator: ",")
            print(shopidsString)
            let tuple:([WDBShopModel],String) = (choseShops,shopidsString)
            print(tuple)
            return tuple
            
            
        }
        return ([WDBShopModel](),"")
    }
    
}
