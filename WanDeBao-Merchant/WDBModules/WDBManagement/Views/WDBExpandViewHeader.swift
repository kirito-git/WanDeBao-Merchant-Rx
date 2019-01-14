//
//  WDBExpandViewHeader.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBExpandViewHeader: UIView {

    var model:WDBGeneralizeModel? {
        didSet{
            if model != nil {
                numLab.text = String(describing:model?.number ?? 0)
                unitPriceLab.text = String(describing:model?.factorValue ?? 0)
                totalPriceLab.text = String(describing:model?.sum ?? 0)
            }
        }
    }
    
    var headerView:UIView!
    var totalTipsLabel:UILabel!
    var numLab:UILabel!
    var unitPriceTipLab:UILabel!
    var unitPriceLab:UILabel!
    var totalPriceTipLab:UILabel!
    var totalPriceLab:UILabel!
    var line:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerView = UIView()
        headerView.backgroundColor = UIColor_MainOrangeColor
        headerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_WIDTH/2)
        self.addSubview(headerView)
        
        //今日兑券数
        
        totalTipsLabel = UILabel()
        totalTipsLabel.text = "今日兑券数"
        totalTipsLabel.font = UIFontWithSize(size: 14)
        totalTipsLabel.textColor = UIColor.white
        totalTipsLabel.textAlignment = NSTextAlignment.center
        self.addSubview(totalTipsLabel)
        
        numLab = UILabel()
        numLab.text = "0"
        if model != nil {
            numLab.text = String(describing:model?.number ?? 0)
        }
        numLab.font = UIFontWithSize(size: 20)
        numLab.textColor = UIColor.white
        numLab.textAlignment = NSTextAlignment.center
        self.addSubview(numLab)
        
        //赠券金额
        
        unitPriceLab = UILabel()
        unitPriceLab.text = "0"
        if model != nil {
            unitPriceLab.text = String(describing:model?.factorValue ?? 0)
        }
        unitPriceLab.font = UIFontWithSize(size: 14)
        unitPriceLab.textColor = UIColor.white
        unitPriceLab.textAlignment = NSTextAlignment.center
        self.addSubview(unitPriceLab)
        
        unitPriceTipLab = UILabel()
        unitPriceTipLab.text = "赠券金额"
        unitPriceTipLab.font = UIFontWithSize(size: 13)
        unitPriceTipLab.textColor = UIColor.white
        unitPriceTipLab.textAlignment = NSTextAlignment.center
        self.addSubview(unitPriceTipLab)
        
        
        //今日总券金额
        
        totalPriceLab = UILabel()
        totalPriceLab.text = "0"
        if model != nil {
            totalPriceLab.text = String(describing:model?.sum ?? 0)
        }
        totalPriceLab.font = UIFontWithSize(size: 14)
        totalPriceLab.textColor = UIColor.white
        totalPriceLab.textAlignment = NSTextAlignment.center
        self.addSubview(totalPriceLab)
        
        totalPriceTipLab = UILabel()
        totalPriceTipLab.text = "今日总赠券金额(元)"
        totalPriceTipLab.font = UIFontWithSize(size: 13)
        totalPriceTipLab.textColor = UIColor.white
        totalPriceTipLab.textAlignment = NSTextAlignment.center
        self.addSubview(totalPriceTipLab)
        
        line = UILabel()
        line.backgroundColor = UIColor.white
        self.addSubview(line)
        
        
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        //今日兑券数
        
        totalTipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalTipsLabel.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        //券单价
        
        unitPriceLab.snp.makeConstraints { (make) in
            make.top.equalTo(numLab.snp.bottom).offset(40)
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        unitPriceTipLab.snp.makeConstraints { (make) in
            make.top.equalTo(unitPriceLab.snp.bottom).offset(5)
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        //今日总券金额
        
        totalPriceLab.snp.makeConstraints { (make) in
            make.top.equalTo(numLab.snp.bottom).offset(40)
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        totalPriceTipLab.snp.makeConstraints { (make) in
            make.top.equalTo(totalPriceLab.snp.bottom).offset(5)
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.width.equalTo(140)
            make.height.equalTo(20)
        }
        
        //line
        line.snp.makeConstraints { (make) in
            make.top.equalTo(unitPriceLab.snp.top).offset(5)
            make.bottom.equalTo(unitPriceTipLab.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
