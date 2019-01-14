//
//  WDBExpandSetView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBExpandSetView: UIView ,UITableViewDataSource, UITableViewDelegate{

    var tableView:UITableView!
    var headerView:UIView!
    var footerView:UIView!
    var priceTf:UITextField!
    var bottomView:UIButton!
    
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
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(tableView)
        tableView.register(WDBDiscountCell.self, forCellReuseIdentifier: "WDBDiscountCell")
        
        setHeaderview()
        setFooterview()
        setBottomView()
    }
    
    func setHeaderview() -> Void {
        headerView = UIView()
        headerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:120)
        headerView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headerView
        
        let setPriceLab = UILabel()
        setPriceLab.text = "设定证券金额"
        setPriceLab.textColor = TitleTextColor
        setPriceLab.font = UIFontWithSize(size: 14)
        headerView.addSubview(setPriceLab)
        
        priceTf = UITextField()
        priceTf.keyboardType = UIKeyboardType.numberPad
        priceTf.borderStyle = UITextBorderStyle.roundedRect
        headerView.addSubview(priceTf)
        
        let tips1 = UILabel()
        tips1.text = "金额从资金账户扣除"
        tips1.font = UIFontWithSize(size: 10)
        tips1.textColor = DetailTextColor
        headerView.addSubview(tips1)
        
        let tips2 = UILabel()
        tips2.text = "此券可与满减券一同使用，用户收到券金额大于设定金额，超出部分平台补贴，增加优惠力度"
        tips2.font = UIFontWithSize(size: 12)
        tips2.textColor = DetailTextColor
        tips2.numberOfLines = 0
        headerView.addSubview(tips2)
        
        setPriceLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        priceTf.snp.makeConstraints { (make) in
            make.left.equalTo(setPriceLab.snp.right).offset(0)
            make.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        tips1.snp.makeConstraints { (make) in
            make.left.equalTo(priceTf.snp.left)
            make.top.equalTo(priceTf.snp.bottom)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        tips2.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(tips1.snp.bottom).offset(15)
            make.height.equalTo(30)
        }
    }
    
    func setFooterview() -> Void {
        footerView = UIView()
        footerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:70)
        tableView.tableFooterView = footerView
        
//        let addButton = UIButton()
//        addButton.frame = CGRect(x:SCREEN_WIDTH/2-40,y:0,width:80,height:40)
//        addButton.setTitle("+", for: UIControlState.normal)
//        addButton.setTitleColor(UIColor_MainOrangeColor, for: UIControlState.normal)
//        addButton.backgroundColor = UIColor.lightGray
//        footerView.addSubview(addButton)
    }
    
    func setBottomView() -> Void {
        bottomView = UIButton()
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("确 定", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
        
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
        let tiplabel = UILabel()
        tiplabel.frame = CGRect(x:15,y:0,width:SCREEN_WIDTH-30,height:40)
        tiplabel.text = "设定店内优惠券（仅限满减券，至少一张满减券）"
        tiplabel.text = ""
        tiplabel.font = UIFontWithSize(size: 14*SCREEN_WIDTH/375)
        tiplabel.textColor = TitleTextColor
        headview.addSubview(tiplabel)
        
        return headview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBDiscountCell", for: indexPath) as! WDBDiscountCell
        cell.contentView.backgroundColor = UIColor.groupTableViewBackground
        cell.typeLab.text = "抵扣券"
        cell.titleLab.text = "满40减20元"
        cell.limitDate.text = "有效期7天"
        cell.limitNum.text = "发放100张／天"
        return cell
    }

}
