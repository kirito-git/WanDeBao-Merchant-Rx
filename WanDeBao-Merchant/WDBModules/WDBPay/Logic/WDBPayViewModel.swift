//
//  WDBPayViewModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/4.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import Moya

enum WDBPayType:String {
    case alipay = "300"//支付宝支付
    case wxpay =  "400"//微信支付
    case llpay = "llpay"//连连快捷支付
}

enum WDBPayChannel:String {
    case aliPay = "ALIPAY_MOBILE"
    case wxpay = "WX_APP"
}

class WDBPayViewModel: NSObject {
    
    public static let shared = WDBPayViewModel()
    
  //开始发起支付
   func startOrderPayWith(orderPayId:String, payType:WDBPayType, payChannel:String, mchId:String) {
    
    //支付接口请求
    let paramDic = ["orderPayId":orderPayId, "payType":String(format:"%@",payType.rawValue), "payChannel":payChannel, "mchId":mchId] as [String:String]
    print(paramDic)
    _ = getOrderPayParamInfo(paramDic: paramDic).subscribe(onNext: { (orderPayParamInfo) in
        
        if orderPayParamInfo.isOtherPay == 0 {
            //无需支付 添加成功
            print("购买成功===金额0")
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess:true ,respMsg: "选购成功！")
            
        }else if orderPayParamInfo.isOtherPay == 1 {
            //调用支付SDK
            self.callSDKPay(orderPayParamInfo: orderPayParamInfo, payType: payType, orderPayId: orderPayId)
        }
    }, onError: nil, onCompleted: nil, onDisposed: nil)
    
    
}
    
  //获取支付的参数信息
    func getOrderPayParamInfo(paramDic:[String:Any]!) -> Observable<WDBOrderPayParamInfo>  {
        return defaultProvider.rx.request(MultiTarget(WDBApiPay.orderPay(dict: paramDic)))
            .filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBOrderPayParamInfo.self).retry(2)
    }

  //调用SDK发起支付
    func callSDKPay(orderPayParamInfo: WDBOrderPayParamInfo, payType:WDBPayType, orderPayId:String) {
        
        if payType == .alipay {
            //支付宝支付
            AlipaySDK.defaultService().payOrder(orderPayParamInfo.prepayId, fromScheme: Alipay_scheme_wdb, callback: { (resp) in

                if let Alipayjson = resp as? NSDictionary{
                    let resultStatus = Alipayjson.value(forKey: "resultStatus") as! String
                    if resultStatus == "9000"{
                        print("OK")
                        //支付成功
                        print("支付宝支付成功了！！")
                        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                        myAppDelegate.orderPayDelegate?.orderPayFinish(With: .alipay, isSuccess: true,respMsg: "选购成功！")
                    }else if resultStatus == "8000" {
                        print("正在处理中")
                    }else if resultStatus == "4000" {
                        print("订单支付失败");
                    }else if resultStatus == "6001" {
                        print("用户中途取消")
                    }else if resultStatus == "6002" {
                        print("网络连接出错")
                    }
                }
                
            })
            
        }else if payType == .wxpay {
            //微信支付
             let req = PayReq()
             req.partnerId                 = orderPayParamInfo.partnerId ?? ""
             req.prepayId                  = orderPayParamInfo.prepayId ?? ""
             req.nonceStr                  = orderPayParamInfo.nonceStr ?? ""
             req.timeStamp                 = UInt32(orderPayParamInfo.timeStamp!)!
             req.package                   = "Sign=WXPay"
             req.sign                      = orderPayParamInfo.paySign ?? ""
            
            print(orderPayParamInfo.partnerId ?? "")
            print(orderPayParamInfo.prepayId ?? "")
            print(orderPayParamInfo.nonceStr ?? "")
            print(UInt32(orderPayParamInfo.timeStamp!)!)
            print(orderPayParamInfo.paySign ?? "")
            
          //发起支付
          let isSuccess = WXApi.send(req)
           /**
            在此处做个记录，记录是否从微信支付界面返回app,因为如果直接点击左上角的返回的话，不会走微信的回调方法
           */
            print("wechat-sendRequset *****************************************")
            
            UserDefaults.standard.set(true, forKey: "isBackToAppFromWechatPayPage")
        }
    }
    
    
    //调用连连支付提供的接口
    func callLLPaySDK(model:WDBLLPayRechargeModel,price:Float,viewcontroller:UIViewController) {
        
        //创建连连支付订单
        let paymentInfoNotSigned = self.createLLPayOrder(model: model,price: price)
        //签名操作
        let signUtil = LLPayUtil()
        signUtil.signKeyArray = nil
        let traderInfo = signUtil.signedOrderDic(paymentInfoNotSigned, andSignKey: LLPayPartnerPrviteKey)
        //LLPaySDK设置代理
        LLPaySdk.shared().sdkDelegate = viewcontroller as! LLPaySdkDelegate
        //跳转连连支付页面
        LLPaySdk.shared().present(in: viewcontroller, with: LLPayType.quick, andTraderInfo: traderInfo)
    }
    
    //连连支付订单生成
    func createLLPayOrder(model:WDBLLPayRechargeModel,price:Float) -> [String:Any] {
        
        var orderParams = [String:Any]()
        let llpayTimestamp = LLPayTool.timeStamp()
        orderParams["user_id"] = String(describing: model.userId ?? 0)
        orderParams["oid_partner"] = "201807170002041117" //商户号
        orderParams["sign_type"] = "RSA"
        orderParams["busi_partner"] = "101001" //商品类型
        orderParams["no_order"] = model.cashCode ?? "" //订单号
        orderParams["dt_order"] = llpayTimestamp //订单时间
        orderParams["money_order"] = "\(price)" //订单价格
        orderParams["notify_url"] = model.chargeNotifyUrl ?? "" //回掉地址
        orderParams["risk_item"] = self.getRiskParam() //风控参数
        orderParams["name_goods"] = model.payTypeDesc ?? "" //商品名
        orderParams["card_no"] = model.cachBankcard ?? "" //银行卡号
        orderParams["valid_order"] = "30"
        print("连连支付订单==========================================")
        print(orderParams)
        return orderParams
    }
    
    func getRiskParam() -> String {
        var params = [String:Any]()
        params["user_info_bind_phone"] = "18292889097"
        params["frms_ware_category"] = "1002"
        params["user_info_dt_registe"] = "20180725000000"
        params["user_info_mercht_userno"] = WDBGlobalDataUserDefaults.getID()
        
        return LLPayUtil.jsonString(ofObj: params) //风控参数
    }
    
    
    
}

