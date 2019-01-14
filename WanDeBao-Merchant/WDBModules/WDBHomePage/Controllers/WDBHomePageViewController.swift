//
//  WDBHomePageViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import AVFoundation
import swiftScan

class WDBHomePageViewController: WDBBaseViewController {
    
    var homePageView:WDBHomePageView!
    var tableView:UITableView!
    var viewModel:WDBHomePageViewModel!
    var shopSwitchView:WDBShopSwitchView!
    var titleView:WDBSwitchTitleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        setupSubviews() //初始化view
        setUpTitleView() //设置导航标题
        bindViewModel() //绑定VM
        aliyunConfig() //阿里云配置
    }
    
    func bindViewModel() {
        viewModel = WDBHomePageViewModel()
        
        //绑定mjRefresh
        _ = self.tableView.mj_header.rx.refreshing.asDriver()
            .startWith(())
            .flatMapLatest{_ in
                self.viewModel.combineRequest()
            }.drive()
        
        //绑定tableview
        _ = viewModel.homeCellDats.bind(to: self.tableView.rx.items){(tableView,row,element) in
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WDBHomePageCell1") as! WDBHomePageCell1
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                _ = self.viewModel.totalSum.asObservable().bind(to: cell.leftValue.rx.text)
                _ = self.viewModel.orderNumber.asObservable().bind(to: cell.rightValue.rx.text)
                cell.chartView.xDataArray = self.viewModel.chart1Models
                return cell
                
            }else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WDBHomePageCell2") as! WDBHomePageCell2
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.titleLab.text = "奖券发放统计（最近7小时内）"
                cell.chartView.dataTuple = (self.viewModel.recent7Hours.value,self.viewModel.chart2Models)
                return cell
                
            }else if row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WDBHomePageCell3") as! WDBHomePageCell3
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                _ = self.viewModel.allDiscountCount.asObservable().bind(to: cell.contentCellView.sendDNum.rx.text)
                _ = self.viewModel.useDiscountCount.asObservable().bind(to: cell.contentCellView.useDNum.rx.text)
                _ = self.viewModel.oldUser.asObservable().bind(to: cell.contentCellView.CustomerSendNum.rx.text)
                _ = self.viewModel.newUser.asObservable().bind(to: cell.contentCellView.customerUseNum.rx.text)
                return cell
                
            }else if row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WDBHomePageCell4") as! WDBHomePageCell4
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.titleLab.text = "翻桌率统计（昨日）"
                cell.dateLimitLab.text = "时长／订单数"
                cell.chartView.yDataArray = self.viewModel.chart3Models
                return cell
                
            }else if row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WDBHomePageCell3") as! WDBHomePageCell3
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.contentCellView.title1.text = "翻桌券使用分析(昨日)"
                cell.contentCellView.title2.text = "推广分析(昨日)"
                _ = self.viewModel.allDiscountCount5.asObservable().bind(to: cell.contentCellView.sendDNum.rx.text)
                _ = self.viewModel.useDiscountCount5.asObservable().bind(to: cell.contentCellView.useDNum.rx.text)
                _ = self.viewModel.oldUser5.asObservable().bind(to: cell.contentCellView.CustomerSendNum.rx.text)
                _ = self.viewModel.newUser5.asObservable().bind(to: cell.contentCellView.customerUseNum.rx.text)
                return cell
                
            }
            let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell
        }
        
        //停止刷新
        _ = self.viewModel.endRefresh.asObservable()
            .bind(to: self.tableView.mj_header.rx.endRefreshing)
        
        //手册点击跳转
        let openManualTap = UITapGestureRecognizer()
        _ = openManualTap.rx.event
            .subscribe(onNext:{_ in
                navigator.push(NavigatorURLUseManual)
            })
        homePageView.noteView.addGestureRecognizer(openManualTap)
        
        //手册关闭点击
        let closeTap = UITapGestureRecognizer()
        _ = closeTap.rx.event
            .subscribe(onNext:{_ in
                self.tableView.tableHeaderView = UIView()
            })
        homePageView.noteView.closeImage.addGestureRecognizer(closeTap)
        
        //切换店铺按钮点击
        _ = titleView.titleButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest{_ in self.viewModel.userAllShops()}
            .subscribe(onNext:{ [unowned self] items in
                self.showSwitchShopView(datas:items)
            })
    }
    
    //选择商铺
    func showSwitchShopView(datas:[WDBMineShopModel]) {
        if shopSwitchView == nil {
            shopSwitchView = WDBShopSwitchView.init(frame: self.view.bounds)
            shopSwitchView.startAnimation()
            shopSwitchView.dataArray = datas
        }
        
        //取消
        _ = shopSwitchView.cancelButton.rx.tap.subscribe(onNext: {
            self.shopSwitchView.hideSwitchView()
            self.shopSwitchView = nil
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //点击添加店铺
        _ = shopSwitchView.button.rx.tap.subscribe(onNext: {
            self.shopSwitchView.hideSwitchView()
            self.shopSwitchView = nil
           navigator.push(NavigatorURLRegisterStore)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //选择了店铺 重新请求首页数据
        shopSwitchView.switchBlock = {
            self.shopSwitchView = nil
            let shopName = WDBGlobalDataUserDefaults.getShopName()
            self.titleView.titleStr = shopName
            //刷新数据
            self.viewModel.refreshRequest.onNext(())
        }
    }
    
    //初始化tableview
    func setupSubviews() {
        homePageView = WDBHomePageView.init(frame: self.view.frame)
        self.view.addSubview(homePageView)
        self.tableView = homePageView.homeTableView
        self.tableView.rx.setDelegate(self)
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }
    
    //阿里云配置
    func aliyunConfig() {
        //在这里请求更新阿里云信息
        WDBCommonHelper.shared.getOSSInfo()
        //在这里上传clientId
        WDBCommonHelper.shared.uploadClientIdToServer()
    }
    
    //设置导航titleview
    func setUpTitleView() {
        let shopName = WDBGlobalDataUserDefaults.getShopName()

        titleView = WDBSwitchTitleView.init(frame: CGRect.zero)
        titleView.titleStr = shopName
        self.navigationItem.titleView = titleView

        //解决ios11设置导航titleview由于尺寸问题导致按钮不响应事件
        if #available(iOS 11.0, *) {
            titleView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 250, height: 44))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



//tableview-delegate scandelegate
extension WDBHomePageViewController: UITableViewDelegate,LBXScanViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let doubleH:Double! = Double(self.viewModel.cellHeights[indexPath.row])
        let rowH:CGFloat! = CGFloat(doubleH)
        return rowH
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = WDBHomePageButtonsView.init(frame: CGRect.zero)
        //扫描
        _ = sectionView.scanCheckBtn.rx.tap.subscribe(onNext:{_ in
            let vc = LBXScanViewController();
            vc.title = "扫一扫"
            vc.scanResultDelegate = self
            vc.scanStyle = self.homePageView.scanStyle
            self.navigationController?.pushViewController(vc, animated: true)
        })
        //翻桌率点击
        _ = sectionView.manageBtn.rx.tap.subscribe(onNext:{_ in
            let shopType = WDBGlobalDataUserDefaults.getShopTurnoverType()
            if shopType == "0" {
                navigator.push(NavigatorURLTurnoverManagement)//翻桌率
            }else if shopType == "1" {
                navigator.push(NavigatorURLExpand)//推广
            }else if shopType == "2" {
                navigator.push(NavigatorURLTurnoverSet)//设置
            }
        })
        //账单点击
        _ = sectionView.billBtn.rx.tap.subscribe(onNext:{_ in
            navigator.push(NavigatorURLShopBill)
        })
        return sectionView
    }
    
    //扫描结果
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        navigator.push(NavigatorURLScanResult,context:scanResult.strScanned ?? "")
    }

}
