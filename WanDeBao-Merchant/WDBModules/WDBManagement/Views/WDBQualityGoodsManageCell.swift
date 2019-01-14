//
//  WDBQualityGoodsManageCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBQualityGoodsManageCell: UITableViewCell {
    
    var foodNameLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func creatUI() -> Void {
        
        foodNameLab = UILabel()
        foodNameLab.font = UIFontWithSize(size: 14)
        foodNameLab.textColor = UIColorRGB_Alpha(R: 60, G: 60, B: 60, alpha: 1)
        foodNameLab.textAlignment = NSTextAlignment.center
        self.addSubview(foodNameLab)
        
        foodNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
        }
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
