//
//  WDBRenewalViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/19.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalViewController: WDBBaseViewController, OrderPayFinishDelegate {
    
    var tableView: UITableView!
    lazy var renewalDelegate = WDBRenewalDelegate()
    lazy var renewalDataSource = WDBRenewalDataSource()
    var bottomView: WDBRenewalBottomView!
    var headerView: WDBRenewalHeaderView!
    
    var payType:WDBPayType?
    var payChannel:WDBPayChannel?
    var viewModel: WDBMineViewModel?
    var selectProductModel: WDBProductModel?
    var payViewModel: WDBPayViewModel?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        bindViewModel()
    }
    
    
    func setupSubviews() {
        
        self.payType = WDBPayType.wxpay
        self.payChannel = WDBPayChannel.wxpay
        self.renewalDataSource.isSelectWeChatPay = true
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        myAppDelegate.orderPayDelegate = self
        
        self.navigationItem.title = "立即续费"
        self.navigationController?.navigationBar.barTintColor = UIColorRGB_Alpha(R: 251, G: 151, B: 119, alpha: 1)
        
        tableView = UITableView()
        tableView.backgroundColor = APP_BK_COLOR
        tableView?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kNavibarH - 60 - iPhoneXBottomBarH)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        headerView = WDBRenewalHeaderView()
        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100)
        tableView?.delegate = renewalDelegate
        tableView?.dataSource = renewalDataSource
        tableView?.tableHeaderView = headerView
        
        
         bottomView = WDBRenewalBottomView()
         bottomView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-kNavibarH-60-iPhoneXBottomBarH, width: SCREEN_WIDTH, height: 60)
         self.view.addSubview(bottomView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = viewModel?.queryIsHaveFreeTryService().subscribe(onNext: { [weak self](array) in
             self?.queryService(dataArray: array)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        headerView.setValueForView()
    }
    
   func bindViewModel() {
    
    viewModel = WDBMineViewModel()
    payViewModel = WDBPayViewModel()
    
     //开启7天使用点击回调
     renewalDataSource.openSevenDaysTry {
        
       _ = self.viewModel?.openServiceTry().subscribe(onNext: { (shopInfo) in
        
        print("成功开通的7天免费试用")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
     }
    
     //选择支付方式回调
    renewalDelegate.selectPayType { [weak self](payType) in
        if payType == WDBPayType.wxpay {
            self?.renewalDataSource.weChatPayCell.selectPayBtn.isSelected = true
            self?.renewalDataSource.aliPayCell.selectPayBtn.isSelected = false
            self?.renewalDataSource.isSelectWeChatPay = true
        }else if (payType == WDBPayType.alipay) {
            self?.renewalDataSource.weChatPayCell.selectPayBtn.isSelected = false
            self?.renewalDataSource.aliPayCell.selectPayBtn.isSelected = true
            self?.renewalDataSource.isSelectWeChatPay = false
        }
         self?.savePayType(payType: payType)
     }
    
     //选择产品回调
    renewalDelegate.selectProduct { [weak self](model, index) in
        self?.saveSelectProductModel(selectProductModel: model)
        self?.renewalDataSource.selectIndex = index
        self?.tableView.reloadData()
        self?.bottomView.totalPriceLabel.text = "总计"+" ¥" + String(describing:model.price ?? 0.0)
    }
    
    
    //支付按钮
    _ = bottomView.ensurePayBtn.rx.tap.subscribe({ [weak self](event) in
        
       //续费下单，此处type为8
        if let selectProductModel = self?.selectProductModel {
            
            //下单
        _ = self?.viewModel?.productAddOrder(orderUnionType: 8, selectProductModel: selectProductModel).subscribe(onNext: { [weak self](orderModel) in
             //支付
             let orderPayId = String(describing: orderModel.orderPay?.id ?? 0)
             let payType = self?.payType?.rawValue ?? ""
             let payChannel = self?.payChannel?.rawValue ?? ""
            
            self?.payViewModel?.startOrderPayWith(orderPayId:orderPayId, payType: WDBPayType(rawValue: payType)!, payChannel: payChannel, mchId: "100001")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
      }
        
    })
    

    }
    
    // 查询产品服务
    func queryService(dataArray: [WDBProductModel]) {
        
        _ = self.viewModel?.queryServiceRenewalList(pageNo: 1).subscribe(onNext: { (array) in
            
            if dataArray.count > 0 {
                var dataArr = [WDBProductModel]()
                dataArr.append(dataArray.first!)
                dataArr = dataArr + array
                self.renewalDataSource.dataSource = dataArr
                self.renewalDataSource.isHaveSevenDaysTry = true
                self.renewalDelegate.dataSource = dataArr
                self.renewalDelegate.isHaveSevenDaysTry = true
            }else{
                self.renewalDataSource.isHaveSevenDaysTry = false
                self.renewalDelegate.isHaveSevenDaysTry = false
                self.renewalDataSource.dataSource = array
                self.renewalDelegate.dataSource = array
            }
            
            self.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    func savePayType(payType: WDBPayType)  {
          self.payType = payType
        if payType == WDBPayType.wxpay {
            self.payChannel = WDBPayChannel.wxpay
        }
        if payType == WDBPayType.alipay {
            self.payChannel = WDBPayChannel.aliPay
        }
    }
    
    func saveSelectProductModel(selectProductModel: WDBProductModel) {
        self.selectProductModel = selectProductModel
        print(self.selectProductModel?.productId ?? "")
    }
    
    
    //MARK - OrderPayFinishDelegate
    func orderPayFinish(With payType: WDBPayType, isSuccess: Bool, respMsg: String) {
        let tips = respMsg
        let alertVC = UIAlertController.init(title: "提示", message: tips, preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
            
        }))
        self.present(alertVC, animated: true, completion: nil)
        
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
