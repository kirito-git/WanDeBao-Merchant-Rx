//
//  WDBSubmitInfoViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBSubmitInfoViewController: WDBBaseViewController {
    
    @IBOutlet weak var uploadBusinessLicenseBtn: UIButton!
    @IBOutlet weak var uploadCateringServiceLicenseBtn: UIButton!
    @IBOutlet weak var uploadFoodSafetyNotice: UIButton!
    
    @IBOutlet weak var sumitInfoBtn: UIButton!
    
     public var authenticationInfoDic: [String:Any] = [String:Any]()
     lazy var viewModel = WDBRegisterStoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "提交资质"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadBusinessLicenseAction(_ sender: UIButton) {
        
        YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) {[weak self] (image, imageUrl) in
             print("哈哈哈哈\(image),\(imageUrl)")
            DispatchQueue.main.async(execute: {
               self?.uploadBusinessLicenseBtn.setImage(image, for: .normal)
            })
             self?.authenticationInfoDic["businessUrl"] = imageUrl
        }
        
    }
    
    
    @IBAction func uploadCateringServiceLicenseAction(_ sender: UIButton) {
        YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) {[weak self] (image, imageUrl) in
            print("哈哈哈哈\(image),\(imageUrl)")
            DispatchQueue.main.async(execute: {
                 self?.uploadCateringServiceLicenseBtn.setImage(image, for: .normal)
            })
            
            self?.authenticationInfoDic["diningCicenceUrl"] = imageUrl
        }
    }
    
    @IBAction func uploadFoodSafetyNoticeAction(_ sender: UIButton) {
        YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) {[weak self] (image, imageUrl) in
            print("哈哈哈哈\(image),\(imageUrl)")
            DispatchQueue.main.async(execute: {
                  self?.uploadFoodSafetyNotice.setImage(image, for: .normal)
            })
            self?.authenticationInfoDic["diningSecurityUrl"] = imageUrl
        }
    }
    
    @IBAction func submitCertifyInfoAction(_ sender: UIButton) {
        
        authenticationInfoDic["userId"] = WDBGlobalDataUserDefaults.getID()
        authenticationInfoDic["shopType"] = "0"
        
        //检查信息是否符合规范
        //checkInfoValide()
        let businessUrl = authenticationInfoDic["businessUrl"] as? String
        if businessUrl == nil {
            YBProgressHUD.showTipMessage(text: "请选择上传营业执照")
            return
        }
        
        let diningCicenceUrl = authenticationInfoDic["diningCicenceUrl"] as? String
        if diningCicenceUrl == nil {
            YBProgressHUD.showTipMessage(text: "请选择上传餐饮服务许可证")
            return
        }
        
        let diningSecurityUrl = authenticationInfoDic["diningSecurityUrl"] as? String
        if diningSecurityUrl == nil {
            YBProgressHUD.showTipMessage(text: "请选择上传餐饮服务食品安全监督信息公告")
            return
        }
        
        _ = viewModel.registerStore(paramDic: authenticationInfoDic).subscribe(onNext: {(response) in
            navigator.push(NavigatorURLSubmitInfoResult)
        }, onError: { (error) in
            print("hyhyyyy\(error)")
        }, onCompleted: nil, onDisposed: nil)
        
    }
    
    func checkInfoValide() {
        
        
        
        
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
