//
//  WDBDiscountIntegralExchangeView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD
import PGActionSheet

class WDBDiscountIntegralExchangeView: UIView,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource{

    var switchView:UISwitch!
    var bottomView:UIButton!
    var actionSheet:PGActionSheet!
    var setView:UIView!
    var tableView:UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        self.backgroundColor = UIColor.groupTableViewBackground
        creatSetView()
        creatTableView()
        setBottomView()
    }
    
    func creatSetView() -> Void {
        
        setView = UIView()
        setView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:50)
        setView.backgroundColor = UIColor.white
        self.addSubview(setView)
        
        let tipslab = UILabel()
        tipslab.frame = CGRect(x:15,y:0,width:140,height:50)
        tipslab.text = "开启用户积分兑换"
        tipslab.font = UIFontWithSize(size: 16)
        setView.addSubview(tipslab)
        
        switchView = UISwitch()
        switchView.frame = CGRect(x:SCREEN_WIDTH-70,y:10,width:60,height:40)
        switchView.isOn = false
        setView.addSubview(switchView)
    }
    
   
    func creatTableView() -> Void {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.frame = CGRect(x:0,y:50,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-50-kNavibarH-iPhoneXBottomBarH)
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.addSubview(tableView)
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.tableHeaderView = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:10))
        tableView.register(WDBDiscountCell.self, forCellReuseIdentifier: "WDBDiscountCell")
    }
    
    func setBottomView() -> Void {
        bottomView = UIButton()
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("+添加积分商品", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty_discount")
    }
    
}
