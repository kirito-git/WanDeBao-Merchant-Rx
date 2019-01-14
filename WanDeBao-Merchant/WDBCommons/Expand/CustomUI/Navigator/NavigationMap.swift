//
//  NavigationMap.swift
//  WanDeBao-Merchant
//
//  Created by wml on 2018/7/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import URLNavigator

//全局的Navigator
public let navigator = Navigator()

enum NavigationMap {
    
    static func initialize(navigator: NavigatorType) {
        
        
        //导航
        navigator.register(NavigatorURLNavi) { (url, values, context) -> UIViewController? in
            return WDBNavigationController()
        }
        
       //TabBar
        navigator.register(NavigatorURLTabBar) { (url, values, context) -> UIViewController? in
            return WDBTabBarController()
        }
        
        //MARK - 登录
        //登录页
        navigator.register(NavigatorURLLogin) {url, values, context in
            return WDBLoginViewController()
        }
        // 注册页面
        navigator.register(NavigatorURLRegisterStore) { (url, values, context) -> UIViewController? in
            return WDBRegisterStoreViewController()
        }
        //提交信息页面
        navigator.register(NavigatorURLSubmitInfo + "/" + "<passparams>") { (url, values, context) -> UIViewController? in
            guard let passDataStr = values["passparams"] as? String else {return nil}
            //Json字符串转化为字典
            let passDataDic = JSONTools.dicFromJsonString(json: passDataStr)
            let submitInfoVC = WDBSubmitInfoViewController()
            submitInfoVC.authenticationInfoDic = passDataDic
            return submitInfoVC
        }
        //提交认证结果页面
        navigator.register(NavigatorURLSubmitInfoResult) { (url, values, context) -> UIViewController? in
            return WDBSubmitInfoResultViewController()
        }
        //绑定手机号页面
        navigator.register(NavigatorURLBindPhone + "/" + "<passparams>") { (url, values, context) -> UIViewController? in
            
            guard let passDataStr = values["passparams"] as? String else {return nil}
            //Json字符串转化为字典
            let passDataDic = JSONTools.dicFromJsonString(json: passDataStr)
            
            let bindPhoneVC = WDBBindPhoneViewController()
            //控制器类型
            if let type = passDataDic["type"] as? String {
                bindPhoneVC.phoneNoAndCodeControllerType = WDBPhoneNoAndCodeControllerType(rawValue: Int(type)!)
            }
            //userCert
            if let userCert = passDataDic["userCert"] as? String {
               bindPhoneVC.userCert = userCert
            }
            //旧手机号码
            if let oldPhoneNo = passDataDic["oldPhoneNumber"] as? String {
                bindPhoneVC.oldPhoneNumber = oldPhoneNo
            }
            return bindPhoneVC
        }
        
        //MARK - 首页
        //首页
        navigator.register(NavigatorURLHomePage) { (url, values, context) -> UIViewController? in
            return WDBHomePageViewController()
        }
        
        navigator.register(NavigatorURLShopBill) { (url, values, context) -> UIViewController? in
            return WDBShopBillViewController()
        }
        
        navigator.register(NavigatorURLScanResult) { (url, values, context) -> UIViewController? in
            let scanVC = WDBScanResultViewController()
            scanVC.scanResultString = context as! String
            return WDBScanResultViewController()
        }
        
        
        
        //MARK - 管理
        navigator.register(NavigatorURLManagement) { (url, values, context) -> UIViewController? in
            return WDBManagementViewController()
        }
        //店铺管理
        navigator.register(NavigatorURLShopManage) { (url, values, context) -> UIViewController? in
            return WDBShopManageViewController()
        }
        //优惠券管理
        navigator.register(NavigatorURLDiscountManage) { (url, values, context) -> UIViewController? in
            return WDBDiscountManageViewController()
        }
        //添加优惠券管理
        navigator.register(NavigatorURLManagementAddDiscount + "/" + "<passparams>") { (url, values, context) -> UIViewController? in
            guard let passDataStr = values["passparams"] as? String else {return nil}
            
            let discountManageAddVC = WDBDiscountManageAddViewController()
            //Json字符串转化为字典
            let passDataDic = JSONTools.dicFromJsonString(json: passDataStr)
            
            if let currentType = passDataDic["currentType"] as? String {
                 discountManageAddVC.current_Type = currentType
            }
            if let isActionAdd = passDataDic["isActionAdd"] as? Bool {
                discountManageAddVC.isActionAdd = isActionAdd
            }
            return discountManageAddVC
        }
        //积分优惠券兑换
        navigator.register(NavigatorURLDiscountIntegralExchange) { (url, values, context) -> UIViewController? in
            return WDBDiscountIntegralExchangeViewController()
        }
        //积分产品添加
        navigator.register(NavigatorURLIntegralProductAdd) { (url, values, context) -> UIViewController? in
            return WDBIntergralProductAddViewController()
        }
        //推广
        navigator.register(NavigatorURLExpand) { (url, values, context) -> UIViewController? in
            return WDBExpandViewController()
        }
        //推广设置
        navigator.register(NavigatorURLExpandSet) { (url, values, context) -> UIViewController? in
            return WDBExpandSetViewController()
        }
        //添加游戏
        navigator.register(NavigatorURLGameAdd) { (url, values, context) -> UIViewController? in
            return WDBGameAddViewController()
        }
        //游戏管理
        navigator.register(NavigatorURLGameManagement) { (url, values, context) -> UIViewController? in
            return WDBGameManageViewController()
        }
        //订单支付类型
        navigator.register(NavigatorURLOrderPayType) { (url, values, context) -> UIViewController? in
            
            let orderPayTypeVC = WDBOrderPayTypeViewController()
            if let tupleData = context as? (products: [WDBProductModel], orderModel: WDBOrderModel) {
                  orderPayTypeVC.tupleData = tupleData
            }
            return orderPayTypeVC
        }
        //精品添加
        navigator.register(NavigatorURLQualityGoodsAdd) { (url, values, context) -> UIViewController? in
            
            let qualityGoodsAddVC = WDBQualityGoodsAddViewController()
            if let isQuality = context as? Bool {
                qualityGoodsAddVC.passValues(isquality: isQuality)
            }
            return qualityGoodsAddVC
        }
        //精品管理
        navigator.register(NavigatorURLQualityGoodsManagement) { (url, values, context) -> UIViewController? in
            let qualityGoodsVC = WDBQualityGoodsManageViewController()
            if let isQuality = context as? Bool {
                qualityGoodsVC.isQuality = isQuality
            }
            return qualityGoodsVC
        }
        //翻桌率管理
        navigator.register(NavigatorURLTurnoverManagement) { (url, values, context) -> UIViewController? in
            return WDBTurnoverManageViewController()
        }
        //翻桌率设置
        navigator.register(NavigatorURLTurnoverSet) { (url, values, context) -> UIViewController? in
            return WDBTurnoverSetViewController()
        }
        //翻桌率类型设置
        navigator.register(NavigatorURLTurnoverStyleSet) { (url, values, context) -> UIViewController? in
            return WDBTurnoverStyleSetViewController()
        }
        //附近商铺
        navigator.register(NavigatorURLNearbyShop) { (url, values, context) -> UIViewController? in
            return WDBNearbyShopViewController()
        }
        
        
        //MARK - 消息
        navigator.register(NavigatorURLMessage) { (url, values, context) -> UIViewController? in
            return WDBMessageViewController()
        }
        
        // 消息详情
        navigator.register(NavigatorURLMessageDetail + "/" + "<passparams>") { (url, values, context) -> UIViewController? in
            
          guard let messageDataStr = values["passparams"] as? String else {return nil}
           //Json字符串转化为字典
          let messageDataDic = JSONTools.dicFromJsonString(json: messageDataStr)
           //转化为Model
          let model = WDBCommonHelper.shared.changeDictionaryToModel(type: WDBMessageModel.self, dict: messageDataDic)
          let messageDetailVC = WDBMessageDetailVC()
          messageDetailVC.model = model
          return messageDetailVC
        }

        //MARK - 我的
        //我的界面
        navigator.register(NavigatorURLMine) { (url, values, context) -> UIViewController? in
            return WDBMineViewController()
        }
        //账户资金
        navigator.register(NavigatorURLAccountFund) { (url, values, context) -> UIViewController? in
            return WDBAccountFundViewController()
        }
        //门店资质
        navigator.register(NavigatorURLStoreQualication) { (url, values, context) -> UIViewController? in
            return WDBStoreQualificationViewController()
        }
        //使用手册
        navigator.register(NavigatorURLUseManual) { (url, values, context) -> UIViewController? in
            return WDBUseManualViewController()
        }
        //设置
        navigator.register(NavigatorURLSetting) { (url, values, context) -> UIViewController? in
            return WDBSettingViewController()
        }
        //意见反馈
        navigator.register(NavigatorURLFeedback) { (url, values, context) -> UIViewController? in
            return WDBFeedBackViewController()
        }
        //余额提现
        navigator.register(NavigatorURLBalanceWithdraw) { (url, values, context) -> UIViewController? in
           return WDBBalanceWithdrawViewController()
        }
        //我的银行卡
        navigator.register(NavigatorURLMyBankCard) { (url, values, context) -> UIViewController? in
            let bankCardVC = WDBMyBankCardViewController()
            if let dic = context as? [String:Any] {
                if let isselect = dic["isSelect"] as? String {
                    bankCardVC.isSelectCard = (isselect == "1") ? true : false
                }
            }
            return bankCardVC
        }
        //绑定银行卡
        navigator.register(NavigatorURLBindBankCard) { (url, values, context) -> UIViewController? in
          return WDBBindBankCardViewController()
        }
        //个人信息
        navigator.register(NavigatorURLPersonalInfo) { (url, values, context) -> UIViewController? in
          return WDBPersonalInfoViewController()
        }
        //修改手机号
        navigator.register(NavigatorURLChangePhone) { (url, values, context) -> UIViewController? in
          return WDBChangePhoneViewController()
        }
        //充值
        navigator.register(NavigatorURLRecharge) { (url, values, context) -> UIViewController? in
          return WDBRechargeViewController()
        }
        //续费
        navigator.register(NavigatorURLRenewal) { (url, values, context) -> UIViewController? in
          return WDBRenewalViewController()
        }
        
        //提示弹框
        navigator.handle(NavigatorURLAlert) { (url, values, context) -> Bool in
           let title = url.queryParameters["title"]
           let message = url.queryParameters["message"]
           var isPop = false
           if let isPopStr = url.queryParameters["isBack"] {
              isPop = Bool(isPopStr) ?? false
           }
           let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
           alertController.addAction(UIAlertAction(title: "确定", style:.default, handler: {(action) in
            if isPop {
                if let dict = context as? [String:Any] {
                    let viewController = dict["fromViewController"] as? UIViewController
                    viewController?.navigationController?.popViewController(animated: true)
                }
            }
            }))
            navigator.present(alertController)
          return true
        }
        
        
    }
    
}
