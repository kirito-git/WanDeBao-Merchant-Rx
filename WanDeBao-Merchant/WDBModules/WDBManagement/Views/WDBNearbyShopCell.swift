//
//  WDBNearbyShopCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBNearbyShopCell: UITableViewCell {

    var titleLab:UILabel!
    var selectButton:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        titleLab = UILabel()
        titleLab.font = UIFontWithSize(size: 16)
        titleLab.textColor = TitleTextColor
        self.contentView.addSubview(titleLab)
        
        selectButton = UIButton()
        selectButton.setImage(UIImage.init(named: "unSelect"), for: UIControlState.normal)
        selectButton.setImage(UIImage.init(named: "selected"), for: UIControlState.selected)
        selectButton.isSelected = false
        selectButton.isUserInteractionEnabled = false
        self.contentView.addSubview(selectButton)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(21)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
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
