//
//  WDBGlobalData.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBGlobalDataUserDefaults: NSObject {
    
    //MARK - 用户信息
    //保存Token
    class func saveToken(token:String) {
       UserDefaults.standard.set(token, forKey: "token")
       UserDefaults.standard.synchronize()
    }
    //获取token
    class func getToken() -> String {
        let token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
        return token
    }
    
    //保存refreshToken
    class func saveRefreshToken(refreshToken:String) {
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
    //获取refreshToken
    class func getRefreshToken() -> String {
        let token = UserDefaults.standard.value(forKey: "refreshToken") as? String ?? ""
        return token
    }
    
   //保存ID
   class func saveID(ID: Int){
        UserDefaults.standard.set(ID, forKey: "ID")
        UserDefaults.standard.synchronize()
    }
   //取出ID
   class func getID() -> Int {
      let ID = UserDefaults.standard.value(forKey: "ID") as? Int ?? -1
        return ID
    }
    
    //保存providerId
   class func saveProviderID(providerID: String) {
        UserDefaults.standard.set(providerID, forKey: "providerID")
        UserDefaults.standard.synchronize()
    }
    //取出providerId
    class func getProviderID() -> String {
        let providerID = UserDefaults.standard.value(forKey: "providerID") as? String ?? ""
        return providerID
    }
    
    //保存providerUserId
   class func saveProviderUserId(providerUserId: String) {
        UserDefaults.standard.set(providerUserId, forKey: "providerUserId")
        UserDefaults.standard.synchronize()
    }
    //取出providerUserId
   class func getProviderUserId() -> String {
        let providerUserId = UserDefaults.standard.value(forKey: "providerUserId") as? String ?? ""
        return providerUserId
    }
    
    //保存用户userid
     class func saveUserid(userid: String) {
        UserDefaults.standard.set(userid, forKey: "userid")
        UserDefaults.standard.synchronize()
    }
    //取出用户的userid
     class func getUserid() -> String {
        let userid = UserDefaults.standard.value(forKey: "userid") as? String ?? ""
        return userid
    }
    
    //保存UserId
   class func saveSpecialUserId(userId: String) {
         UserDefaults.standard.set(userId, forKey: "userId")
         UserDefaults.standard.synchronize()
    }
    //取出UserId
   class func getSpecialUserId() -> String {
        let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
        return userId
    }
    //保存ownerId
    class func saveOwnerId(ownerId: Int) {
         UserDefaults.standard.set(ownerId, forKey: "ownerId")
         UserDefaults.standard.synchronize()
    }
    //取出ownerId
    class func getOwnerId() -> Int {
       let ownerId = UserDefaults.standard.value(forKey: "ownerId") as? Int ?? 0
       return ownerId
    }
    //保存头像
     class func saveAvatar(imageUrl: String) {
        UserDefaults.standard.set(imageUrl, forKey: "userAvatar")
        UserDefaults.standard.synchronize()
    }
    //取出头像
     class func getAvatar() -> String {
        let imageUrl = UserDefaults.standard.value(forKey: "userAvatar") as? String ?? ""
        return imageUrl
    }
    
    //保存手机号
     class func saveUserPhone(phone:String) {
         UserDefaults.standard.set(phone, forKey: "phone")
         UserDefaults.standard.synchronize()
    }
    //取出手机号
     class func getUserPhone() -> String {
     let phone = UserDefaults.standard.value(forKey: "phone") as? String ?? ""
     return phone
    }
    
    //保存微信绑定状态
    class func saveBindStatus(bindStatus:Int) {
        UserDefaults.standard.set(bindStatus, forKey: "bindStatus")
        UserDefaults.standard.synchronize()
    }
    //取出微信绑定状态
    class  func getBindStatus() -> Int {
      let bindStatus =  UserDefaults.standard.value(forKey: "bindStatus") as? Int ?? 0
       return bindStatus
    }
    //保存会员的结束时间
    class func saveEndTime(endTime:Double) {
        UserDefaults.standard.set(endTime, forKey: "endTime")
        UserDefaults.standard.synchronize()
    }
    //取出endTime
    class func getEndTime() -> Double {
        let endTime = UserDefaults.standard.value(forKey: "endTime") as? Double ?? 0.0
         return endTime
    }
    //保存审核状态
    class func saveCheckStatus(checkStatus: Int) {
         UserDefaults.standard.set(checkStatus, forKey: "checkStatus")
         UserDefaults.standard.synchronize()
    }
    //取出审核状态
    class func getCheckStatus() -> Int{
        let checkStatus = UserDefaults.standard.value(forKey: "checkStatus") as? Int ?? -1
        return checkStatus
    }
    
    //MARK -店铺信息保存
    //保存店铺shopid
    class func saveShopID (shopId:String) {
        UserDefaults.standard.set(shopId, forKey: "ShopId")
        UserDefaults.standard.synchronize()
    }
    
    //获取店铺shopid
    class func getShopID () -> String {
        let type = UserDefaults.standard.value(forKey: "ShopId") as? String ?? ""
        return type
    }
    
    //保存店铺名
    class func saveShopName (shopName:String) {
        UserDefaults.standard.set(shopName, forKey: "ShopName")
        UserDefaults.standard.synchronize()
    }
    
    //获取店铺名
    class func getShopName () -> String {
        let name = UserDefaults.standard.value(forKey: "ShopName") as? String ?? ""
        return name
    }
        
    //保存店铺翻桌率模式
    class func saveShopTurnoverType(patternType:String) {
        UserDefaults.standard.set(patternType, forKey: "TurnoverType")
        UserDefaults.standard.synchronize()
    }
    
    //获取店铺翻桌率模式
    class func getShopTurnoverType() -> String {
        let type = UserDefaults.standard.value(forKey: "TurnoverType") as? String ?? ""
        return type
    }
    
    //保存账户余额
    class func saveShopAccount(account:Float) {
        UserDefaults.standard.set(account, forKey: "ShopAccount")
        UserDefaults.standard.synchronize()
    }
    
    //获取账户余额
    class func getShopAccount() -> Float {
        let shopAccount = UserDefaults.standard.value(forKey: "ShopAccount") as? Float ?? 0
        return shopAccount
    }
    
    //是否第一次下载App，用以显示引导页
    //保存 是否显示引导页
    class func saveIsLoadGuidePage(isLoadGuidePage: Bool){
         UserDefaults.standard.set(isLoadGuidePage, forKey: "isLoadGuidePage")
         UserDefaults.standard.synchronize()
    }
    //获取是否需要引导页
    class func getIsLoadGuidePage() -> Bool {
        let isLoadGuidePage = UserDefaults.standard.value(forKey: "isLoadGuidePage") as? Bool ?? false
        return isLoadGuidePage;
    }
    
    //保存本地的clientId
    class func saveClientId(clientId: String) {
        UserDefaults.standard.set(clientId, forKey: "clientId")
        UserDefaults.standard.synchronize()
    }
    //去除本地的clientId
    class func getClientId() -> String {
        let clientId = UserDefaults.standard.value(forKey: "clientId") as? String ?? ""
        return clientId
    }
    
    //删除本地信息
   class func deleteLocalStorage() {
       WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: "")
       WDBGlobalDataUserDefaults.saveToken(token: "")
    }
    
}
