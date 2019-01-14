//
//  WDBNearbyShopViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol NearbyViewcontrollerDelegate: NSObjectProtocol {
    func shopSelected(shops:([WDBShopModel],String))
}

class WDBNearbyShopViewController: UIViewController {

    var delegate:NearbyViewcontrollerDelegate!
    var viewModel = WDBNearbyShopViewModel()
    var nearbyStoreView:WDBNearbyShopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "附近店铺"
        nearbyStoreView = WDBNearbyShopView.init(frame: self.view.frame)
        nearbyStoreView.viewModel = viewModel
        self.view.addSubview(nearbyStoreView)
        
        //点击了确定
        _ = nearbyStoreView.confirmButton.rx.tap.subscribe(onNext: {
            let tuple:([WDBShopModel],String)  = self.viewModel.getChoseData()
            if tuple.0.count > 0 {
                //调用代理方法
                self.delegate.shopSelected(shops: tuple)
                self.navigationController?.popViewController(animated: true)
            }else {
                //未选中任何商铺
                self.successAlert()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        let shopid:String = WDBGlobalDataUserDefaults.getShopID()
        let parmas = ["shopId":shopid,"page":"1","size":"100","dist":"7000"]
        _ = viewModel.nearbyShopList(dic: parmas).subscribe(onNext: { (array) in
                    
            self.viewModel.initMarkArray(originArray: array)
            self.nearbyStoreView.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    func successAlert() {
        let alert = UIAlertController.init(title: "提示", message: "请至少选择一个商铺！", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "知道了", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 255, G: 155, B: 115, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
