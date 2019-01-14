//
//  WDBMineViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

class WDBMineViewModel: NSObject {
    
    private let titleArray = ["账户资金", "门店资质", "我的银行卡", "使用手册", "设置", "意见反馈"]
    //private let titleArray = ["账户资金", "门店资质", "我的银行卡", "我的合同", "使用手册", "设置", "意见反馈"]
    private let imageArray = ["mine_moneymanagement", "mine_storequalification", "mine_bankcard", "mine_usemanual", "mine_setting", "mine_feedback"]
//    private let imageArray = ["mine_moneymanagement", "mine_storequalification", "mine_bankcard", "mine_contract", "mine_usemanual", "mine_setting", "mine_feedback"]
    lazy var modelArray = [WDBMineModel]()
    let content = Variable("")
    var vipProductList = [WDBProductModel]()
    var markArray = [Bool]()
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        for i in 0..<titleArray.count {
            let model = WDBMineModel()
            model.title = titleArray[i]
            model.image = imageArray[i]
            modelArray.append(model)
        }
    }
    
    //查询账户
    func queryAccount(dic:[String:Any]) ->  Observable<WDBAccountModel> {
        
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.queryAccount(Dict: dic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBAccountModel.self).retry(2)
    }
    
    //更换头像
    func changeAvatar(avatar: String) -> Observable<[String:Any]> {
        
        let ID = WDBGlobalDataUserDefaults.getID()
        let paramDic = ["id":ID, "headImage":avatar] as [String : Any]
      return defaultProvider.rx.request(MultiTarget(WDBApiMine.changeUserAvatar(Dict: paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapDictionary().retry(2)
    }
    
    //获取商铺主人信息
    func getStoreInfo() -> Observable<WDBShopOwnerInfo> {
        //ownerId
        let ownerId = WDBGlobalDataUserDefaults.getOwnerId()
        
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.getStoreOwnerInfo(ownerId: ownerId))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBShopOwnerInfo.self).retry(2)
    }
    
    //获取用户信息
    func getUserInfo() -> Observable<WDBUserInfo> {
       return defaultProvider.rx.request(MultiTarget(WDBApiMine.getUserInfo(userId: ""))).filterSuccessfulStatusCodes().asObservable().mapObject(type: WDBUserInfo.self).retry(2)
    }
    
    //绑定微信号
    func bindWeChat() -> Observable<WDBUserInfo> {
        let phone = WDBGlobalDataUserDefaults.getUserPhone()
        let ID = WDBGlobalDataUserDefaults.getID()
        let providerUserId = WDBGlobalDataUserDefaults.getProviderUserId()
        let paramDic = ["phone":phone, "appcode":"app_wdb", "id":ID, "providerId":"weixin_wandebao", "providerUserid":providerUserId] as [String:Any];
        return defaultProvider.rx.request(MultiTarget(WDBApiWeChat.bindWeChat(dict: paramDic)))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .mapObject(type: WDBUserInfo.self).retry(2)
    }
    
    //银行卡列表
    func queryBankCardList() -> Observable<[WDBMyBankCardInfoModel]> {
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let ID = WDBGlobalDataUserDefaults.getID()
        let params = ["userId":ID,"shopId":shopId] as [String:Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.getUserBankList(Dict: params)))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .asObservable()
        .mapArray(type: WDBMyBankCardInfoModel.self, key: "result")
    }
    
    //添加银行卡 验证码
    func getHash(phoneNum:String) -> Observable<WDBHashCode> {
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.getHash(phone: phoneNum, type: 0)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().mapObject(type: WDBHashCode.self)
    }
    
    //添加银行卡 获取验证码
    func getCode(phoneNum:String,hashCode: String) -> Observable<WDBLoginSmsInfo> {
        
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.getCode(phone: phoneNum, type: 0, hashCode: hashCode)))
            .filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBLoginSmsInfo.self)
    }
    
    //添加银行卡
    func userBindBankCard(params:[String:Any]) -> Observable<WDBMyBankCardInfoModel> {
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.bindUserBankCard(Dict: params)))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .asObservable()
        .mapObject(type: WDBMyBankCardInfoModel.self)
    }
    
    // MARK -续费
    
    //查询服务续费列表
    func queryServiceRenewalList(pageNo:Int) -> Observable<[WDBProductModel]>{
        let shopId = "0"
        let paramDic = ["shopId":shopId, "type":8, "status":1, "isNew":1, "page":pageNo, "size":10] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.queryStoreRenewalProductList(Dict:paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapArray(type: WDBProductModel.self, key: "result").retry(2)
    }
    
    //开启服务使用
    func openServiceTry() -> Observable<WDBProductModel> {
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let productId = WDBAccountManager.sharedManger.productId ?? ""
        let paramDic = ["shopId": shopId, "productId": productId]
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.openStoreTryService(Dict: paramDic))).filterSuccessfulStatusCodes().asObservable().mapObject(type: WDBProductModel.self
        ).retry(2)
    }
    
    //查询是否开启7天试用
    func queryIsHaveFreeTryService() -> Observable<[WDBProductModel]>{
        let shopId = WDBGlobalDataUserDefaults.getShopID()
       return defaultProvider.rx.request(MultiTarget(WDBApiMine.queryIsHaveFreeTryService(shopId: shopId))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapArray(type: WDBProductModel.self).retry(2)
    }
    
    // MARK - 支付

    //开启下单接口
    func productAddOrder(orderUnionType: Int, selectProductModel:WDBProductModel) -> Observable<WDBOrderModel> {
        
        var params = [String:Any]()
        let productjson = getProductJson(model: selectProductModel)
        let productjsonStr = JSON(productjson)
        let products = productjsonStr.rawString(.utf8, options: .init(rawValue: 0))!
        //let products = productjsonStr.rawString(.utf8, options: .init(rawValue: 0))!
        //print(products)
        params["choosedShopProductJson"] = products
        params["takeType"] = "0"
        params["orderUnionType"] = orderUnionType
        params["phone"] = ""
        params["shopRealName"] = ""
        params["shoppingWay"] = "5"
        params["isSave"] = "1"
        params["appcode"] = "1"
        params["appid"] = "1"
        params["fromShopId"] = WDBGlobalDataUserDefaults.getShopID()
        
        return defaultProvider.rx.request(MultiTarget(WDBApiManage.shopGameAddOrder(Dic: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBOrderModel.self).retry(2)
    }
    
    //连连支付充值接口
    func llpayRecharge(params:[String:Any]) -> Observable<WDBLLPayRechargeModel> {
            return defaultProvider.rx.request(MultiTarget(WDBApiMine.llpayRecharge(Dict: params)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: WDBLLPayRechargeModel.self)
    }
    
    //拼接所有选中的商品 jsonStr
    func getProductJson(model: WDBProductModel) -> String {
           var products = [[String:Any]]()
//        for i in 0..<vipProductList.count {
//            let isSelected = markArray[i]
//            if isSelected {
//                let model = vipProductList[i]
                var dicData = [String:Any]()
                dicData["ShopId"] = String(describing: model.shopId ?? 0)
                dicData["ShopProductId"] = String(describing: model.productId ?? 0)
                dicData["ShopProductName"] = model.name
                dicData["num"] = "1"
                dicData["cateId"] = String(describing: model.cateId ?? 0)
                dicData["productUrl"] = model.productIcoUrl
                dicData["showPrice"] = String(describing: model.shopPrice ?? 0.0)
                dicData["sellPrice"] = String(describing: model.price ?? 0.0)
                dicData["costPrice"] = "0"
                dicData["points"] = String(describing: model.point ?? 0)
                products.append(dicData)
//            }
//        }
        //将数组转化为字符串
         var strJson = ""
        if #available(iOS 11.0, *) {
            let data = try? JSONSerialization.data(withJSONObject: products, options: JSONSerialization.WritingOptions.sortedKeys)
            strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
        } else {
            // Fallback on earlier versions
            let data = try? JSONSerialization.data(withJSONObject: products, options: JSONSerialization.WritingOptions.prettyPrinted)
            strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
        print(strJson)
        
        let resultStr1 = strJson.replacingOccurrences(of: "\n", with: "")
        let resultStr2 = resultStr1.replacingOccurrences(of: "  ", with: "")
        let resultStr3 = resultStr2.replacingOccurrences(of: "    ", with: "")
        let ch:Character = Character(UnicodeScalar(92)!)
        let resultStr4 = resultStr3.replacingOccurrences(of: String(ch), with: "")
        
        //        return products
        return resultStr4
    }
    
    // 统计商铺线上金额和推广金额
    func getOnlineMoneyAndPromotionMoney() -> Observable<Any> {
        
        let startTime = "1526033197000"
        let timeInterval = NSDate().timeIntervalSince1970
        let timeStamp = Int(timeInterval) * 1000
        let endTime = timeStamp //  当前时间
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let paramDic = ["startTime":startTime, "endTime":endTime, "shopId":shopId] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.getOnlineMoneyAndPromotionMoney(Dict: paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().retry(2)

    }
    
    //意见反馈
    func suggestionFeedback() -> Observable<Any> {
        let phone = WDBGlobalDataUserDefaults.getUserPhone()
        
//        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxODY2NzE2ODkxM2FwcF93ZGIiLCJzY29wZSI6WyJhbGwiXSwiY29tcGFueSI6Inl1bmJhbyIsImV4cCI6MTUzMjA3NDQyMywiYXV0aG9yaXRpZXMiOlsi55So5oi3Iiwi5rWL6K-V5ZGYIiwi566h55CG5ZGYIiwi6L-Q6JCl5ZGYIl0sImp0aSI6IjhiMjUwOTBiLTZkY2QtNDU2Ny05ZTZiLWM4YTM5NGE0NjY2ZiIsImNsaWVudF9pZCI6Inl1bmJhbyJ9.oFA7cecNO9VZKu_8v02hD1FOZP5WBkiYBl9zcO4"
//
//        WDBGlobalDataUserDefaults.saveToken(token: token)
        
        let paramDic =  ["content":content.value,"type":1,"title":"商家反馈", "phone":phone] as [String:Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiMine.suggestionFeedback(Dict: paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().retry(2)
    }
    
    
}
