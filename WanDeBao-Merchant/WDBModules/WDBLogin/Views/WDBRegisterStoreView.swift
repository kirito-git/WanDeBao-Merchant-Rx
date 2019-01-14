//
//  WDBRegisterStoreView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRegisterStoreView: UIView {
    
    
    private var storeInfoTipLabel = UILabel();
    private var firstSeparatorLine = UIImageView();
    private var secondSeparatorLine = UIImageView();
    private var thirdSeparatorLine = UIImageView();
    private var fourthSeparatorLine = UIImageView();
    private var firstVerticalSepartorLine = UIImageView();
    private var secondVerticalSeparatorLine = UIImageView();
    private var thirdVerticalSeparatorLine = UIImageView();
    private var fourthVerticalSeparatorLine = UIImageView();
    private var storeNameTipLabel = UILabel();
    private var storeAddressTipLabel = UILabel();
    private var storePhoneTipLabel = UILabel();
    private var storeBusinessCategoryTipLabel = UILabel();
    private var bottomView = UIImageView();
    
    lazy var storeIconImgView = UIImageView();
    lazy var storeNameTextField = UITextField();
    lazy var storeAddressTextField = UITextField();
    lazy var storePhoneTextField = UITextField();
    lazy var storeBusinessCategoryBtn = UIButton()
    lazy var cancelBtn = UIButton();
    lazy var ensureCreateBtn = UIButton();
    
    private let kEdgeOffset = 50;
    private let kTopOffset = 15;
    private let kItemHieght = 40;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    func setupSubviews() {
        
        storeIconImgView.image = UIImage.init(named: "")
        self.addSubview(storeIconImgView)
        
        storeInfoTipLabel.text = "请填写店铺的信息";
        self.addSubview(storeInfoTipLabel)
        
        firstSeparatorLine.image = UIImage.init(named: "")
        secondSeparatorLine.image = UIImage.init(named: "")
        thirdSeparatorLine.image = UIImage.init(named: "")
        fourthSeparatorLine.image = UIImage.init(named: "")
        
        firstVerticalSepartorLine.image = UIImage.init(named: "")
        secondVerticalSeparatorLine.image = UIImage.init(named: "")
        //thirdSeparatorLine.image
        
        self.addSubview(firstSeparatorLine)
        self.addSubview(secondSeparatorLine)
        self.addSubview(thirdSeparatorLine)
        self.addSubview(fourthSeparatorLine)
        
        storeNameTipLabel.text = "门店名称"
        self.addSubview(storeNameTipLabel)
        
        storeNameTextField.placeholder = "若有分店，请到具体的分店名"
        self.addSubview(storeNameTextField)
        
        storeAddressTipLabel.text = "门店地址"
        self.addSubview(storeAddressTipLabel)
        
        storeAddressTextField.placeholder = "请输入您的门店地址"
        self.addSubview(storeAddressTextField)
        
        storePhoneTipLabel.text = "联系电话"
        self.addSubview(storePhoneTipLabel)
        
        storePhoneTextField.placeholder = "填写座机/手机，座机需要加区号"
        self.addSubview(storePhoneTextField)
        
        storeBusinessCategoryTipLabel.text = "经营品类"
        self.addSubview(storeBusinessCategoryTipLabel)
        
        storeBusinessCategoryBtn.setTitle("请选择", for: UIControlState.normal)
        self.addSubview(storeBusinessCategoryBtn)
        
        
        //底层view
        bottomView.image = UIImage.init(named: "")
        self.addSubview(bottomView)
        
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        self.addSubview(cancelBtn)
        
        ensureCreateBtn.setTitle("确定", for:UIControlState.normal)
        self.addSubview(ensureCreateBtn)
        
        
       self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        storeIconImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(64+30)
            make.width.height.equalTo(100)
        }
        
        storeInfoTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(storeIconImgView.snp.bottom)
            make.height.equalTo(40)
            make.width.lessThanOrEqualToSuperview()
        }
        
        firstSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(storeInfoTipLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        storeNameTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstSeparatorLine.snp.bottom).offset(10)
            make.left.equalTo(kEdgeOffset)
            make.width.equalTo(80)
            make.height.equalTo(kItemHieght)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
