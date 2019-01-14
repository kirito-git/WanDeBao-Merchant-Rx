//
//  WDBGameManageViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import MJRefresh

class WDBGameManageViewController: WDBBaseViewController {

    var gameManageView:WDBGameManageView!
    var viewModel:WDBGameManageViewModel!
    var tableView:UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "游戏管理"
        setupSubviews()
        bindViewModel()
    }
    
    func setupSubviews() {
        gameManageView = WDBGameManageView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT))
        self.view.addSubview(gameManageView)
        self.tableView = gameManageView.tableView
        
        //设置头部刷新控件
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        headerRefresh.stateLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    func bindViewModel() {
        
        viewModel = WDBGameManageViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //tableview绑定dataSourse
        let dataSourse = RxTableViewSectionedReloadDataSource<GameManageSection>(
            //设置单元格
            configureCell: { (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "WDBGameManageCell", for: indexPath) as! WDBGameManageCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.gameNameLab.text = element.wdbGame?.gameName ?? ""
                return cell
            }
        )
        
        viewModel.gameList
            .bind(to: tableView.rx.items(dataSource: dataSourse))
            .disposed(by: disposeBag)
        
        //绑定停止刷新
        _ = viewModel.endHeaderRefresh
            .drive(self.tableView.mj_header.rx.endRefreshing)
        
        //点击添加游戏
        _ = gameManageView.bottomView.rx.tap.subscribe(onNext: {
            navigator.push(NavigatorURLGameAdd)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
        
    func setupRefresh() {
        //设置头部刷新控件
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        headerRefresh.stateLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
