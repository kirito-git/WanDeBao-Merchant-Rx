//
//  WDBManagementViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

class WDBManagementViewController: WDBBaseViewController {

    var manageView:WDBManagementView!
    var viewModel = WDBManagementViewModel()
    var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "门店管理"
        setupSubviews()
        bindViewModel()
    }
    
    func setupSubviews() {
        //初始化view
        manageView = WDBManagementView.init(frame: self.view.frame);
        self.view.addSubview(manageView)
        self.collectionView = manageView.collectionView
    }
    
    func bindViewModel() {
        //初始化datasourse
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <ManageIndexSection>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDBManagementCell",
                                                                  for: indexPath) as! WDBManagementCell
                    cell.titleLab.text = element.title ?? ""
                    cell.imageView.image = UIImage.init(named: element.icon ?? "")
                    return cell
            },
                configureSupplementaryView: {
                    (ds ,collectionView, kind, ip) in
                    var reuseview:WDBManagementHeader!
                    if kind == UICollectionElementKindSectionHeader {
                        reuseview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WDBManagementHeader", for:ip) as! WDBManagementHeader
                        _ = self.viewModel.totalIncome.asObservable().bind(to: reuseview.priceLab.rx.text)
                        _ = self.viewModel.monthIncome.asObservable().bind(to: reuseview.monthPriceLab.rx.text)
                        _ = self.viewModel.monthOrders.asObservable().bind(to: reuseview.expenseNumLab.rx.text)
                    }
                    return reuseview
            })
        //绑定collectionView
        self.viewModel.dataArray
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //item点击
        _ = self.collectionView.rx.itemSelected.subscribe(onNext:{ [unowned self] indexPath in
            let url = self.viewModel.pushToVCUrl(index: indexPath.item)
            if indexPath.item == 1 {
                navigator.push(url,context:true)
            }else if indexPath.item == 2 {
                navigator.push(url,context:false)
            }else {
                navigator.push(url)
            }
        })
        
        //网络请求
        _ = viewModel.ordersCountAndSum()
        _ = viewModel.ordersCountAndSum2()
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if swift(>=4.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)]
        #elseif swift(>=3.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white , alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)];
        #endif
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        #if swift(>=4.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)]
        #elseif swift(>=3.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)];
        #endif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
