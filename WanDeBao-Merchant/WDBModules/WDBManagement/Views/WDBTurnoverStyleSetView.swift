//
//  WDBTurnoverStyleSetView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBTurnoverStyleSetView: UIView{
    
    var gameTableView:UITableView!
    
    var headerView:UIView!
    var tips1Lab:UILabel!
    var priceTf:UITextField!
    var priceUnitLab:UILabel!
    var tips2Lab:UILabel!
    var timeTf:UITextField!
    var timeUnitLab:UILabel!
    var choseStoreLab:UILabel!
    var choseStoreButton:UIButton!
    var bottomView:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() -> Void {
        
        gameTableView = UITableView()
        gameTableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        gameTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        gameTableView.rowHeight = 70
        self.addSubview(gameTableView)
        gameTableView.register(WDBTurnoverStyleSetCell.self, forCellReuseIdentifier: "WDBTurnoverStyleSetCell")
        
        let footerView = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:40))
        footerView.backgroundColor = UIColor.white
        gameTableView.tableFooterView = footerView
        
        setTableHeaderView()
        setBottomView()
    }
    
    func setTableHeaderView() -> Void {
        
        headerView = UIView()
        headerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:130)
        headerView.backgroundColor = UIColor.white
        gameTableView.tableHeaderView = headerView
        
        tips1Lab = UILabel()
        tips1Lab.textColor = TitleTextColor
        tips1Lab.font = UIFontWithSize(size: 14)
        tips1Lab.text = "设置赠券金额"
        headerView.addSubview(tips1Lab)
        
        priceTf = UITextField()
        priceTf.textColor = DetailTextColor
        priceTf.font = UIFontWithSize(size: 12)
        priceTf.placeholder = "例：5"
        priceTf.borderStyle = UITextBorderStyle.line
        priceTf.layer.borderWidth = 1
        priceTf.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        priceTf.keyboardType = UIKeyboardType.numberPad
        headerView.addSubview(priceTf)
        
        priceUnitLab = UILabel()
        priceUnitLab.textColor = TitleTextColor
        priceUnitLab.font = UIFontWithSize(size: 14)
        priceUnitLab.text = "元／券"
        headerView.addSubview(priceUnitLab)
        
        tips2Lab = UILabel()
        tips2Lab.textColor = TitleTextColor
        tips2Lab.font = UIFontWithSize(size: 14)
        tips2Lab.text = "设置奖券有效期"
        headerView.addSubview(tips2Lab)
        
        timeTf = UITextField()
        timeTf.textColor = DetailTextColor
        timeTf.font = UIFontWithSize(size: 12)
        timeTf.placeholder = "例：90"
        timeTf.borderStyle = UITextBorderStyle.line
        timeTf.layer.borderWidth = 1
        timeTf.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        timeTf.keyboardType = UIKeyboardType.numberPad
        headerView.addSubview(timeTf)
        
        timeUnitLab = UILabel()
        timeUnitLab.textColor = TitleTextColor
        timeUnitLab.font = UIFontWithSize(size: 14)
        timeUnitLab.text = "分钟"
        headerView.addSubview(timeUnitLab)
        
        choseStoreLab = UILabel()
        choseStoreLab.textColor = TitleTextColor
        choseStoreLab.font = UIFontWithSize(size: 14)
        choseStoreLab.text = "    选择赠券店铺"
        choseStoreLab.backgroundColor = UIColor.groupTableViewBackground
        headerView.addSubview(choseStoreLab)
        
        choseStoreButton = UIButton()
        choseStoreButton.setImage(UIImage.init(named: "arrow_right"), for: .normal)
        headerView.addSubview(choseStoreButton)
        
        tips1Lab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        priceTf.snp.makeConstraints { (make) in
            make.left.equalTo(tips1Lab.snp.right).offset(10)
            make.centerY.equalTo(tips1Lab)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        
        priceUnitLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceTf.snp.right).offset(10)
            make.centerY.equalTo(tips1Lab)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        tips2Lab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(tips1Lab.snp.bottom).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        timeTf.snp.makeConstraints { (make) in
            make.left.equalTo(tips1Lab.snp.right).offset(10)
            make.centerY.equalTo(tips2Lab)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        
        timeUnitLab.snp.makeConstraints { (make) in
            make.left.equalTo(timeTf.snp.right).offset(10)
            make.centerY.equalTo(tips2Lab)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        choseStoreLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(tips2Lab.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        choseStoreButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(choseStoreLab)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
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
}
