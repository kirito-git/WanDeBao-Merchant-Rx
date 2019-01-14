//
//  WDBGameAddViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
import RxSwift
import RxCocoa
import RxDataSources

class WDBGameAddViewController: WDBBaseViewController{

    var wdbGameAddView:WDBGameAddView!
    var tableview:UITableView!
    var viewModel:WDBGameManageAddViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "游戏列表"
        setupSubviews()
        bindViewModel()
    }
    
    func setupSubviews() {
        wdbGameAddView = WDBGameAddView.init(frame: self.view.frame)
        self.view.addSubview(wdbGameAddView)
        self.tableview = wdbGameAddView.gameAddTableView
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableview.mj_header = headerRefresh
    }
    
    func bindViewModel() {
        
        //初始化绑定mjRefresh
        viewModel = WDBGameManageAddViewModel(headerRefresh: self.tableview.mj_header.rx.refreshing.asDriver())
        
        //绑定tableview
        let dataSourse = RxTableViewSectionedReloadDataSource<GameAddSection>(
            //设置单元格
            configureCell: { (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "WDBGameAddCell", for: indexPath) as! WDBGameAddCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model = element
                cell.imageVi.kf.setImage(with: URL.init(string: model.productImgUrl ?? ""), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
                cell.gameNameLab.text = model.name ?? ""
                cell.gameInfoLab.text = model.timesTypeName ?? ""
                cell.selectButton.isSelected = self.viewModel.markArray.value[indexPath.row]
                cell.priceLab.text = "¥\(String(describing: model.price ?? 0))"
                return cell
            }
        )
        _ = self.viewModel.gameSection
        .bind(to: self.tableview.rx.items(dataSource: dataSourse))
        
        //tableView点击
        tableview.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.tableSelect(row: indexPath.row)
        }).disposed(by: disposeBag)
        
        //绑定停止刷新
        self.viewModel.endHeaderRefresh
        .drive(self.tableview.mj_header.rx.endRefreshing)
        .disposed(by: disposeBag)
        
        //绑定确定按钮
        _ = wdbGameAddView.confirmButton.rx.tap
        .throttle(0.1, scheduler: MainScheduler.instance)
        .withLatestFrom(self.viewModel.payVaild)
        .filter({ vaild in
            return true
            if !vaild {
                navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=未安装支付宝或者微信！",context: nil)
            }
            return vaild
        })
        .flatMap{ _ in
            self.viewModel.getProductJson()
        }
        .filter{ vaild in
            if !vaild {
                navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=请先选择商品！",context: nil)
            }
            return vaild
        }
        .flatMapLatest{ _ in
            self.viewModel.gamesAddOrder()
        }
        .subscribe(onNext:{ model in
            print("下单完成！！！！！ orderpayid:",model.orderPay?.id ?? 0)
            //去支付确认
            let products = self.viewModel.selectProducts.value
            let tupleData = (products:products,orderModel:model)
            navigator.push(NavigatorURLOrderPayType, context:tupleData)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

