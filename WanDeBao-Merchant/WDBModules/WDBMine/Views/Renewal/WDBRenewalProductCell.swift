//
//  WDBRenewalProductCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalProductCell: UITableViewCell {
    
    var bgImgView: UIImageView!
    var titleLabel: UILabel!
    var monthLabel: UILabel!
    
    
     let kEdgeOffset = 20
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupSubviews()
         self.selectionStyle = .none
         self.backgroundColor = UIColor.white
    }
    
    func setData(data: Any) {
        let model = data as! WDBProductModel
        titleLabel.text = "¥" + (String(describing: model.price ?? 0.0))
        if let type = model.timesType {
            if type == 0 {
                monthLabel.text = String(describing: model.times ?? 0) + "年"
            }else if type == 1 {
                monthLabel.text = String(describing: model.times ?? 0) + "个月"
            }else if type == 2 {
                 monthLabel.text = String(describing: model.times ?? 0) + "天"
            }else if type == 3 {
                 monthLabel.text = String(describing: model.times ?? 0) + "分钟"
            }
        }
        
      if model.isSelectProduct {
            bgImgView.image = UIImage.init(named: "mine_renewal_select")
        }else {
            bgImgView.image = UIImage.init(named: "mine_renewal_unselect")
        }
    }
    
    func setupSubviews() {
        
        bgImgView = UIImageView()
        bgImgView.image = UIImage.init(named: "mine_renewal_unselect")
        self.contentView.addSubview(bgImgView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "¥450/每月"
        bgImgView.addSubview(titleLabel)
        
        monthLabel = UILabel()
        monthLabel.font = UIFont.systemFont(ofSize: 16)
        monthLabel.textAlignment = .right
        monthLabel.text = "1个月"
        bgImgView.addSubview(monthLabel)
        
        setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        bgImgView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
