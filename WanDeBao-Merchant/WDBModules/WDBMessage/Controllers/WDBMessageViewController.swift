//
//  WDBMessageViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh

class WDBMessageViewController: WDBBaseViewController {

    var wdbView:WDBMessageView!
    var viewModel:WDBMessageViewModel!
    var tableView:UITableView!
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        bindViwModel()
    }
    
    func setupSubviews() {
        wdbView = WDBMessageView.init(frame: self.view.frame)
        self.view.addSubview(wdbView)
        self.tableView = wdbView.tableView
        
        //初始化mjRefresh
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    func bindViwModel() {
        viewModel = WDBMessageViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //绑定tableview
        _ = viewModel.dataArray.bind(to: tableView.rx.items){(tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBMessageCell") as! UITableViewCell as! WDBMessageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            cell.titleLab.text = model.title ?? ""
            cell.detailLab.text = model.content ?? ""
            cell.timeLab.text = model.createTimeString ?? ""
            return cell
        }
        
        //tableview点击 获取选中项的内容
        tableView.rx.modelSelected(WDBMessageModel.self).subscribe(onNext: { item in
            let modelStr = item.toJSONString() ?? ""
            navigator.push(NavigatorURLMessageDetail + "/" + modelStr)
        }).disposed(by: disposeBag)
        
        //绑定停止刷新
        _ = self.viewModel.endRefresh.drive(self.tableView.mj_header.rx.endRefreshing)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
