//
//  WDBSettingViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/19.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBSettingViewController: WDBBaseViewController {
    
    @IBOutlet weak var messageNoticeLabel: UILabel!
    @IBOutlet weak var setTurnoverLabel: UILabel!
    var viewModel = WDBTurnoverSetViewModel()
    
    @IBOutlet weak var setTurnoverSwitch: UISwitch!
    
    @IBOutlet weak var loginOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        
        self.loginOutBtn.layer.cornerRadius = 5
        self.loginOutBtn.layer.masksToBounds = true
        self.messageNoticeLabel.textColor = UIColor.lightGray
    }

    
    @IBAction func loginOutAction(_ sender: UIButton) {
        let loginVC = WDBLoginViewController();
        let navi = WDBNavigationController.init(rootViewController: loginVC)
        UIApplication.shared.keyWindow?.rootViewController = navi;
        WDBGlobalDataUserDefaults.saveToken(token: "")
        WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: "")
    }
    
    
    //是否开启
    @IBAction func setIsMessageNoticeAction(_ sender: Any) {
        let switchBtn: UISwitch = sender as! UISwitch
        let isButtonOn = switchBtn.isOn
        if isButtonOn {
             self.messageNoticeLabel.textColor = UIColor.black
        }else {
             self.messageNoticeLabel.textColor = UIColor.lightGray
        }
    }
    
   //是否设置推广模式
    @IBAction func setTuroverStyleAction(_ sender: Any) {
        let switchBtn: UISwitch = sender as! UISwitch
        let isButtonOn = switchBtn.isOn
        var patternType = "2"
        if isButtonOn {
            //打开
            self.setTurnoverLabel.textColor = UIColor.black
            patternType = "0"
        }else {
            //关闭
            self.setTurnoverLabel.textColor = UIColor.lightGray
            patternType = "2"
        }
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        
     _ = viewModel.setTurnoverType(shopId: shopId, pattern: patternType).subscribe(onNext: { [weak self](response) in
            print(response)
            //设置成功之后本地保存翻桌率模式
     if let responseDic = response as? [String:Any], let errorMesg = responseDic["error_mesg"] {
        //未到冷却时间切换模式
            if patternType == "2" {
               switchBtn.isOn = true
                self?.setTurnoverLabel.textColor = UIColor.black
            }
            if patternType == "0" {
               switchBtn.isOn = false
                self?.setTurnoverLabel.textColor = UIColor.lightGray
            }
        }else {
             //翻桌率保存在本地
          WDBGlobalDataUserDefaults.saveShopTurnoverType(patternType: patternType)
        }
        
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
          let shopTurnoverType = WDBGlobalDataUserDefaults.getShopTurnoverType()
          if shopTurnoverType == "0" {
            self.setTurnoverSwitch.isOn = true
            self.setTurnoverLabel.textColor = UIColor.black
           }
          if shopTurnoverType == "2" {
            self.setTurnoverSwitch.isOn = false
            self.setTurnoverLabel.textColor = UIColor.lightGray
           }
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
