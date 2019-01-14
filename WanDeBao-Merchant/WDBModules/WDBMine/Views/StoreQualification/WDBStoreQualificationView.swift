//
//  WDBStoreQualificationView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBStoreQualificationView: UIScrollView {
    
    
    var contentView: UIView!
    
    
    var businessLicenseTipLabel: UILabel!
    var uploadBusinessLicenseLBtn: UIButton!
    var businessLicenseBtn: UIButton!
    
    var firstSeparatorLineView: UIView!
    
    var cateringServiceLicenseTipLabel: UILabel!
    var uploadCateringServiceLicenseBtn: UIButton!
    var cateringServiceLicenseBtn: UIButton!
    
    var secondSeparatorLineView: UIView!
    var cateringServiceFoodSafetyInfoTipLabel: UILabel!
    var uploadCateringServiceFoodSafetyInfoBtn: UIButton!
    
    var cateringServiceFoodSafetyInfoBtn: UIButton!
    
    private let kEdgeOffset = 30
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setupSubviews()
    }
    
    func setupSubviews() {
        
        
        contentView = UIView()
        self.addSubview(contentView)
        
        //营业执照
        businessLicenseTipLabel = UILabel()
        businessLicenseTipLabel.text = "营业执照"
        contentView.addSubview(businessLicenseTipLabel)
        
        uploadBusinessLicenseLBtn = UIButton()
        uploadBusinessLicenseLBtn.setTitle("重新上传", for: UIControlState.normal)
        uploadBusinessLicenseLBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        uploadBusinessLicenseLBtn.setBackgroundImage(UIImage.init(named: "login_smallbtn_bg"), for: UIControlState.normal)
        uploadBusinessLicenseLBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        uploadBusinessLicenseLBtn.isEnabled = false
        contentView.addSubview(uploadBusinessLicenseLBtn)
        
        businessLicenseBtn = UIButton()
//        businessLicenseBtn.setBackgroundImage(UIImage.init(named: "login_bottomviewbg"), for: UIControlState.normal)
        businessLicenseBtn.setBackgroundImage(UIImage.init(named: "empty-bankcard"), for: UIControlState.normal)
        contentView.addSubview(businessLicenseBtn)
        
        firstSeparatorLineView = UIView()
        firstSeparatorLineView.backgroundColor = APP_BK_COLOR
        contentView.addSubview(firstSeparatorLineView)
        
        // 餐饮服务许可证
        cateringServiceLicenseTipLabel = UILabel()
        cateringServiceLicenseTipLabel.text = "餐饮服务许可证"
        contentView.addSubview(cateringServiceLicenseTipLabel)
        
        uploadCateringServiceLicenseBtn = UIButton()
        uploadCateringServiceLicenseBtn.setTitle("重新上传", for: .normal)
        uploadCateringServiceLicenseBtn.setBackgroundImage(UIImage.init(named: "login_smallbtn_bg"), for:.normal)
        uploadCateringServiceLicenseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        uploadCateringServiceLicenseBtn.isEnabled = false
        contentView.addSubview(uploadCateringServiceLicenseBtn)
        
        cateringServiceLicenseBtn = UIButton()
        cateringServiceLicenseBtn.setBackgroundImage(UIImage.init(named: "empty-bankcard"), for:.normal)
        contentView.addSubview(cateringServiceLicenseBtn)
        
        secondSeparatorLineView = UIView()
        secondSeparatorLineView.backgroundColor = APP_BK_COLOR
        contentView.addSubview(secondSeparatorLineView)
        
        //餐饮服务食品安全监督信息
        cateringServiceFoodSafetyInfoTipLabel = UILabel()
        cateringServiceFoodSafetyInfoTipLabel.text = "餐饮服务食品安全监督信息"
        contentView.addSubview(cateringServiceFoodSafetyInfoTipLabel)
        
        uploadCateringServiceFoodSafetyInfoBtn = UIButton()
        uploadCateringServiceFoodSafetyInfoBtn.setTitle("重新上传", for: .normal)
        uploadCateringServiceFoodSafetyInfoBtn.setBackgroundImage(UIImage.init(named: "login_smallbtn_bg"), for: .normal)
        uploadCateringServiceFoodSafetyInfoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        uploadCateringServiceFoodSafetyInfoBtn.isEnabled = false
        contentView.addSubview(uploadCateringServiceFoodSafetyInfoBtn)
        
        cateringServiceFoodSafetyInfoBtn = UIButton()
        cateringServiceFoodSafetyInfoBtn.setBackgroundImage(UIImage.init(named: "empty-bankcard"), for: .normal)
        contentView.addSubview(cateringServiceFoodSafetyInfoBtn)
        
        
        self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(20)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
        }
       
        businessLicenseTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.top.equalTo(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        uploadBusinessLicenseLBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset/2)
            make.top.equalTo(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        businessLicenseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(businessLicenseTipLabel.snp.bottom).offset(20)
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.height.equalTo(150)
        }
        
        firstSeparatorLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(businessLicenseBtn.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        cateringServiceLicenseTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.top.equalTo(firstSeparatorLineView.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        uploadCateringServiceLicenseBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset/2)
            make.top.equalTo(firstSeparatorLineView.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        cateringServiceLicenseBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.top.equalTo(uploadCateringServiceLicenseBtn.snp.bottom).offset(20)
            make.height.equalTo(150)
        }
        
        secondSeparatorLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(cateringServiceLicenseBtn.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        uploadCateringServiceFoodSafetyInfoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset)
            make.top.equalTo(secondSeparatorLineView.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        cateringServiceFoodSafetyInfoTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(uploadCateringServiceFoodSafetyInfoBtn.snp.left).offset(-10)
            make.top.equalTo(secondSeparatorLineView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        cateringServiceFoodSafetyInfoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.top.equalTo(uploadCateringServiceFoodSafetyInfoBtn.snp.bottom).offset(20)
            make.height.equalTo(150)
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
