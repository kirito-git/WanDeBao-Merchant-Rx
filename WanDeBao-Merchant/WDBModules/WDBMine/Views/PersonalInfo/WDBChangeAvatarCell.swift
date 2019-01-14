//
//  WDBChangeAvatarCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBChangeAvatarCell: UITableViewCell {
    
    var avatarImgView: UIImageView!
    var avatarTipLabel: UILabel!
    var rightArrowImgView: UIImageView!
    
    let kEdgeOffset = 20
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }
    
    func setupSubviews() {
        
        avatarImgView = UIImageView()
        avatarImgView.layer.cornerRadius = 20
        avatarImgView.layer.masksToBounds = true
        self.contentView.addSubview(avatarImgView)
        
        rightArrowImgView = UIImageView()
        rightArrowImgView.image = UIImage.init(named: "mine_personalinfo_rightarrow")
        self.contentView.addSubview(rightArrowImgView)
        
        avatarTipLabel = UILabel()
        avatarTipLabel.font = UIFont.systemFont(ofSize: 15)
        avatarTipLabel.text = "更换头像"
        avatarTipLabel.textAlignment = .right
        self.contentView.addSubview(avatarTipLabel)
        
        self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        avatarImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        rightArrowImgView.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(kEdgeOffset/2)
        }
        
        avatarTipLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightArrowImgView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(80)
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
