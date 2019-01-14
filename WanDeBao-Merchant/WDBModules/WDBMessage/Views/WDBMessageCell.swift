//
//  WDBMessageCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/10.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMessageCell: UITableViewCell {

    var titleLab:UILabel!
    var detailLab:UILabel!
    var timeLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        //标题
        titleLab = UILabel.init()
        titleLab.text = "消息提醒"
        titleLab.textColor = TitleTextColor
        titleLab.font = UIFontWithSize(size: 16)
        self.addSubview(titleLab)
        
        //详情
        detailLab = UILabel.init()
        detailLab.text = "消息提醒消息提醒消息提醒消息提醒消息提醒消息提醒消息提醒"
        detailLab.textColor = DetailTextColor
        detailLab.font = UIFontWithSize(size: 14)
        self.addSubview(detailLab)
        
        //时间
        timeLab = UILabel.init()
        timeLab.text = "2019-2-3"
        timeLab.textColor = TitleTextColor
        timeLab.font = UIFontWithSize(size: 16)
        timeLab.textAlignment = NSTextAlignment.right
        self.addSubview(timeLab)
        
        
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.right.equalTo(-15)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
