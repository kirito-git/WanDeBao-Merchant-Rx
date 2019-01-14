//
//  WDBAccountFundViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ESPullToRefresh
import SwiftyJSON
import SVProgressHUD

class WDBAccountFundViewController: WDBBaseViewController {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var onlineIncomLabel: UILabel!
    @IBOutlet weak var promotionCostLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomTipLabel: UILabel!
    
    @IBOutlet weak var tipLabelBottomValue: NSLayoutConstraint!
    
    var viewModel: WDBMineViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "账户资金"
        self.view.backgroundColor = UIColor.white
        viewModel = WDBMineViewModel()
        //self.setupRefreshView()
        setupSubviews()
      // Do any additional setup after loading the view.
        self.tipLabelBottomValue.constant = iPhoneXBottomBarH
    }
    
    func setupSubviews() {
        
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFontWithSize(size: 16)]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
        self.bgView.backgroundColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
        self.bottomTipLabel.textColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
        
        let shopAccount = WDBGlobalDataUserDefaults.getShopAccount()
        self.totalAmountLabel.text = String(format:"%g",shopAccount)
    }
    
    @IBAction func withdrawAction(_ sender: UIButton) {
           YBProgressHUD.showTipMessage(text: "该功能暂无开放")
//         let  withdrawVC = WDBBalanceWithdrawViewController.init(nibName: "WDBBalanceWithdrawViewController", bundle: nil)
//         self.navigationController?.pushViewController(withdrawVC, animated: true)
    }
    
    
    @IBAction func rechargeAction(_ sender: UIButton) {
        

        if !UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!) && !WXApi.isWXAppInstalled() {
             YBProgressHUD.showTipMessage(text: "请先安装微信和支付宝")
             return
        }
        navigator.push(NavigatorURLRecharge)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.getAccountDetail()
    }
    
    
    func getAccountDetail() {
        
        _ = self.viewModel?.getOnlineMoneyAndPromotionMoney().subscribe(onNext: { (response) in
            print(response)
            
            if let dict = response as? [String:Any] {
                let onlineIncome = dict["totalPaySum"] as? Double ?? 0.00
                let proxyPaySum = dict["proxyPaySum"] as? Double ?? 0.00
                self.onlineIncomLabel.text = String(describing:onlineIncome)
                self.promotionCostLabel.text = String(describing:proxyPaySum)
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
