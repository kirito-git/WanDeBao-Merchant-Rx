//
//  WDBShopBillViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import Kingfisher


class WDBShopBillViewController: WDBBaseViewController {

    var viewModel:WDBShopBillViewModel!
    var shopbillView:WDBShopBillView!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账单"
        setupSubviews()
        bindViewModel()
    }
    
    func setupSubviews() {
        shopbillView = WDBShopBillView.init(frame: self.view.frame)
        self.view.addSubview(shopbillView)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)]
        tableView = shopbillView.tableView
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    func bindViewModel() {
        viewModel = WDBShopBillViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        _ = viewModel.endRefresh.asObservable().bind(to: self.tableView.mj_header.rx.endRefreshing)
        
        _ = viewModel.billList.bind(to: self.tableView.rx.items){(tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBShopBillCell") as! WDBShopBillCell
            let model = element
            cell.headImg.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: model.imageurl ?? "")! as URL), placeholder: UIImage.init(named: "tabbar_mine_normal.png"), options: nil, progressBlock: nil, completionHandler: nil)
            cell.nameLab.text = model.displayname ?? ""
            cell.discountLab.text = model.discountName![0]
            cell.shouldPayLab.text = "应付：\(String(describing: model.totalSum ?? 0))"
            cell.timeLab.text = model.timeName
            cell.factPayLab.text = "线上支付\(String(describing: model.paySum ?? 0))"
            return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
