//
//  WDBGameManageView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBGameManageView: UIView {
    
    var bottomView:UIButton!
    var tableView:UITableView!
    var headerView:UIView!
    var callTipLab:UILabel!
    var callTf:UITextField!
    var storeGameLab:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() -> Void {
        
        tableView = UITableView()
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.rowHeight = 80
        self.addSubview(tableView)
        tableView.register(WDBGameManageCell.self, forCellReuseIdentifier: "WDBGameManageCell")
        
        let footerView = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:40))
        footerView.backgroundColor = UIColor.white
        tableView.tableFooterView = footerView
        
        setTableHeaderView()
        
        setBottomView()
    }
    
    func setTableHeaderView() -> Void {
        
        headerView = UIView()
        headerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:140)
        headerView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headerView
        
        callTipLab = UILabel()
        callTipLab.textColor = TitleTextColor
        callTipLab.font = UIFontWithSize(size: 14)
        callTipLab.text = "对用户喊话"
        headerView.addSubview(callTipLab)
        
        callTf = UITextField()
        callTf.textColor = DetailTextColor
        callTf.font = UIFontWithSize(size: 12)
        callTf.placeholder = "有本事就来白吃一顿～"
        headerView.addSubview(callTf)
        
        let lineView:UIView! = UIView()
        lineView.backgroundColor = UIColor.groupTableViewBackground
        headerView.addSubview(lineView)
        
        storeGameLab = UILabel()
        storeGameLab.textColor = TitleTextColor
        storeGameLab.font = UIFontWithSize(size: 14)
        storeGameLab.text = "店铺游戏"
        headerView.addSubview(storeGameLab)
        
        
        callTipLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(20)
            make.height.equalTo(21)
        }
        
        callTf.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(callTipLab.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(callTf.snp.bottom).offset(10)
            make.height.equalTo(5)
        }
        
        storeGameLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(lineView.snp.bottom).offset(15)
            make.height.equalTo(21)
        }
    }
    
    func setBottomView() -> Void {
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("+添加游戏", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
    }
    
}
