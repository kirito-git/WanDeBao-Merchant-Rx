//
//  WDBManagementCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBManagementCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    var titleLab:UILabel!
    var lineRight:UILabel!
    var lineBottom:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() -> Void {
        
        imageView = UIImageView()
        self.contentView.addSubview(imageView)
        
        titleLab = UILabel()
        titleLab.font = UIFontWithSize(size: 14)
        titleLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(titleLab)
        
        lineRight = UILabel()
        lineRight.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(lineRight)
        
        lineBottom = UILabel()
        lineBottom.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(lineBottom)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        lineRight.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        lineBottom.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
