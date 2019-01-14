//
//  WDBLoginViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

let phoneNumberLength = 11
let minCodeLength = 4

class WDBLoginViewModel {
    
    let phoneNumber = Variable("")
    let code = Variable("")
    
    var validedPhoneNumber: Observable<Bool>
    var validedCode: Observable<Bool>
    var validedLoginEnable: Observable<Bool>
    var valideGetCodeEnable: Observable<Bool>
    
    var oldPhoneNo: String?
    
    
    private let disposeBag = DisposeBag()
    public static let shared = WDBLoginViewModel()
    
    init() {
        
        validedPhoneNumber = phoneNumber.asObservable().map({ (phoneNumber)  in
             return phoneNumber.count == phoneNumberLength
        })
        
        validedCode = code.asObservable().map({ (code) in
             return code.count >= 4
        })
        
        validedLoginEnable = Observable.combineLatest(validedPhoneNumber, validedCode, resultSelector: { (pn, co) in
             return pn && co
        })
        
        valideGetCodeEnable = validedPhoneNumber
        
    }
    //获取hash
    func getHash() -> Observable<WDBHashCode>{
        
        print(phoneNumber.value)
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.getHash(phone: phoneNumber.value, type: 0)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().mapObject(type: WDBHashCode.self)
    }
    
    // 获取验证码
    func getCode(hashCode: String) -> Observable<WDBLoginSmsInfo> {
        
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.getCode(phone: phoneNumber.value, type: 0, hashCode: hashCode)))
            .filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBLoginSmsInfo.self)
    }
    
    //验证码登录
    func verifyCodeLogin(sid:String, appCode:String) -> Observable<WDBLoginInfo> {
        
        print(appCode,sid,phoneNumber.value,code.value)
        
        let params = ["appcode":appCode, "sid":sid, "phone":phoneNumber.value, "smsCode":code.value]
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.verifyCodeLogin(Dict: params))).filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().mapObject(type: WDBLoginInfo.self)
    }
      
    //验证旧手机号
    func verifyOldPhoneNo() -> Observable<Any> {
        let sid = WDBAccountManager.sharedManger.sid ?? ""
        let ID = WDBGlobalDataUserDefaults.getID()
        let paramDic = ["phone": phoneNumber.value, "id":ID, "smsCode":code.value, "sid":sid] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiRegister.verifyOldPhoneNumber(Dict: paramDic))).filterSuccessfulStatusCodes().asObservable().mapJSON()
    }
    
    // 修改新手机
    func changeNewPhoneNo(oldPhoneNo:String, usercert:String) -> Observable<WDBUserInfo> {
        
        let sid = WDBAccountManager.sharedManger.sid ?? ""
        let ID = WDBGlobalDataUserDefaults.getID()
        let paramDic = ["oldPhone": oldPhoneNo, "id":ID, "usercert":usercert, "newPhone": phoneNumber.value, "smsCode":code.value, "sid":sid, "appCode":"app_wdb"] as [String:Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiRegister.changePhoneNumber(Dict: paramDic))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBUserInfo.self)
    }
    
    //微信登录成功后绑定手机号
    func bindPhone() -> Observable<WDBUserInfo> {
        let sid = WDBAccountManager.sharedManger.sid ?? ""
        let ID = WDBAccountManager.sharedManger.loginInfo?.userInfo?.ID ?? 0
        let userid = WDBAccountManager.sharedManger.loginInfo?.userInfo?.userid ?? ""
        let paramDic = ["phone":phoneNumber.value, "appcode":"app_wdb", "id":ID, "userId":userid, "smsCode":code.value, "sid":sid] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiWeChat.weChatBindPhone(dict: paramDic)))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .mapObject(type: WDBUserInfo.self)
    }
    
    
    
}

