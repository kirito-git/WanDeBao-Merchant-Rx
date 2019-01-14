//
//  YBProgressHUD.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/7/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

class YBProgressHUD: NSObject {
    
    //显示loading
   class func showLoadingTo(view: UIView){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.opacity = 0.6
        hud.animationType = .zoom
    }
    //隐藏loading
    class func hideLoadingForView(view: UIView) -> Bool {
        return MBProgressHUD.hide(for: view, animated: true)
    }
    
    //显示文字
   class func showTipMessage(text: String){
        
        if let view = UIApplication.shared.windows.last {
        //快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text
//        hud.bezelView.backgroundColor = UIColor.black
//        hud.bezelView.alpha = 0.6
        
        //隐藏时候从父视图移除
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.0)
        }
        
    }

}
