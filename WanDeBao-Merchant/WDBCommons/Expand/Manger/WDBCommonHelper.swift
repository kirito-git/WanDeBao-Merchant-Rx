//
//  WDBCommonHelper.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper

class WDBCommonHelper: NSObject {
    
     private lazy var systemViewModel: WDBSystemViewModel = WDBSystemViewModel()
     private let disposeBag = DisposeBag()

    //用户信息
    
    static let shared: WDBCommonHelper = {
        let manager = WDBCommonHelper()
        return manager
    }()
    
    private override init() {
        
    }
    
    
    //登录成功后保存数据
    func saveData(loginInfo: WDBLoginInfo)  {
        //保存Token和RefreshToken
        if let token = loginInfo.token?.access_token, let refreshToken = loginInfo.token?.refresh_token{
            WDBGlobalDataUserDefaults.saveToken(token: token)
            WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: refreshToken)
           
        }
        
        if let phone = loginInfo.userInfo?.phone {
            
             WDBGlobalDataUserDefaults.saveUserPhone(phone: phone)
        }
        
        if let bindStatus = loginInfo.userInfo?.bindStatus {
            WDBGlobalDataUserDefaults.saveBindStatus(bindStatus: bindStatus)

        }
        
        if let providerUserId = loginInfo.userInfo?.provideruserid {
            WDBGlobalDataUserDefaults.saveProviderUserId(providerUserId: providerUserId)
        }
        
        if let ID = loginInfo.userInfo?.ID, let userid = loginInfo.userInfo?.userid, let userId = loginInfo.userInfo?.userId {
            WDBGlobalDataUserDefaults.saveID(ID: ID)
            WDBGlobalDataUserDefaults.saveUserid(userid: userid)
            WDBGlobalDataUserDefaults.saveSpecialUserId(userId: userId)
        }
        if let avatar = loginInfo.userInfo?.imageUrl {
            WDBGlobalDataUserDefaults.saveAvatar(imageUrl: avatar)
        }
    }
    
    //MARK-处理认证审核状态
    func dealWithCheckStatus(phone:String, userId:Int, viewController:UIViewController) {
        
            //let phone = "18667168913"; let userId = "18667168913app_wdb"
          _ = self.getCheckStatusInfo(phone: phone, userId: userId).subscribe(onNext: { (checkInfo) in
                let checkStatus = checkInfo.status ?? -1
                print(checkInfo.status ?? -1)
                //checkStatus = -1
                if (checkStatus == -1) {
                    //未提交审核
                   navigator.push(NavigatorURLRegisterStore)
                }else if (checkStatus == 0) {
                    //审核中 审核结果
                   navigator.push(NavigatorURLSubmitInfoResult)
                }else if (checkStatus == 1) {
                    //审核通过
                    let tabBarController = navigator.viewController(for: NavigatorURLTabBar)
                    UIApplication.shared.keyWindow?.rootViewController = tabBarController
                    // 保存数据
                    //shopId
                    if let shopId = checkInfo.shopInfo?.ID{
                        WDBGlobalDataUserDefaults.saveShopID(shopId: "\(shopId)")
                    }
                    //shopName
                    if let shopName = checkInfo.shopInfo?.shopName{
                        WDBGlobalDataUserDefaults.saveShopName(shopName: shopName)
                    }
                    //patternType
                    if let patternType = checkInfo.shopInfo?.patternType{
                     let patternTypeStr = String(describing:patternType)
                       WDBGlobalDataUserDefaults.saveShopTurnoverType(patternType: patternTypeStr)
                    }
                    //ownerId
                    if let ownerId = checkInfo.shopInfo?.ownerId{
                       WDBGlobalDataUserDefaults.saveOwnerId(ownerId: ownerId)
                    }
                    //保存会员结束时间
                    if let endTime = checkInfo.shopInfo?.endTime{
                        WDBGlobalDataUserDefaults.saveEndTime(endTime: endTime)
                    }
                }else if (checkStatus == 2) {
                    //审核失败
                    let tabBarController = navigator.viewController(for: NavigatorURLTabBar)
                    UIApplication.shared.keyWindow?.rootViewController = tabBarController
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
     //MARK-获取店铺申请审核状态
    func getCheckStatusInfo(phone:String, userId:Int) ->  Observable<WDBRegisterStoreCheckInfo>{
             return defaultProvider.rx.request(MultiTarget(WDBApiRegister.queryCheckStatus(phone: phone, userId:userId))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBRegisterStoreCheckInfo.self)
        }
    
    //MARK-请求阿里云信息
    //获取阿里云信息
    
    func getOSSInfo() {
     _ = systemViewModel.getOSSInfo().subscribe(onNext: { (ossInfo) in
            
            WDBAccountManager.sharedManger.ossInfo = ossInfo
            
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
    }
    
    //MARK-上传clientId到服务端
    func uploadClientIdToServer() {
         let userId = String(describing: WDBGlobalDataUserDefaults.getID())
         let clientId = WDBGlobalDataUserDefaults.getClientId()
         let token = WDBGlobalDataUserDefaults.getToken()
        //用户Id，没有的话，不上传
        if userId == "-1" {
            return
        }
        //用户clientId，没有的话，不上传
        if clientId == "" {
            return
        }
        //判断是否Token存在
        if token == "" {
            return
        }
        
       let paramDic = ["userId":userId, "clientId":clientId, "regWay":"iOS"] as [String:Any]
        _ = defaultProvider.rx.request(MultiTarget(WDBApiSystem.uploadClientIdToServerWith(Dict: paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().subscribe(onNext: { (respnonse) in
            print("上传clientId成功")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    //MARK-跳转到登录页
    func goBackLoginPage() {
       let loginVC = navigator.viewController(for: NavigatorURLLogin)
        let navi = WDBNavigationController.init(rootViewController: loginVC!)
        UIApplication.shared.keyWindow?.rootViewController = navi
        //清空本地的缓存信息
        WDBGlobalDataUserDefaults.saveToken(token: "")
        WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: "")
    }
    
    
    //MARK-字典转化为一个Model
    func changeDictionaryToModel<T: Mappable>(type: T.Type,dict: [String: Any]) -> T {
        return Mapper<T>().map(JSON: dict)!
    }
    //MARK-将一个Model转化为Json字符串
    
    
}

