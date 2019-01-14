//
//  WDBTurnoverManageAddCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBTurnoverManageAddCell: UICollectionViewCell {
    
    var addButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        addButton = UIButton()
        addButton.setTitle("+", for: UIControlState.normal)
        addButton.setTitleColor(TitleTextColor, for: UIControlState.normal)
        addButton.titleLabel?.font = UIFontWithSize(size: 14)
        addButton.layer.cornerRadius = 16
        addButton.layer.masksToBounds = true
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor_MainOrangeColor.cgColor
        addButton.isUserInteractionEnabled = false
        self.contentView.addSubview(addButton)
        
        addButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
