//
//  WDBDiscountIntegralExchangeViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

class WDBDiscountIntegralExchangeViewController: UIViewController {

    var viewModel:WDBDiscountIntegralExchangeViewModel!
    var discountView:WDBDiscountIntegralExchangeView!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "积分商品管理"
        setupSubviews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.viewModel.isViewDidLoad.value == true {
            //刷新一次请求
            self.viewModel.refreshRequest.onNext(())
        }
    }
    
    func setupSubviews() {
        discountView = WDBDiscountIntegralExchangeView.init(frame: self.view.frame)
        self.view.addSubview(discountView)
        self.tableView = discountView.tableView
        self.tableView.rx.setDelegate(self as! UIScrollViewDelegate)
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    func bindViewModel() {
        
        viewModel = WDBDiscountIntegralExchangeViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //MV绑定tableview
        _ = viewModel.intergralList.bind(to: self.tableView.rx.items){ (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBDiscountCell") as! WDBDiscountCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            let times = model.times ?? 0
            let timesStr = times == 0 ? "永久有效" : "有效期\(String(describing:times))分钟"
            let limNumStr = (model.number ?? 0) > 999 ? "发放999+张" : "发放\(String(model.number ?? 0))张／天"
            cell.typeLab.text = model.discountTypeName
            cell.titleLab.text = model.name
            cell.limitDate.text = timesStr
            cell.limitNum.text = limNumStr
            cell.intergralLab.isHidden = false
            cell.intergralLab.text = "\(String(describing:model.point ?? 0))积分"
            return cell
        }
        
        //删除单元格
        _ = tableView.rx.itemDeleted.subscribe(onNext:{ indexPath in
            _ = self.viewModel.deleteIntergralProduct(row:indexPath.row)
                .subscribe{
                    //请求成功  删除单元格
                    var items = self.viewModel.intergralList.value
                    items.remove(at: indexPath.row)
                    self.viewModel.intergralList.accept(items)
                }
        })
        
        //绑定switch切换
        _ = discountView.switchView.rx.controlEvent(UIControlEvents.valueChanged)
            .flatMapLatest{self.viewModel.intergralExchangeOpen()}
            .subscribe(onNext:{_ in
                //设置table的高度
                self.tableView.frame = CGRect(x:0,y:50,width:SCREEN_WIDTH,height:self.viewModel.tableHeight.value)
            })
        
        //绑定switch开关状态
        _ = self.viewModel.openExchange.asObservable()
            .bind(to: discountView.switchView.rx.isOn)
        
        //绑定添加按钮根据开关状态显示隐藏
        _ = self.viewModel.openExchange.asObservable()
            .map{!$0}
            .bind(to: discountView.bottomView.rx.isHidden)
        
        _ = viewModel.endRefresh.drive(self.tableView.mj_header.rx.endRefreshing)
        
        _ = discountView.bottomView.rx.tap .subscribe(onNext: {
            //self.navigationController?.pushViewController(WDBIntergralProductAddViewController(), animated: true)
            navigator.push(NavigatorURLIntegralProductAdd)
            self.viewModel.isViewDidLoad.value = true
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension WDBDiscountIntegralExchangeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}

