//
//  WDBWeChatViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/4.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya

enum WDBWeChatOperationType: Int {
    case login = 0
    case bind
}

class WDBWeChatViewModel: NSObject, WXApiDelegate {
    
    public static let shared = WDBWeChatViewModel()
    var operationType: WDBWeChatOperationType?
    var viewController: UIViewController?
    private let WXScope = "snsapi_userinfo"
    private let WXState = "APP"
    
    
    //注册微信
    func registerWeChat() {
        WXApi.registerApp(WXPatient_App_ID)
    }
    
    //微信登录
    func weChatClickWithOperationType(operationType: WDBWeChatOperationType, viewController: UIViewController) {
        
        let urlStr = "weixin://"
        if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
            let req:SendAuthReq = SendAuthReq.init()
            req.scope = WXScope
            req.state = WXState
            self.operationType = operationType
            self.viewController = viewController
            //发起登录
            WXApi.send(req)
        }
        
    }
    
    
    ////MARK -WXApiDelegate
    
    // 微信请求确认登陆协议回调
    func onResp(_ resp: BaseResp!) {
        //向微信请求授权后，得到响应结果
        
        // 登陆请求返回的结果
        if resp.isKind(of: SendAuthResp.self) {
                let respAuth = resp as? SendAuthResp
                print("\(respAuth?.code ?? ""), \(respAuth?.state ?? "")")
                if let code: String = respAuth?.code {
                    //此处分开是微信登录，还是微信绑定
                    if self.operationType! == .login {
                      self.weChatLogin(code: code)
                    }
                    if self.operationType! == .bind {
                        //调用后台微信绑定
                      self.bindWeChat(code: code)
                    }
            }
            //NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        }
        let errorCode = resp.errCode
        print("errorCode\(errorCode)")
        if errorCode == -2 {
            //用户取消支付
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess:false ,respMsg: "您取消了支付！")
        }else if errorCode == 0 {
            //支付成功回掉
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            myAppDelegate.orderPayDelegate?.orderPayFinish(With: .wxpay, isSuccess:true ,respMsg: "选购成功！")
        }else {
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            myAppDelegate.orderPayDelegate?.orderPayFinish(With: .wxpay, isSuccess:false ,respMsg: "订单支付失败！")
        }

    }
    
    
    //微信登录
     func weChatLogin(code:String) {
        //调用后台微信登录
        _ = self.weChatLoginRequest(code: code as String).subscribe(onNext: { [weak self](loginInfo) in
             print("微信登陆成功");
            
            //如果没有手机号，则跳转到绑定手机号的界面
            //loginInfo.userInfo?.phone = "18667168913"
            if loginInfo.userInfo?.phone == nil {
                
                WDBAccountManager.sharedManger.loginInfo = loginInfo
                WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: loginInfo.token?.refresh_token ?? "")
                WDBGlobalDataUserDefaults.saveToken(token: loginInfo.token?.access_token ?? "")
                
                let paramsDic = ["type":"\(WDBPhoneNoAndCodeControllerType.bindPhoneNo.rawValue)"]
                let jsonStr = JSONTools.jsonStringFromDataDic(dic: paramsDic)
                navigator.push(NavigatorURLBindPhone + "/" + jsonStr)
            }else{
                //已有手机号，可直接登录，在此判断shopId是否存在，不存在的话去审核
                WDBCommonHelper.shared.saveData(loginInfo: loginInfo)
                if let phone = loginInfo.userInfo?.phone, let userId = loginInfo.userInfo?.ID {
                    WDBCommonHelper.shared.dealWithCheckStatus(phone: phone, userId: userId, viewController: (self?.viewController)!)
                }
              }
            }, onError: { (error) in
                
        }, onCompleted: nil, onDisposed: nil)
        
    }
    
   //绑定微信
    func bindWeChat(code:String) {
         // 1. 先登录
        _ = self.weChatLoginRequest(code: code as String).subscribe(onNext: { [weak self](loginInfo) in
            print("微信登陆成功")
            // 2.绑定微信
            _ = self?.bindWeChatRequest(loginInfo: loginInfo).subscribe(onNext: { (loginInfo) in
                print("微信绑定成功")
                WDBGlobalDataUserDefaults.saveBindStatus(bindStatus: 1)
                WDBGlobalDataUserDefaults.saveAvatar(imageUrl: loginInfo.imageUrl ?? "")
                //发送刷新页面的通知
                let notificationName = Notification.Name(rawValue: "kNotificationReloadData")
                NotificationCenter.default.post(name: notificationName, object: self,
                                                userInfo: ["value1":"hangge.com", "value2" : 12345])
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            }, onError: { (error) in
                
        }, onCompleted: nil, onDisposed: nil)
    }
    
    
    //调用微信登录
    func weChatLoginRequest(code: String) -> Observable<WDBLoginInfo> {
        let paramDic = ["providerId": "weixinapp_wandebao", "code": code]
        return defaultProvider.rx.request(MultiTarget(WDBApiLogin.weChatLogin(dict: paramDic)))
            .filterSuccessfulStatusCodes().mapJSON()
            .asObservable().mapObject(type: WDBLoginInfo.self).retry(2)
    }
    
    //调用绑定微信
    func bindWeChatRequest(loginInfo: WDBLoginInfo) -> Observable<WDBUserInfo> {
        let phone = WDBGlobalDataUserDefaults.getUserPhone()
        let id = WDBGlobalDataUserDefaults.getID()
        let providerUserId = loginInfo.userInfo?.provideruserid ?? ""
        let providerId = loginInfo.userInfo?.providerid ?? ""
        let paramDic = ["phone": phone, "appcode":"app_wdb", "id":id, "providerId":providerId, "providerUserid": providerUserId] as [String : Any]
        return defaultProvider.rx.request(MultiTarget(WDBApiWeChat.bindWeChat(dict: paramDic)))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable().mapObject(type: WDBUserInfo.self).retry(2)
    }
    
    
    
    
    
    
    
}
