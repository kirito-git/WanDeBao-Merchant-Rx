//
//  WDBMineTableViewDelegate.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMineTableViewDelegate: NSObject, UITableViewDelegate {
    
    public weak var viewController: UIViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      switch indexPath.section {
        case 0:
             navigator.push(NavigatorURLAccountFund)
            break
        case 1:
             navigator.push(NavigatorURLStoreQualication)
            break
        case 2:
             navigator.push(NavigatorURLUseManual)
           break
        case 3:
             navigator.push(NavigatorURLSetting)
           break
        case 4:
             navigator.push(NavigatorURLFeedback)
           break
      default:
           break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = APP_BK_COLOR
        return footerView
    }
    
}
