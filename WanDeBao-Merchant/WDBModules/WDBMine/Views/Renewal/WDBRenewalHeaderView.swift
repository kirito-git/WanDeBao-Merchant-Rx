//
//  WDBRenewalHeaderView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalHeaderView: UIView {
    
    var bgImgView: UIImageView!
    var avatarImageView: UIImageView!
    var renewalStatusLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupSubviews()
         self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValueForView() {
        
        avatarImageView.kf.setImage(with: URL.init(string: WDBGlobalDataUserDefaults.getAvatar()), placeholder: UIImage.init(named: "default_header"), options: nil, progressBlock: nil, completionHandler: nil)
        avatarImageView.kf.setImage(with: URL.init(string: WDBGlobalDataUserDefaults.getAvatar()), placeholder: UIImage.init(named: "default_header"), options: nil, progressBlock: nil, completionHandler: nil)
        
         let endTime = WDBGlobalDataUserDefaults.getEndTime() / 1000
         let currentTime:TimeInterval = NSDate().timeIntervalSince1970
         var time = ""
         if endTime > currentTime {
            //renewalStatusLabel.text = "会员已过期"
            time =  DateFormatTool.dateStringFromTimestamp(type: DateStringType.yMd,timestamp: endTime)
            time = String(format:"%@过期",time)
         }else{
            time = "会员已过期"
        }
        renewalStatusLabel.text = time
    }
    
    
    func setupSubviews() {
        
     bgImgView = UIImageView()
     bgImgView.image = UIImage.init(named: "mine_headerviewbg")
     self.addSubview(bgImgView)
    
     avatarImageView = UIImageView()
     avatarImageView.layer.cornerRadius = 30
     avatarImageView.layer.masksToBounds = true
     avatarImageView.backgroundColor = UIColor.white
     bgImgView.addSubview(avatarImageView)
       
     renewalStatusLabel = UILabel()
     renewalStatusLabel.text = "申请开通"
     renewalStatusLabel.textAlignment = .center
     renewalStatusLabel.font = UIFont.systemFont(ofSize: 12)
     //renewalStatusLabel.textColor
     bgImgView.addSubview(renewalStatusLabel)
        
      setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        bgImgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        renewalStatusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
