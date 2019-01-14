//
//  WDBStoreQualificationViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBStoreQualificationViewController: WDBBaseViewController {

    lazy var storeQualificationView = WDBStoreQualificationView()
    var viewModel: WDBMineViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "门店资质"
        self.view.addSubview(storeQualificationView)
        storeQualificationView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        storeQualificationView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 100)
        bindViewModel()
    }

    func bindViewModel() {
        
        viewModel = WDBMineViewModel()
        requestImageFromServer()
    }
    
    func requestImageFromServer() {
        
        _ = viewModel?.getStoreInfo().subscribe(onNext: { [weak self](shopOwnerInfo) in
            //营业执照
            self?.storeQualificationView.businessLicenseBtn.kf.setImage(with: URL.init(string: shopOwnerInfo.businessUrl ?? ""), for: .normal, placeholder: UIImage.init(named: "login_submitinfo_add"), options: nil, progressBlock: nil, completionHandler: nil)
            // 餐饮服务许可证
            self?.storeQualificationView.cateringServiceLicenseBtn.kf.setImage(with: URL.init(string: shopOwnerInfo.diningCicenceUrl ?? ""), for: .normal, placeholder: UIImage.init(named: "login_submitinfo_add"), options: nil, progressBlock: nil, completionHandler: nil)
            //餐饮服务食品安全监督信息
            self?.storeQualificationView.cateringServiceFoodSafetyInfoBtn.kf.setImage(with: URL.init(string: shopOwnerInfo.diningSecurityUrl ?? ""), for: .normal, placeholder: UIImage.init(named: "login_submitinfo_add"), options: nil, progressBlock: nil, completionHandler: nil)
            
            }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         requestImageFromServer()
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
