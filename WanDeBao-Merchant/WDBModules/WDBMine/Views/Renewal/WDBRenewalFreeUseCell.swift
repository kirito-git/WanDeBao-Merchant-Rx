//
//  WDBRenewalFreeUseCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalFreeUseCell: UITableViewCell {
    
    var freeToUseBgImgView: UIImageView!
    var freeToUseTitleLabel: UILabel!
    var freeToUseBtn: UIButton!
    
    private let kEdgeOffset = 20
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupSubviews()
        self.selectionStyle = .none
    }
    
    
    func setData(data: Any) {
        //let model = data as! WDBProductModel
       
    }
  
    func setupSubviews() {
        
     freeToUseBgImgView = UIImageView()
     freeToUseBgImgView.image = UIImage.init(named: "mine_roundedrectangle_white")
     self.contentView.addSubview(freeToUseBgImgView)
        
     freeToUseTitleLabel = UILabel()
     freeToUseTitleLabel.font = UIFont.systemFont(ofSize: 15)
     freeToUseTitleLabel.text = "免费试用7天"
     self.contentView.addSubview(freeToUseTitleLabel)
        
     freeToUseBtn = UIButton()
     freeToUseBtn.setTitle("开启", for: .normal)
     freeToUseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
     freeToUseBtn.setTitleColor(UIColor.white, for: .normal)
     freeToUseBtn.setBackgroundImage(UIImage.init(named: "login_smallbtn_bg"), for: .normal)
     self.contentView.addSubview(freeToUseBtn)

        setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        freeToUseBgImgView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        freeToUseTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        freeToUseBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
