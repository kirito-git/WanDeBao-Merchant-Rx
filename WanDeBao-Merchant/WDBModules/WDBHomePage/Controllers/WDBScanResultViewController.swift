//
//  WDBScanResultViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/4.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

class WDBScanResultViewController: UIViewController {

    var scanResultString:String?
    var viewModel = WDBScanResultViewModel()
    var discountId = ""
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var discountName: UILabel!
    @IBOutlet weak var statusLab: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "销券信息"
        setUpScanResultData()
    }
    
    func bindDiscountViewModel() {
        
        SVProgressHUD.show(withStatus: "加载中...")
        //请求优惠券详情
        let params = ["userDiscountid":discountId]
        _ = viewModel.getDiscountInfo(dic: params).subscribe(onNext: { (dModel) in
            //获取到优惠券详情
            self.discountName.text = dModel.userDiscount?.discountName ?? ""
            let nowDateTimeStamp = Date.init().timeIntervalSince1970
            self.timeLab.text =  DateFormatTool.dateStringFromTimestamp(type: DateStringType.yMd, timestamp: Double(nowDateTimeStamp))
            
            let userid = String(describing: dModel.userDiscount?.userId ?? 0)
            let userparams = ["userId":userid]
            //请求用户信息
            _ = self.viewModel.getDiscountOwnerUserInfo(dic: userparams).subscribe(onNext: { (uModel) in
                //获取到用户信息
                print(uModel)
                
                if let userInfo = uModel as? [String : Any] {
                    
                    self.userIcon.kf.setImage(with: URL.init(string: userInfo["imageurl"] as! String), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
                    self.userName.text = (userInfo["username"] as! String)
                    
                }
                
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            //请求销券
            self.bindCheckDiscountViewModel(userid: userid)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    //销券
    func bindCheckDiscountViewModel(userid:String) {
        let params = ["userId":userid,"userDiscountid":discountId]
        _ = viewModel.checkDiscount(dic: params).subscribe(onNext: { (response) in
            print(response)
            let respData:[String:Any] = response as! [String:Any]
            if respData["error_mesg"] == nil {
                //成功
                //销券成功
                SVProgressHUD.showSuccess(withStatus: "销券成功！")
                self.statusLab.text = "已销券"
            }else {
                let msg = respData["error_mesg"] ?? ""
                
                SVProgressHUD.showError(withStatus: msg as! String)
                self.statusLab.text = "销券失败"
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func setUpScanResultData() {
        if let resultStr = scanResultString {
            let resultStr1 = resultStr.replacingOccurrences(of: "/", with: "")
            let resultArray = resultStr1.components(separatedBy: "?")
            if resultArray[0] == "userdiscount" {
                let resultStr2 = resultArray[1]
                let resultArray2 = resultStr2.components(separatedBy: "=")
                let discountid = resultArray2[1]
                print("终于拿到了======")
                print(discountid)
                discountId = discountid
                bindDiscountViewModel()
            }else {
                SVProgressHUD.showError(withStatus: "暂不支持此类型的扫码！")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
                    {
                        self.navigationController?.popToRootViewController(animated: true)
                })
            }
            
        } else {
            SVProgressHUD.showError(withStatus: "扫码有误，请重新扫描！")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
                {
                   self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
