//
//  WDBBaseViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

class WDBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = APP_BK_COLOR

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navCount:Int! = self.navigationController?.viewControllers.count
        if (navCount > 1) {
            self.hidesBottomBarWhenPushed = true
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.backBarButtonItem = item
        }else{
            
        }
        
        //友盟统计页面
        let cvName:AnyClass = self.classForCoder
        let nameStr = String(describing: cvName)
        MobClick.beginLogPageView(nameStr)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //友盟统计页面
        let cvName:AnyClass = self.classForCoder
        let nameStr = String(describing: cvName)
        MobClick.endLogPageView(nameStr)
        SVProgressHUD.dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
