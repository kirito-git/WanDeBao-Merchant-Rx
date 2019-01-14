//
//  WDBChangePhoneCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBChangePhoneCell: UITableViewCell {
    
    var phoneIconImgView: UIImageView!
    var phoneNoTipLabel: UILabel!
    var phoneLabel: UILabel!
    var rightArrowImgView: UIImageView!
    
    let kEdgeOffset = 20
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
    }
    

    public func setValueForValue(titleIcon:String, tip:String, title:String, isChangePhoneNo:Bool) {
        phoneIconImgView.image = UIImage.init(named: titleIcon)
        phoneNoTipLabel.text = tip
        phoneLabel.text = title
    }
    
    
    func setupSubviews() {
        
        phoneIconImgView = UIImageView()
        self.contentView.addSubview(phoneIconImgView)
        
        phoneNoTipLabel = UILabel()
        phoneNoTipLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(phoneNoTipLabel)
        
        phoneLabel = UILabel()
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        phoneLabel.textAlignment = .right
        self.contentView.addSubview(phoneLabel)
        
        rightArrowImgView = UIImageView()
        rightArrowImgView.image = UIImage.init(named: "mine_personalinfo_rightarrow")
        self.contentView.addSubview(rightArrowImgView)
        
        
      self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
      
        phoneIconImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.centerY.equalToSuperview()
        }
        
        phoneNoTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset + 30)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        rightArrowImgView.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset)
            make.width.lessThanOrEqualTo(kEdgeOffset/2)
            make.centerY.equalToSuperview()
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightArrowImgView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
