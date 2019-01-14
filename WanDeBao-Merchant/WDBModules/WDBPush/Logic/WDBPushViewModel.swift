//
//  WDBPushViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/4.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import UserNotifications

class WDBPushViewModel: NSObject, GeTuiSdkDelegate, UNUserNotificationCenterDelegate {
    
    public static let shared = WDBPushViewModel()
    
    //第一步 启动个推
    func startGeTui() {
         GeTuiSdk.start(withAppId: GTAppId, appKey: GTAppKey, appSecret: GTAppSecret, delegate: self)
        //注册远程推送
        self.registerRemoteNotification()
    }
    
    //第二步注册APNs远程推送，获取DeviceToken
    func registerRemoteNotification() {
        
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
         // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            UIApplication.shared.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
    }
    
    //第三步 在didRegisterForRemoteNotificationsWithDeviceToken获取到Token，向个推注册deviceToken
    func registerDeviceToken(data:Data) {
        let deviceToken:String = data.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>"))
        let token = deviceToken.replacingOccurrences(of: " ", with: "")
        print("deviceToken = \(token)")
        //注册DeviceToken
        GeTuiSdk.registerDeviceToken(token)
    }
    
    
    //MARK - 个推回调
    /** SDK启动成功返回cid */
    func geTuiSdkDidRegisterClient(_ clientId: String!) {
        print("GTClientId = \(clientId)")
        if clientId.count > 0 {
          let oldClientId = WDBGlobalDataUserDefaults.getClientId()
            // 再次判断请求到的clientId是否跟本地的一样，如果不一样，更新本地的clientId，并把新的clientId上传到服务器
            if oldClientId != oldClientId {
             WDBCommonHelper.shared.uploadClientIdToServer()
             WDBGlobalDataUserDefaults.saveClientId(clientId: clientId ?? "")
            }
        }
    }
    
    /** SDK遇到错误回调 */
    func geTuiSdkDidOccurError(_ error: Error!) {
        //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
        print("GTError = \(error.localizedDescription)")
    }
    
}
