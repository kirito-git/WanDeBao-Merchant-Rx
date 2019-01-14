//
//  SwiftHeader.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import SVProgressHUD
import Moya
import Alamofire


//屏幕的宽高
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width

//适配iPhoneX
let is_iPhoneX = (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0 ?true:false)
let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0
let iPhoneXBottomBarH: CGFloat = is_iPhoneX ? 34.0 : 0.0

let SizeScale: CGFloat = SCREEN_WIDTH/375

/// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0
public func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
{
    let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
    return color;
}

/*
 * 主题色 橘色
 */
let UIColor_MainOrangeColor:UIColor! = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)

/*
 * 背景颜色
 */
let APP_BK_COLOR:UIColor! = UIColorRGB_Alpha(R: 240, G: 240, B: 240, alpha: 1)

/*
 * 文字颜色
 */
// 标题
let TitleTextColor:UIColor! = UIColorRGB_Alpha(R:70,G:70,B:70,alpha:1)
//详情
let DetailTextColor:UIColor! = UIColorRGB_Alpha(R:140,G:140,B:140,alpha:1)


/*
 * 字体大小
 */
public func UIFontWithSize(size:CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size)
    return font
}

/*
 * 通知
 */
public let kRefreshTokenNotification = "kRefreshTokenNotification"

let disposeBag = DisposeBag()

/*
 * 第三方的Key
 */
//支付宝跳转至本app的scheme
let Alipay_scheme_wdb = "alipay2018042660076289"

//微信
let WXPatient_App_ID = "wx8f34267b816228f0"
let WXPatient_App_Secret = "cc31c0136e8e10ea89f13b4e2460a787"

//连连支付商户秘钥
let LLPayPartnerPrviteKey = "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKOY/d/94VXClHAw3sVj8WDLccl9gsIsDSGhPoe+DPHux7Hqt80K3xbWeEYHpuft/fPDDaCI/Ioiw4NWBOeU6SPPquA4bnn2A78T8CR2jNMmzIUDBO23ddEOP6nfzDSjMdO+Vhvo5YN5ESkB7x7WflHUsYyWrn8s8aBbNVYxKW7jAgMBAAECgYALgBLArzkq7S3AIT9XwunR8xtBncgWXEBkD9C0fCCu1SlGkYhwKoZ6NYNo8NrDzRAgFaMcmOSf1UfHMMHRgb9Nv2IIpJVXOkisLnOlMA0EkADzN0IYi5BOrAsnV8Vfzp01aVi2aqfiCCf29Dhza+ae67rJ2i1zdanIlv5MH3ZD+QJBAM9w3Br6Br0M2EuX1byGH6Lem2vtSu7FCo6pCGmst2yO/pUOf1RoEHc9HPslIjyKcYID8rx0gq5IaL00/X0ST70CQQDJ5MYfdMtDMcb9sxHJL0l9u5yP2elDOa5OlmMQLBIioX9jut89nweJhk1Aqv/4sW1jwOf7fqHpyCeD1dSwLdMfAkBzo6Cv0S2sedqh2VSnMcW1D49ozPF2xZUrDgPIlSXzeItnIJvOu+xh7EmZn4vEYBECv5yzfefTrD3nLAEblfepAkBBn4DefKINB0L895WSZTJoEfFDuLrfRQJpPOyaNxj19LRpgDZL20Mh6mt11584AMPjprJAxtpuGMbvTTPCyEJVAkBO7bTdfg2tYuuEDmCFaFT1+fXYDUA3po2I6gk4K9SWKSBsW7AGtCi7DCzZLgQyr1VITfLJeQ37OU3amZ0/LyNl"

//个推信息
// 测试的
//let GTAppId = "bifFqRB2W799tT4RGLFTm9"
//let GTAppKey = "3tTXwgqzQb8CI10BppA8D3"
//let GTAppSecret = "Cxio1UNxGH8ZIhCrmE5N7A"

// 正式的
  let GTAppId = "8VQvjAjThW9Ua7PGqE0j53"
  let GTAppKey = "W7Lwh5PXey9GJSkf1BZA35"
  let GTAppSecret = "KbP0bCclmW5RZTGHGga012"

//友盟
let UMeng_AppKey = "5b176934b27b0a45ab00013e"
/*
 *  服务器的路径
 */
// 正式服务器
let WDB_ServerUrl_Dis = ""
//测试服务器
let WDB_ServerUrl = "https://www.happygets.com"
//let WDB_ServerUrl = "http://192.168.31.14"
//let WDB_ServerUrl = "http://192.168.31.225"



