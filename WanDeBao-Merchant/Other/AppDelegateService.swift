//
//  AppDelegateService.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//
import UIKit
import RxSwift
import SwiftyJSON
import Moya
import IQKeyboardManagerSwift
import GuidePageView
import URLNavigator

class AppDelegateService: NSObject,GeTuiSdkDelegate,WXApiDelegate {
    
    override init() {
        super.init()
        //NotificationCenter.default.addObserver(self, selector: #selector(refreshToken), name: NSNotification.Name(rawValue: kRefreshTokenNotification), object: nil)
        //注册第三方
        setupThirdParty()
        //加载Banner图
        loadBannerView()
        
    }
    
    
    func loadBannerView() {
        
        //启动引导页
        let isLoadGuidePage = WDBGlobalDataUserDefaults.getIsLoadGuidePage()
        //isLoadGuidePage = false
        if !isLoadGuidePage {
            let imageArray = ["guideimage_1.png", "guideimage_2.png", "guideimage_3.png", "guideimage_4"]
            let guideView: GuidePageView = GuidePageView.init(images: imageArray,
                                                              isHiddenSkipBtn: false,
                                                              isHiddenStartBtn:false, loginRegistCompletion: {
                                                                
            }, startCompletion:{
                //确认进入主App
                
            })
            guideView.startButton.isHidden = true
            guideView.pageControl.currentPageIndicatorTintColor = UIColor_MainOrangeColor
            guideView.logtinButton.setTitle("", for: .normal)
            guideView.logtinButton.setBackgroundImage(UIImage.init(named: "entericon"), for: .normal)
            UIApplication.shared.windows.first?.addSubview(guideView)
            WDBGlobalDataUserDefaults.saveIsLoadGuidePage(isLoadGuidePage: true)
        }
        
    }
    
    //设置第三方
    func setupThirdParty() {
       //友盟注册
        UMConfigure.initWithAppkey(UMeng_AppKey, channel: "App Store")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WXPatient_App_ID, appSecret: WXPatient_App_Secret, redirectURL: "")
        UMConfigure.setLogEnabled(true);
       //UMSocialManager.default().umSocialAppkey = UMeng_AppKey
        
        //注册个推
        WDBPushViewModel.shared.startGeTui()
        //微信
        WDBWeChatViewModel.shared.registerWeChat()
        //IQKeyboradManagerSwift 开启整个项目的自动键盘处理事件
         IQKeyboardManager.shared.enable = true
        // 点击键盘以外的地方收回键盘
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //隐藏键盘上的工具条
        //IQKeyboardManager.shared.enableAutoToolbar = false
        
    }
    
    // 是否处理第三方返回回来的数据
    func isDealWithReturnData(url: URL) -> Bool {
        let host = url.host ?? ""
        if host.isEqual("safepay") {
            //跳转支付宝钱包进行支付，处理支付结果
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                print("result===")
                print(resultDic!)
                if let result = resultDic as? [String:Any] {
                    
                   let code  = result["resultStatus"] as? String ?? ""
                    
                    if code == "9000" {
                        //支付成功回掉
                        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                        myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess:true ,respMsg: "选购成功！")
                    }else if code == "6001" {
                        //用户中途取消
                        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                        myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess:false ,respMsg: "您取消了支付")
                    }else {
                        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                        myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess:false ,respMsg: "订单支付失败！")
                    }
                }
            })
        }
        
        if url.absoluteString.hasPrefix(WXPatient_App_ID){
            
            let isSuccess:Bool = WXApi.handleOpen(url, delegate: WDBWeChatViewModel.shared)
            print("微信代理绑定\(isSuccess)")
        }
        return true
    }
    
    
    
    
    
}
