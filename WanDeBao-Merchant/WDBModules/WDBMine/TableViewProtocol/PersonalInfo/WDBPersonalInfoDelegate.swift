//
//  WDBPersonalInfoDelegate.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

enum WDBChangePersonalInfoActionType: Int {
    case changeAvatar
    case changePhone
    case bindWeChat
}


class WDBPersonalInfoDelegate: NSObject, UITableViewDelegate {
    
    public typealias WDBChangePersonalInfoClourse = (_ actionType:WDBChangePersonalInfoActionType) -> Void
    public var changePersonalInfoClourse: WDBChangePersonalInfoClourse?
    
    override init() {
        
    }
    
    public func changePersonalInfo(clourse: @escaping WDBChangePersonalInfoClourse) {
        self.changePersonalInfoClourse = clourse
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let clourse = self.changePersonalInfoClourse else { return  }
        
        if indexPath.section == 0 {
          clourse(WDBChangePersonalInfoActionType.changeAvatar)
        }else if indexPath.section == 1{
          clourse(WDBChangePersonalInfoActionType.changePhone)
        }else if indexPath.section == 2{
        let status = WDBGlobalDataUserDefaults.getBindStatus()
            if status == 1 {
                print("微信已绑定，请勿重复绑定")
                //SVProgressHUD.showInfo(withStatus:"微信已绑定，请勿重复绑定!" )
                YBProgressHUD.showTipMessage(text: "微信已绑定，请勿重复绑定!")
                return
            }
          clourse(WDBChangePersonalInfoActionType.bindWeChat)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }else{
        return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let footerView = UIView()
        footerView.backgroundColor = APP_BK_COLOR
        return footerView
    }
    

}
