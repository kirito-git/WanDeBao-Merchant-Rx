//
//  WDBMineHeaderView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class WDBMineHeaderView: UIView {
    
    var model:WDBAccountModel?
    
    var topBgImgView: UIImageView!
    var avatarImgView: UIButton!
    var phoneNoLabel: UILabel!
    var deadlineTimeLabel: UILabel!
    var renewalBtn: UIButton!
    
    var horizontalSeparatorLineView: UIView!
    var offlineSaleLabel: UILabel!
    var offlineSaleTipLabel: UILabel!
    
    var verticalSeparatorLineView: UIView!
    var otherSaleLabel: UILabel!
    var otherSaleTipLabel: UILabel!
    
    var bottomView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.backgroundColor = UIColor.white
    }
    
    func setValueForView() {
        
        phoneNoLabel.text = WDBGlobalDataUserDefaults.getUserPhone()
        //avatarImgView.kf.setImage(with: URL.init(string: WDBGlobalDataUserDefaults.getAvatar()), for: .normal)
        avatarImgView.kf.setImage(with: URL.init(string: WDBGlobalDataUserDefaults.getAvatar()), for: .normal, placeholder: UIImage.init(named: "default_header"), options: nil, progressBlock: nil, completionHandler: nil)
        
        var time = ""
        let endTime = WDBGlobalDataUserDefaults.getEndTime() / 1000
        let currentTime:TimeInterval = NSDate().timeIntervalSince1970
        if endTime > currentTime {
            time =  DateFormatTool.dateStringFromTimestamp(type: DateStringType.yMd,timestamp: endTime)
            time = String(format:"%@过期",time)
        }else{
            time = "会员已过期"
        }
         self.deadlineTimeLabel.text = time
        self.offlineSaleLabel.text = String(format:"%g",model?.accountCashSum ?? 0)
        self.otherSaleLabel.text = String(format:"%g",model?.account ?? 0)
    }
    
    
    func setupSubviews() {
       
        topBgImgView = UIImageView()
        topBgImgView.image = UIImage.init(named: "mine_topbg")
        self.addSubview(topBgImgView)
        
        avatarImgView = UIButton()
        avatarImgView.layer.cornerRadius = 40
        avatarImgView.layer.masksToBounds = true
        self.addSubview(avatarImgView)
        
        phoneNoLabel = UILabel()
        phoneNoLabel.textAlignment = .center
        phoneNoLabel.textColor = UIColor.black
        self.addSubview(phoneNoLabel)
        
        deadlineTimeLabel = UILabel()
        deadlineTimeLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(deadlineTimeLabel)
        
        renewalBtn = UIButton()
        renewalBtn.setTitle("立即续费", for: UIControlState.normal)
        renewalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        renewalBtn.setTitleColor(UIColor.orange, for: UIControlState.normal)
        self.addSubview(renewalBtn)
        
        horizontalSeparatorLineView = UIView()
        horizontalSeparatorLineView.backgroundColor = APP_BK_COLOR
        self.addSubview(horizontalSeparatorLineView)
        
        offlineSaleLabel = UILabel()
        offlineSaleLabel.textColor = UIColor.red
        offlineSaleLabel.textAlignment = .center
        self.addSubview(offlineSaleLabel)
        
        offlineSaleTipLabel = UILabel()
        offlineSaleTipLabel.text = "  线下销售额（元）"
        offlineSaleTipLabel.textAlignment = .center
        offlineSaleTipLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(offlineSaleTipLabel)
        
        verticalSeparatorLineView = UIView()
        verticalSeparatorLineView.backgroundColor = APP_BK_COLOR
        self.addSubview(verticalSeparatorLineView)
        
        otherSaleLabel = UILabel()
        otherSaleLabel.textColor = UIColor.red
        otherSaleLabel.textAlignment = .center
        self.addSubview(otherSaleLabel)
        
        otherSaleTipLabel = UILabel()
        otherSaleTipLabel.text = "  其他销售额（元）"
        otherSaleTipLabel.textAlignment = .center
        //otherSaleTipLabel.backgroundColor = UIColor.orange
        otherSaleTipLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(otherSaleTipLabel)
        
        bottomView = UIView()
        bottomView.backgroundColor = APP_BK_COLOR
        self.addSubview(bottomView)
        
        self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        topBgImgView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(130)
        }
        
        avatarImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-3)
            make.top.equalTo(49)
            make.width.height.equalTo(80)
        }
        
        phoneNoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.top.equalTo(avatarImgView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        deadlineTimeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-50)
            make.width.equalTo(100)
            make.top.equalTo(phoneNoLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        renewalBtn.snp.makeConstraints { (make) in
            make.left.equalTo(deadlineTimeLabel.snp.right).offset(20)
            make.top.equalTo(deadlineTimeLabel)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        horizontalSeparatorLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(renewalBtn.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        verticalSeparatorLineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(horizontalSeparatorLineView.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(1)
        }
        
        offlineSaleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(verticalSeparatorLineView.snp.left)
            make.top.equalTo(horizontalSeparatorLineView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        offlineSaleTipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(verticalSeparatorLineView.snp.left)
            make.top.equalTo(offlineSaleLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        otherSaleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(verticalSeparatorLineView.snp.right)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(horizontalSeparatorLineView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        otherSaleTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(verticalSeparatorLineView.snp.right)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(otherSaleLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(offlineSaleTipLabel.snp.bottom).offset(10)
            make.height.equalTo(10)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }

}
