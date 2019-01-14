//
//  WDBMyBankCardViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

typealias RechargeVCCallBackBlock = (_:String,_:String) -> Void

class WDBMyBankCardViewController: WDBBaseViewController ,DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITableViewDelegate{
    
    var rechargeVCBlock: RechargeVCCallBackBlock!
    var viewModel = WDBMineViewModel()
    lazy var myBankCardDelegate = WDBMyBankCardDelegate()
    lazy var myBankCardDataSource = WDBMyBankCardDataSource()
    var changeBankCardVC = WDBChangeBankCardViewController()
    lazy var tableView = UITableView()
    lazy var addBankCardBtn = UIButton()
    var isSelectCard:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的银行卡"
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        tableView.delegate = myBankCardDelegate
        tableView.dataSource = myBankCardDataSource
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let nib = UINib.init(nibName: "WDBMyBankCardCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WDBMyBankCardCell")
        
        self.view.addSubview(tableView)
        
        
        addBankCardBtn.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - kNavibarH - 50 - iPhoneXBottomBarH, width: SCREEN_WIDTH, height: 50)
        addBankCardBtn.setBackgroundImage(UIImage.init(named: "mine_mybankcard_btnbg"), for: .normal)
        addBankCardBtn.setTitle("添加银行卡", for: .normal)
        addBankCardBtn.titleLabel?.font = UIFontWithSize(size: 14)
        addBankCardBtn.setTitleColor(UIColor.black, for: .normal)
        let _ = addBankCardBtn.rx.tap.subscribe(onNext: {
            self.navigationController?.pushViewController(self.changeBankCardVC, animated: true)
        })
        self.view.addSubview(addBankCardBtn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindBankViewModel()
    }
    
    func passValueClourse(_ block: @escaping RechargeVCCallBackBlock) {
        self.rechargeVCBlock = block
    }
    
    func bindBankViewModel() {
        _ = viewModel.queryBankCardList().subscribe(onNext: { (models) in
            self.myBankCardDataSource.dataArray = models
            self.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectCard == true {
            let bankCardMode = self.myBankCardDataSource.dataArray![indexPath.row]
            let cardId = String(describing: bankCardMode.Id ?? 0)
            let cardNum = String(describing: bankCardMode.bankCard ?? "")
            //传回银行卡id
            if let block = rechargeVCBlock {
                block(cardId,cardNum)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "暂无银行卡", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
