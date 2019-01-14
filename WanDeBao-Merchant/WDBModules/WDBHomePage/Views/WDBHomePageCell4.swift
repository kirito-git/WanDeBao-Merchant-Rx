//
//  WDBHomePageCell4.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/2.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBHomePageCell4: UITableViewCell {

    var titleLab:UILabel!
    var dateLimitLab:UILabel!
    var chartView:WDBTurnoverChartView!
    var bottomGrayLine:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        titleLab = UILabel()
        titleLab.font = UIFontWithSize(size: 14)
        titleLab.textColor = TitleTextColor
        self.contentView.addSubview(titleLab)
        
        dateLimitLab = UILabel()
        dateLimitLab.font = UIFontWithSize(size: 12)
        dateLimitLab.textColor = UIColor.red
        self.contentView.addSubview(dateLimitLab)
        
        chartView = WDBTurnoverChartView.init(frame: self.contentView.frame)
        self.contentView.addSubview(chartView)
        
        bottomGrayLine = UILabel()
        bottomGrayLine.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(bottomGrayLine)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(20)
            make.width.equalTo(200)
            make.height.equalTo(21)
        }
        
        dateLimitLab.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        chartView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.equalTo(-30)
        }
        
        bottomGrayLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
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
