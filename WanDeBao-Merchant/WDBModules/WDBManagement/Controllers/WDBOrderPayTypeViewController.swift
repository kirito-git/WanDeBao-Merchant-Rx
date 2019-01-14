//
//  WDBOrderPayTypeViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

class WDBOrderPayTypeViewController: UIViewController ,OrderPayFinishDelegate{
    

    //声明元组传递参数
    var tupleData:(products:[WDBProductModel],orderModel:WDBOrderModel)!
    var viewModel = WDBOrderPayTypeViewModel()
    var orderPayTypeView:WDBOrderPayTypeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单支付"
//        print(tupleData.products)
        
        //判断是否安装了微信或者支付宝
        viewModel.isInstallWXOrAlipay()
        
        orderPayTypeView = WDBOrderPayTypeView.init(frame: self.view.frame)
        orderPayTypeView.orderModel = tupleData.orderModel
        orderPayTypeView.products = tupleData.products
        orderPayTypeView.viewModel = viewModel
        self.view.addSubview(orderPayTypeView)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        myAppDelegate.orderPayDelegate = self
        
        bindPayButtonSelect()
    }
    
    func bindPayButtonSelect() {
        //去支付
        _ = orderPayTypeView.confirmButton.rx.tap.subscribe(onNext: {
            
            if (self.viewModel.payChannel == "WX_APP") && (!self.viewModel.isInstallWX) {
                SVProgressHUD.showError(withStatus: "请安装微信或选择其他支付方式进行支付！")
                return
            }
            
            //支付接口
            let orderPayid = String(describing: self.tupleData.orderModel.orderPay?.id ?? 0)
            let paytype = self.viewModel.payType.rawValue
            let paychannel = self.viewModel.payChannel
            print("点击了支付，orderpayid=\(orderPayid)")
            print(paytype)
            WDBPayViewModel.shared.startOrderPayWith(orderPayId:orderPayid, payType:WDBPayType(rawValue: paytype)!, payChannel: paychannel, mchId: "100001")
            
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    //支付完成回掉
    func orderPayFinish(With payType: WDBPayType, isSuccess: Bool, respMsg: String) {
        
        let tips = respMsg
//        let alertVC = UIAlertController.init(title: "提示", message: tips, preferredStyle: UIAlertControllerStyle.alert)
//        alertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
            if isSuccess {
                //支付成功  返回游戏列表页
                for controller in (self.navigationController?.viewControllers)! {
                    if controller.isKind(of: WDBGameManageViewController.classForCoder()) {
                        navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=\(tips)&isBack=true",context: controller)
                        break
                    }
                }
            }else {
                //支付失败 用户返回上页面重新下单
                self.navigationController?.popViewController(animated: true)
            }
            
//        }))
//        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
