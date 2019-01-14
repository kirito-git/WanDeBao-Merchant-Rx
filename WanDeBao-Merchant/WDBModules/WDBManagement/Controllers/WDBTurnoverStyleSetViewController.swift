//
//  WDBTurnoverStyleSetViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import SwiftyJSON

class WDBTurnoverStyleSetViewController: UIViewController ,NearbyViewcontrollerDelegate {
    
    var viewModel:WDBTurnoverDiscountManageViewModel!
    var turnoverStyleSetView:WDBTurnoverStyleSetView!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置翻桌率模式"
        
        turnoverStyleSetView = WDBTurnoverStyleSetView.init(frame: self.view.frame)
        self.view.addSubview(turnoverStyleSetView)
        tableView = turnoverStyleSetView.gameTableView
        
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel = WDBTurnoverDiscountManageViewModel()
        
        _ = self.turnoverStyleSetView.priceTf.rx.textInput <-> viewModel.price
        _ = self.turnoverStyleSetView.timeTf.rx.textInput <-> viewModel.times
        
        //绑定tableview
        _ = self.viewModel.choseStoreList.bind(to: tableView.rx.items){(tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBTurnoverStyleSetCell") as! WDBTurnoverStyleSetCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            cell.storeNameLab.text = model.shopName
            return cell
        }
        
        //选择店铺点击
        _ = turnoverStyleSetView.choseStoreButton.rx.tap.subscribe(onNext: {
            let nearbyVC = WDBNearbyShopViewController()
            nearbyVC.delegate = self
            self.navigationController?.pushViewController(nearbyVC, animated: true)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        //确定点击
        //创建翻桌率请求
        _ = turnoverStyleSetView.bottomView.rx.tap
            //0.1秒内只取最后一次操作
            .throttle(0.1, scheduler: MainScheduler.instance)
            .do(onNext:{self.view.endEditing(true)})
            .withLatestFrom(viewModel.confirmVaild.asObservable())
            .filter{ [unowned self] vaild in
                print(vaild)
                if !vaild {
                    self.successAlert(tips: "金额、有效期以及店铺不能为空！")
                }
                return vaild
            }
            .flatMapLatest{ [unowned self]_ in
                self.viewModel.createTurnoverDiscount()
            }
            .subscribe(onNext:{ response in
                if (response is Int) {
                    self.successAlert(tips: "创建成功！")
                }else {
                    let resp:[String:Any] = response as! [String : Any]
                    self.successAlert(tips: resp["error_mesg"] as! String)
                }
            })
    }
    
    //NearbyViewcontroller delegate
    func shopSelected(shops: ([WDBShopModel], String)) {
        let shopids = shops.1
        viewModel.toshopIds.value = shopids
        viewModel.choseStoreList.accept(shops.0)
        turnoverStyleSetView.gameTableView.reloadData()
    }
    
    func successAlert(tips:String) {
        navigator.open(NavigatorURLAlert + "/?title=提示&message=\(tips)")
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
