//
//  AppDelegate.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/7.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
/*
 * 支付完成代理
 */
protocol OrderPayFinishDelegate:NSObjectProtocol {
    func orderPayFinish(With payType:WDBPayType, isSuccess:Bool,respMsg:String)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var appDelegateService: AppDelegateService?
    var orderPayDelegate: OrderPayFinishDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initService()
        
        return true
    }
    
    func initService() {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        
        //注册Navigator，可实现全局跳转
        NavigationMap.initialize(navigator: navigator)
        
        //判断本地存储的Token和ShopId是否存在，若存在直接进入主页面，若不存在，重新登录
        let token = WDBGlobalDataUserDefaults.getToken()
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        if token.count > 0 && shopId.count > 0 {
            let tabBarVC = WDBTabBarController()
            self.window?.rootViewController = tabBarVC
        }else{
            let loginVC = WDBLoginViewController();
            let navi = WDBNavigationController.init(rootViewController: loginVC)
            self.window?.rootViewController = navi;
        }
        self.window?.makeKeyAndVisible();
        
        appDelegateService = AppDelegateService()
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         //个推注册DeviceToken
          WDBPushViewModel.shared.registerDeviceToken(data: deviceToken)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //用户是否是从微信返回本app
        let isTrue = UserDefaults.standard.value(forKey: "isBackToAppFromWechatPayPage") as! Bool?
        if isTrue != nil {
            if isTrue == true {
                UserDefaults.standard.set(false, forKey: "isBackToAppFromWechatPayPage")
                self.orderPayDelegate?.orderPayFinish(With: .wxpay, isSuccess: true, respMsg: "支付结果待确认！")
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //iOS10
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return (appDelegateService?.isDealWithReturnData(url: url)) ?? false
    }
    
    //iOS9
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return (appDelegateService?.isDealWithReturnData(url: url)) ?? false
    }


}

