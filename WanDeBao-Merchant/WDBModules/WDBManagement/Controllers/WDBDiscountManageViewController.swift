//
//  WDBDiscountManageViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import PGActionSheet
import RxSwift
import RxCocoa
import RxDataSources

class WDBDiscountManageViewController: WDBBaseViewController ,PGActionSheetDelegate{

    var discountView:WDBDiscountManageView!
    var tableView:UITableView!
    var viewModel:WDBDiscountManageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "优惠券管理"
        setupSubviews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //刷新一次请求
        self.viewModel.refreshRequest.onNext(())
    }
    
    
    func setupSubviews() {
        discountView = WDBDiscountManageView.init(frame: self.view.frame)
        self.view.addSubview(discountView)
        tableView = discountView.tableView
        tableView.rx.setDelegate(self as UIScrollViewDelegate)
        
        let headerRefesh = MJRefreshNormalHeader()
        headerRefesh.stateLabel.isHidden = true
        headerRefesh.lastUpdatedTimeLabel.isHidden = true
        self.tableView.mj_header = headerRefesh
    }
    
    func bindViewModel() {
        viewModel = WDBDiscountManageViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //绑定tableview和VM
        _ = viewModel.dataArray.bind(to: self.tableView.rx.items){ (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBDiscountCell") as! WDBDiscountCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.typeLab.text = model.discount?.typeName
            cell.titleLab.text = model.discount?.discountName ?? ""
            cell.limitDate.text = model.discount?.limitDay
            cell.limitNum.text = "发放\(String(model.conditionList?.number ?? 0))张／天"
            return cell
        }
        
        //tableview删除
        _ = tableView.rx.itemDeleted.subscribe(onNext:{ [unowned self] indexPath in
            self.viewModel.discountDelete(row: indexPath.row)
                .subscribe(onNext:{ response in
                    if let resp:Int = response as? Int {
                        if resp == 1 {
                            YBProgressHUD.showTipMessage(text: "删除成功！")
                            //删除此行数据
                            var items = self.viewModel.dataArray.value
                            items.remove(at: indexPath.row)
                            self.viewModel.dataArray.accept(items)
                        }
                    }else {
                        YBProgressHUD.showTipMessage(text: "删除失败")
                    }
                })
        })
        
        //绑定停止刷新
        _ = viewModel.endHeaderRefresh.drive(
            self.tableView.mj_header.rx.endRefreshing
        )
        
        //添加优惠券点击
        _ = discountView.bottomView.rx.tap.subscribe(onNext:{
            self.showActionSheet()
        })
        
        //积分兑换
        _ = discountView.exchangeButton.rx.tap.subscribe(onNext: {
            navigator.push(NavigatorURLDiscountIntegralExchange)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    func showActionSheet() {
        let actionSheet = PGActionSheet(cancelButton: true, buttonList: ["免单优惠券", "满减优惠券", "赠品优惠券","折扣优惠券"])
        actionSheet.delegate = self
        actionSheet.actionSheetTranslucent = false
        actionSheet.textFont = UIFontWithSize(size: 14)
        actionSheet.textColor = TitleTextColor
        actionSheet.cancelTextFont = UIFontWithSize(size: 14)
        self.present(actionSheet, animated: false, completion: nil)
    }
    
    //--- actionsheet delegate
    func actionSheet(_ actionSheet: PGActionSheet, clickedButtonAt index: Int) {
        let type = self.viewModel.discountTypes.value[index]
        let paramDic = ["currentType": type, "isActionAdd":true] as [String : Any]
        let paramStr = JSONTools.jsonStringFromDataDic(dic: paramDic)
        navigator.push(NavigatorURLManagementAddDiscount + "/" + paramStr)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WDBDiscountManageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}

