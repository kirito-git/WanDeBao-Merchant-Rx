//
//  WDBTurnoverSetViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBTurnoverSetViewController: UIViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var turnoverSwitch: UIButton!
    @IBOutlet weak var turnoverView: UIView!
    
    var viewModel = WDBTurnoverSetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置翻桌率／推广模式"
        
        mySwitch.isOn = false
        turnoverView.isHidden = !mySwitch.isOn
        turnoverSwitch.setImage(UIImage.init(named: "manage_turnrate_mode"), for: UIControlState.normal)
        turnoverSwitch.setImage(UIImage.init(named: "manage_expand_mode"), for: UIControlState.selected)
    }

    //switch切换
    @IBAction func mySwitchChanged(_ sender: UISwitch) {
        turnoverView.isHidden = !sender.isOn
        viewModel.switchValueChanged(isOn: sender.isOn)
    }
    
    @IBAction func turnoverClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.turnoverSwitchClick(isSelect: sender.isSelected)
    }
    
    //翻桌率选择
    @IBAction func confirmClick(_ sender: Any) {
        
        if  mySwitch.isOn == false {
            self.showAlert(message: "请开启优化店铺运营！")
            return;
        }
        
        let pattern:String = viewModel.pattern
        let shopId:String = WDBGlobalDataUserDefaults.getShopID()
        //print(pattern)
        _ = viewModel.setTurnoverType(shopId: shopId, pattern: pattern).subscribe(onNext: { (response) in
            print(response)
            let respData:[String:Any] = response as! [String:Any]
            if respData["error_mesg"] == nil {
                //成功
                //设置成功之后本地保存翻桌率模式
                WDBGlobalDataUserDefaults.saveShopTurnoverType(patternType: pattern)
                self.showAlert(message: "切换成功！")
            }else {
                //失败
                self.showAlert(message: respData["error_mesg"] as! String)
                let shopType = WDBGlobalDataUserDefaults.getShopTurnoverType()
                self.turnoverSwitch.isSelected = (shopType == "0") ? false : true
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func showAlert(message:String) {
//        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
         navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=\(message)")
//        }))
//        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
