//
//  WDBOrderPayTypeViewModel.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBOrderPayTypeViewModel: NSObject {
    
    //是否允许支付 如果支付宝和微信都没安装 则无法支付
    var isPermissionPay = false
    var isInstallWX = false
    var isInstallAlipay = false
    //默认余额支付
    var marks:[Bool] = [true ,false]
    var typesName = ["ALIPAY_MOBILE","WX_APP"]
    var paytypeName = [WDBPayType.alipay,WDBPayType.wxpay]
    var payType:WDBPayType = .alipay
    var payChannel = "ALIPAY_MOBILE"
    var payTypeNames = [["icon":"alipay","name":"支付宝支付"],["icon":"wechat","name":"微信支付"]]

    
    func cellSelect(row:Int) {
        marks = [false,false]
        marks[row] = true
        payChannel = typesName[row]
        payType = paytypeName[row]
    }
    
    func isInstallWXOrAlipay() {
        isInstallWX = WXApi.isWXAppInstalled()
        if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!) {
            isInstallAlipay = true
        }
//        if isInstallAlipay == true {
//            if isInstallWX == false {
//                //只安装了支付宝
//                marks = [true]
//                typesName = ["ALIPAY_MOBILE"]
//                paytypeName = [WDBPayType.alipay]
//                payType = .alipay
//                payChannel = "ALIPAY_MOBILE"
//                payTypeNames = [["icon":"alipay","name":"支付宝支付"]]
//            }
//        }else {
//            if isInstallWX == true {
//                //只安装了微信
//                marks = [true]
//                typesName = ["WX_APP"]
//                paytypeName = [WDBPayType.wxpay]
//                payType = .wxpay
//                payChannel = "WX_APP"
//                payTypeNames = [["icon":"wechat","name":"微信支付"]]
//            }else {
//                //两个都没安装
//                isPermissionPay = true
//                payTypeNames = []
//            }
//        }
        
    }
    
}
