//
//  WDBMineViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMineViewController: WDBBaseViewController {
    
    lazy var mineTableViewDelegate = WDBMineTableViewDelegate()
    lazy var mineTableViewDataSource = WDBMineTableViewDataSource()
    lazy var viewModel = WDBMineViewModel()
    lazy var headerView = WDBMineHeaderView()
    lazy var footerView = WDBMineFooterView()
    lazy var personalInfoVC = WDBPersonalInfoViewController()
    lazy var renewalVC = WDBRenewalViewController()
    var isBackByPop: Bool?
    
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        bindEvent()
        isBackByPop = false
    }
    
    func setupSubviews() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: -20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-20))
        tableView.backgroundColor = APP_BK_COLOR
        //注册cell
        let nib = UINib.init(nibName: "WDBMineCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WDBMineCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = mineTableViewDelegate
        tableView.dataSource = mineTableViewDataSource
        mineTableViewDataSource.dataArray = viewModel.modelArray
        mineTableViewDelegate.viewController = self
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 295)
        //headerView.setValueForView()
        tableView.tableHeaderView = headerView
        footerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100)
        tableView.tableFooterView = footerView
        self.view.addSubview(tableView)
        
        createHeaderBgView()
    }
    
    func bindEvent() {
        
       //头像点击
       _ = headerView.avatarImgView.rx.tap.subscribe(onNext: { [weak self] event in
           navigator.push(NavigatorURLPersonalInfo)
        })
        
       //立即续费
      _ = headerView.renewalBtn.rx.tap.subscribe(onNext: { event in
        
        if !UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!) && !WXApi.isWXAppInstalled() {
            YBProgressHUD.showTipMessage(text: "请先安装微信和支付宝")
            return
        }
         navigator.push(NavigatorURLRenewal)
      })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: isBackByPop ?? false)
        queryAccountInfo()
        self.isBackByPop = false
        
    }
    
    
    func queryAccountInfo() {
        //查询账户
        let userId = WDBGlobalDataUserDefaults.getID()
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let params:[String:Any] = ["userId":userId,"shopId":shopId]
        print(params)
       _ = viewModel.queryAccount(dic: params).subscribe(onNext: {[weak self](model) in
        self?.headerView.model = model
        self?.headerView.setValueForView()
        //保存账户余额
        WDBGlobalDataUserDefaults.saveShopAccount(account: model.account ?? 0)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    //添加一个背景view 下拉不会出现灰色背景
    func createHeaderBgView() {
        let bgView = UIView()
        bgView.frame = CGRect(x:0,y:-SCREEN_HEIGHT,width:SCREEN_WIDTH,height:SCREEN_HEIGHT)
        bgView.backgroundColor = UIColor_MainOrangeColor
        self.tableView.addSubview(bgView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
