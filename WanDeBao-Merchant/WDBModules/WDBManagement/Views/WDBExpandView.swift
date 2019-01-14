//
//  WDBExpandView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBExpandView: UIView ,UITableViewDelegate, UITableViewDataSource{

    var parentControl:WDBExpandViewController!
    var tableView:UITableView!
    var headerView:WDBExpandViewHeader!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        
        self.backgroundColor = UIColor.groupTableViewBackground
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-64-50)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        self.addSubview(tableView)
        tableView.register(WDBDiscountCell.self, forCellReuseIdentifier: "WDBDiscountCell")

        headerView = WDBExpandViewHeader.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_WIDTH/2))
        tableView.tableHeaderView = headerView
        
        setBottomView()
    }
    
    
    func setBottomView() -> Void {
        var bottomView = UIButton()
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-64-50,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("设 置", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
        
        bottomView.addTarget(self, action: #selector(setClick), for: UIControlEvents.touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headview = UIView()
        headview.backgroundColor = UIColor.white
        let tiplabel = UILabel()
        tiplabel.frame = CGRect(x:15,y:0,width:150,height:40)
        tiplabel.text = "店内优惠券"
        tiplabel.text = ""
        tiplabel.font = UIFontWithSize(size: 14)
        tiplabel.textColor = TitleTextColor
        headview.addSubview(tiplabel)
        
        return headview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBDiscountCell", for: indexPath) as! WDBDiscountCell
        cell.typeLab.text = "抵扣券"
        cell.titleLab.text = "满40减20元"
        cell.limitDate.text = "有效期7天"
        cell.limitNum.text = "发放100张／天"
        return cell
    }

    @objc func setClick() {
        //parentControl.navigationController?.pushViewController(WDBExpandSetViewController(), animated: true)
         navigator.push(NavigatorURLExpandSet)
    }

}
