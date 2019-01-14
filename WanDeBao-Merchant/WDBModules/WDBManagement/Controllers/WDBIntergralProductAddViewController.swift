//
//  WDBIntergralProductAddViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
import RxSwift
import RxCocoa
import RxDataSources

class WDBIntergralProductAddViewController: UIViewController ,UITableViewDelegate {

    var alertView:WDBDiscountIntegralExchangeAlert!
    var discountViewModel:WDBDiscountManageViewModel!
    var viewModel:WDBIntergralAddViewModel!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "积分商品添加"
        setupSubViews()
        bindViewModel()
    }
    
    func setupSubViews() {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-64)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 100
        tableView.sectionHeaderHeight = 10
        tableView.register(WDBDiscountCell.self, forCellReuseIdentifier: "WDBDiscountCell")
        tableView.tableHeaderView = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:10))
        self.view.addSubview(tableView)
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    func bindViewModel() {
        viewModel = WDBIntergralAddViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //绑定tableView
        _ = viewModel.discountList.bind(to: self.tableView.rx.items){ (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBDiscountCell") as! WDBDiscountCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            cell.typeLab.text = model.discount?.typeName
            cell.titleLab.text = model.discount?.discountName ?? ""
            cell.limitDate.text = model.discount?.limitDay
            cell.limitNum.text = "发放\(String(model.conditionList?.number ?? 0))张／天"
            cell.selectButton.isHidden = false
            return cell
        }
        
        //cell选择
        _ = self.tableView.rx.itemSelected.subscribe(onNext:{ indexPath in
            let discountModel = self.viewModel.discountList.value[indexPath.row]
            self.showIntergralChoseAlert(choseModel: discountModel)
        })
        
        //停止刷新
        _ = self.viewModel.endRefresh.drive(self.tableView.mj_header.rx.endRefreshing)
        
    }
    
    func showIntergralChoseAlert(choseModel: WDBDiscountModel) {
        alertView = WDBDiscountIntegralExchangeAlert.init(frame: self.view.bounds)
        alertView.dataArray = self.viewModel.intergrals.value
        alertView.cancelClickBlock = {
            self.alertView.removeFromSuperview()
        }
        //点击确定
        alertView.okClickBlock = {(model : WDBIntergralModel) in
            _ = self.viewModel.intergralProductAdd(intergral: model, choseModel: choseModel)
                .subscribe(onNext: { (response) in
                    print(response)
                    SVProgressHUD.showSuccess(withStatus: "添加成功！")
                    self.alertView.removeFromSuperview()
                    //添加完成
                    self.navigationController?.popViewController(animated: true)
                }, onError: { (error) in
                    print(error)
                    self.alertView.removeFromSuperview()
                }, onCompleted: nil, onDisposed: nil)
        }
        self.view.addSubview(alertView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
