//
//  WDBManagementHeader.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBManagementHeader: UICollectionReusableView {
    
    var headerView:UIView!
    var totalTipsLabel:UILabel!
//    var priceMarkLab:UILabel!
    var priceLab:UILabel!
    var monthTipLab:UILabel!
    var monthPriceLab:UILabel!
    var expenseNumTipLab:UILabel!
    var expenseNumLab:UILabel!
    var line:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerView = UIView()
        headerView.backgroundColor = UIColor_MainOrangeColor
        headerView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_WIDTH/2)
        self.addSubview(headerView)
        
        //累计收入
        
        totalTipsLabel = UILabel()
        totalTipsLabel.text = "累计收入"
        totalTipsLabel.font = UIFontWithSize(size: 14)
        totalTipsLabel.textColor = UIColor.white
        totalTipsLabel.textAlignment = NSTextAlignment.center
        self.addSubview(totalTipsLabel)
        
//        priceMarkLab = UILabel()
//        priceMarkLab.text = ""
//        priceMarkLab.font = UIFontWithSize(size: 14)
//        priceMarkLab.textColor = UIColor.white
//        priceMarkLab.textAlignment = NSTextAlignment.center
//        self.addSubview(priceMarkLab)
        
        priceLab = UILabel()
        priceLab.text = "0"
        priceLab.font = UIFontWithSize(size: 20)
        priceLab.textColor = UIColor.white
        priceLab.textAlignment = .center
        self.addSubview(priceLab)
        
        //本月收入
        
        monthPriceLab = UILabel()
        monthPriceLab.text = "0"
        monthPriceLab.font = UIFontWithSize(size: 16)
        monthPriceLab.textColor = UIColor.white
        monthPriceLab.textAlignment = NSTextAlignment.center
        self.addSubview(monthPriceLab)
        
        monthTipLab = UILabel()
        monthTipLab.text = "本月收入（元）"
        monthTipLab.font = UIFontWithSize(size: 14)
        monthTipLab.textColor = UIColor.white
        monthTipLab.textAlignment = NSTextAlignment.center
        self.addSubview(monthTipLab)
        
       
        //消费笔数
        
        expenseNumLab = UILabel()
        expenseNumLab.text = "0"
        expenseNumLab.font = UIFontWithSize(size: 16)
        expenseNumLab.textColor = UIColor.white
        expenseNumLab.textAlignment = NSTextAlignment.center
        self.addSubview(expenseNumLab)
        
        expenseNumTipLab = UILabel()
        expenseNumTipLab.text = "本月消费笔数"
        expenseNumTipLab.font = UIFontWithSize(size: 14)
        expenseNumTipLab.textColor = UIColor.white
        expenseNumTipLab.textAlignment = NSTextAlignment.center
        self.addSubview(expenseNumTipLab)
        
        line = UILabel()
        line.backgroundColor = UIColor.white
        self.addSubview(line)
        
        
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        //累计收入
        
        totalTipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30*SizeScale)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        
//        priceMarkLab.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview().offset(-40)
//            make.top.equalTo(totalTipsLabel.snp.bottom).offset(25)
//            make.width.equalTo(20)
//            make.height.equalTo(15)
//        }
//
        priceLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalTipsLabel.snp.bottom).offset(20*SizeScale)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        //本月收入
        monthPriceLab.snp.makeConstraints { (make) in
            make.top.equalTo(priceLab.snp.bottom).offset(40*SizeScale)
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        monthTipLab.snp.makeConstraints { (make) in
            make.top.equalTo(monthPriceLab.snp.bottom).offset(5)
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        //消费笔数
        
        expenseNumLab.snp.makeConstraints { (make) in
            make.top.equalTo(priceLab.snp.bottom).offset(40*SizeScale)
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        expenseNumTipLab.snp.makeConstraints { (make) in
            make.top.equalTo(expenseNumLab.snp.bottom).offset(5)
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        
        //line
        line.snp.makeConstraints { (make) in
            make.top.equalTo(monthPriceLab.snp.top).offset(5)
            make.bottom.equalTo(monthTipLab.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
