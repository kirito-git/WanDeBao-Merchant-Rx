//
//  WDBHomePageButtonsView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBHomePageButtonsView: UIView {
    
    var scanCheckBtn:UIButton!
    var manageBtn:UIButton!
    var billBtn:UIButton!
    var grayline:UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:120))
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        
        scanCheckBtn = UIButton()
        scanCheckBtn.setTitle("扫码验证", for: UIControlState.normal)
        scanCheckBtn.setTitleColor(TitleTextColor, for: UIControlState.normal)
        scanCheckBtn.titleLabel?.font = UIFontWithSize(size: 12)
        scanCheckBtn.setImage(UIImage.init(named: "home_scan"), for: UIControlState.normal)
        scanCheckBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 10, 0, 0)
        scanCheckBtn.titleEdgeInsets = UIEdgeInsetsMake(60, -60, 0, 0)
        self.addSubview(scanCheckBtn)
        
        manageBtn = UIButton()
        manageBtn.setTitle("翻桌率/推广管理", for: UIControlState.normal)
        manageBtn.setTitleColor(TitleTextColor, for: UIControlState.normal)
        manageBtn.titleLabel?.font = UIFontWithSize(size: 12)
        manageBtn.setImage(UIImage.init(named: "home_manage"), for: UIControlState.normal)
        manageBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 10, 0, 0)
        manageBtn.titleEdgeInsets = UIEdgeInsetsMake(60, -60, 0, 0)
        self.addSubview(manageBtn)
        
        billBtn = UIButton()
        billBtn.setTitle("账单记录", for: UIControlState.normal)
        billBtn.setTitleColor(TitleTextColor, for: UIControlState.normal)
        billBtn.titleLabel?.font = UIFontWithSize(size: 12)
        billBtn.setImage(UIImage.init(named: "home_billrecord"), for: UIControlState.normal)
        billBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 10, 0, 0)
        billBtn.titleEdgeInsets = UIEdgeInsetsMake(60, -60, 0, 0)
        self.addSubview(billBtn)
        
        grayline = UILabel()
        grayline.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(grayline)
        
        scanCheckBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/6)
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        manageBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/2)
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        billBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH*5/6)
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        grayline.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

}
