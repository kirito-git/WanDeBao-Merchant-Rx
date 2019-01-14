//
//  WDBExpandSetViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBExpandSetViewController: WDBBaseViewController {

    var viewModel = WDBGeneralizeAddViewModel()
    var expandSetView:WDBExpandSetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置推广模式"

        expandSetView = WDBExpandSetView.init(frame: self.view.frame)
        self.view.addSubview(expandSetView)
        
        //点击确定  创建推广券
        _ = expandSetView.bottomView.rx.tap.subscribe(onNext: {
            
            let redPacket = self.expandSetView.priceTf.text!
            let shopid = WDBGlobalDataUserDefaults.getShopID()
            let discountName = "推广率折扣券"
            let params = ["shopId":shopid,"redPacket":redPacket,"discountName":discountName,"discountOrder":"1"]
            
            _ = self.viewModel.createGeneralizeDiscount(dic: params).subscribe(onNext: { (response) in
                print(response)
                let respData:[String:Any] = response as! [String:Any]
                if respData["error_mesg"] == nil {
                    //成功
                    self.showAlert(message: "创建成功",isBack: true)
                }else {
                    self.showAlert(message: respData["error_mesg"] as! String,isBack: false)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    func showAlert(message:String, isBack:Bool) {
//        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
//            if isBack == true {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
        navigator.push(NavigatorURLAlert + "?title=提示&message=\(message)&isBack=\(isBack)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
