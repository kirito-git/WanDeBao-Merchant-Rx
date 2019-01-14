//
//  WDBTurnoverManageViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh
import SVProgressHUD
import RxSwift
import RxCocoa
import RxDataSources

class WDBTurnoverManageViewController: WDBBaseViewController{

    var viewModel:WDBTurnoverManageViewModel!
    var turnOverView:WDBTurnoverManageView!
    var collectionView:UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "翻桌率管理"
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        turnOverView = WDBTurnoverManageView.init(frame: self.view.frame)
        self.view.addSubview(turnOverView)
        self.collectionView = turnOverView.collectionView
        
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.stateLabel.isHidden = true
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        self.collectionView.mj_header = headerRefresh
    }
    
    
    func bindViewModel() {
        viewModel = WDBTurnoverManageViewModel(headerRefresh: self.collectionView.mj_header.rx.refreshing.asDriver())
        
        let dataSourse = RxCollectionViewSectionedReloadDataSource<TurnOverManageSection>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                print(indexPath.item)
                if indexPath.item == self.viewModel.tableDatas.value[0].items.count-1 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDBTurnoverManageAddCell", for: indexPath) as! WDBTurnoverManageAddCell
                    
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDBTurnoverManageCell", for: indexPath) as! WDBTurnoverManageCell
                let model = element
                cell.tableNumLab.text = model.tableNum
                //已上菜 未上菜
                cell.startStatusBtn.isSelected = model.servingStatus == 1 ? true : false
                cell.startStatusBtn.backgroundColor = model.servingStatus == 2 ? UIColor.white : UIColor_MainOrangeColor
                //就餐开始 就餐结束
                cell.endBtn.isSelected = model.servingStatus == 1 ? true : false
                cell.endBtn.backgroundColor = model.servingStatus == 2 ? UIColor.white : UIColor_MainOrangeColor
                
                cell.endBtn.tag = indexPath.item
                cell.endBtn.rx.tap.asDriver()
                    .drive(onNext:{[weak self] in
                        self?.viewModel.startOrEndTakeFoodRequest(index: indexPath.row)
                            .subscribe{[weak self] in
                                self?.startOrEndAlert(index: indexPath.row)
                        }
                    }).disposed(by: cell.disposeBag)
                return cell
        },
        configureSupplementaryView: {
            (ds ,collectionView, kind, ip) in
            var reuseview:WDBTurnoverManageHeader!
            if kind == UICollectionElementKindSectionHeader {
                reuseview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WDBTurnoverManageHeader", for:ip) as! WDBTurnoverManageHeader
                reuseview.numLab.text = self.viewModel.totalNum.value
                reuseview.unitPriceLab.text = self.viewModel.givePrice.value
                reuseview.totalPriceLab.text = self.viewModel.todayGivePrice.value
            }
            return reuseview
        })
        //绑定数据
        self.viewModel.tableDatas
            .bind(to: self.collectionView.rx.items(dataSource: dataSourse))
            .disposed(by: disposeBag)
        
        //绑定停止刷新
        self.viewModel.endRefresh
            .drive(self.collectionView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //collection点击
        _ = self.collectionView.rx.itemSelected.subscribe(onNext:{ [unowned self] indexPath in
            if indexPath.item == self.viewModel.tableDatas.value[0].items.count-1 {
                self.addTableAlert()
            }
        })
        
        
        //设置点击
        _ = turnOverView.bottomView.rx.tap.subscribe(onNext: {
            //self.navigationController?.pushViewController(WDBTurnoverStyleSetViewController(), animated: true)
            navigator.push(NavigatorURLTurnoverStyleSet)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    
    func addTableAlert() {
        let alertControl = UIAlertController.init(title: "填写餐桌号", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertControl.addTextField { (textFild:UITextField!) in
            textFild.placeholder = "餐桌号"
        }
        alertControl.addAction(UIAlertAction.init(title: "添加", style: UIAlertActionStyle.destructive, handler: { (action) in
            //添加
            let tableStr = alertControl.textFields!.first!.text!
            if tableStr.count == 0 {
                SVProgressHUD.showError(withStatus: "请输入餐桌号！")
            }else {
                print(tableStr)
                _ = self.viewModel.turnoverTableAdd(tableNum: tableStr).subscribe(onNext: { (response) in
                    if let respData:[String:Any] = response as? [String:Any] {
                        if respData["error_mesg"] == nil {
                            //刷新一下数据
                            let newModel = WDBTableModel(JSON: respData)
                            var beforeModels = self.viewModel.tableDatas.value[0].items
                            beforeModels.append(newModel!)
                            self.viewModel.tableDatas.accept([TurnOverManageSection(items:beforeModels)])
                            //self.viewModel.refreshRequest.onNext(())
                        }else {
                            SVProgressHUD.showError(withStatus: respData["error_mesg"] as? String)
                        }
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            }
        }))
        alertControl.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertControl, animated: true, completion: nil)
    }
    
    //是否开启关闭
    func startOrEndAlert(index:Int) {
        let alertControl = UIAlertController.init(title: "提示", message: self.viewModel.startOrEndTips.value, preferredStyle: UIAlertControllerStyle.alert)
        alertControl.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.destructive, handler: { (action) in
            let isStart = self.viewModel.isStart.value
            if isStart == true {
                //开始就餐
                _ = self.viewModel.turnoverStartTakeFood(index: index).subscribe(onNext: { (response) in
                    let dataDic = response as! [String:Any]
                    if dataDic["error_mesg"] == nil {
                        let tableModel:WDBTableModel = WDBTableModel(JSONString: JSONTools.jsonStringFromDataDic(dic: dataDic))!
                        //替换原数据
                        var oldItems = self.viewModel.tableDatas.value[0].items
                        oldItems[index] = tableModel
                        self.viewModel.tableDatas.accept([TurnOverManageSection(items:oldItems)])
                    }else {
                        SVProgressHUD.showError(withStatus: dataDic["error_mesg"] as! String)
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            }else {
                //结束就餐
                _ = self.viewModel.turnoverEndTakeFood(index: index).subscribe(onNext: { (response) in
                    let dataDic = response as! [String:Any]
                    if dataDic["error_mesg"] == nil {
                        let tableModel:WDBTableModel = WDBTableModel(JSONString: JSONTools.jsonStringFromDataDic(dic: dataDic))!
                        //替换原数据
                        var oldItems = self.viewModel.tableDatas.value[0].items
                        oldItems[index] = tableModel
                        self.viewModel.tableDatas.accept([TurnOverManageSection(items:oldItems)])
                    }else {
                        SVProgressHUD.showError(withStatus: dataDic["error_mesg"] as! String)
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            }
        }))
        alertControl.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertControl, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 255, G: 255, B: 255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

