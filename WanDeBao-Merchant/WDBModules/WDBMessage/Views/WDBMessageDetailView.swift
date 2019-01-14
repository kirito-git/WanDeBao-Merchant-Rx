//
//  WDBMessageDetailView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/10.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

class WDBMessageDetailView: UIView {

    var contentView:UIView!
    var titleLab:UILabel!
    var dateLab:UILabel!
    var contentLab:UILabel!
    var line:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        self.backgroundColor = UIColor.groupTableViewBackground
        
        contentView = UIView.init()
        contentView.layer.cornerRadius = 10;
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        //标题
        titleLab = UILabel.init()
        titleLab.text = "消息提醒"
        titleLab.textColor = TitleTextColor
        titleLab.font = UIFontWithSize(size: 16)
        contentView.addSubview(titleLab)
        
        //时间
        dateLab = UILabel.init()
        dateLab.text = ""
        dateLab.textColor = DetailTextColor
        dateLab.font = UIFontWithSize(size: 14)
        contentView.addSubview(dateLab)
        
        line = UILabel.init()
        line.backgroundColor = UIColorRGB_Alpha(R: 200, G: 200, B: 200, alpha: 1)
        contentView.addSubview(line)
        
        //详情
        contentLab = UILabel.init()
        contentLab.text = "暂无内容！"
        contentLab.textColor = DetailTextColor
        contentLab.font = UIFontWithSize(size: 14)
        contentLab.numberOfLines = 0
        contentView.addSubview(contentLab)
        
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(15)
            make.topMargin.equalTo(15)
            make.right.equalTo(-30)
            make.height.equalTo(20)
        }
        
        dateLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(15)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(line.snp.bottom).offset(10)
            make.right.equalTo(-15)
            make.bottom.equalTo(-10)
        }
    }
    
}
