//
//  WDBSubmitInfoResultViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

public enum WDBRegisterStoreCheckStatus: String {
    case unSubmit = "-1"
    case alreadySubmit = "0"
    case checkedSuccess = "1"
    case checkedFailure = "2"
}


class WDBSubmitInfoResultViewController: WDBBaseViewController {

    @IBOutlet weak var tipStatusImgView: UIImageView!
    
    @IBOutlet weak var tipStatusLabel: UILabel!
    
    @IBOutlet weak var tipDetailLabel: UILabel!
    
    public var checkStatus: WDBRegisterStoreCheckStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "审核结果"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if checkStatus == WDBRegisterStoreCheckStatus.checkedFailure {
            tipStatusImgView.image = UIImage.init(named: "login_checkfailure")
            tipStatusLabel.text = "审核失败"
            tipDetailLabel.text = "请重新提交审核"
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: ""), style: .plain, target: self, action: #selector(leftBarAction))
    }
    
    @objc func leftBarAction() {
        
      }

    @IBAction func backToLoginViewAction(_ sender: UIButton) {
         WDBCommonHelper.shared.goBackLoginPage()
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
