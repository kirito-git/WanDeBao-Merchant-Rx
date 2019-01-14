
//
//  WDBHomePageCell1.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

//经营数据

class WDBHomePageCell1: UITableViewCell {
    
    var topLine:UILabel!
    var titleLab:UILabel!
    var leftValue:UILabel!
    var leftKey:UILabel!
    var rightValue:UILabel!
    var rightKey:UILabel!
    var line:UILabel!
    var bottomGrayLine:UILabel!
    var chartView:WDBMonthChartView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        topLine = UILabel()
        topLine.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(topLine)
        
        titleLab = UILabel()
        titleLab.font = UIFontWithSize(size: 14)
        titleLab.textColor = TitleTextColor
        titleLab.text = "经营数据"
        self.contentView.addSubview(titleLab)
        
        leftValue = UILabel()
        leftValue.font = UIFontWithSize(size: 20)
        leftValue.textColor = UIColor.red
        leftValue.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(leftValue)
        
        leftKey = UILabel()
        leftKey.font = UIFontWithSize(size: 12)
        leftKey.textColor = DetailTextColor
        leftKey.text = "昨日消费额（元）"
        leftKey.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(leftKey)
        
        rightValue = UILabel()
        rightValue.font = UIFontWithSize(size: 20)
        rightValue.textColor = UIColor.red
        rightValue.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(rightValue)
        
        rightKey = UILabel()
        rightKey.font = UIFontWithSize(size: 12)
        rightKey.textColor = DetailTextColor
        rightKey.text = "昨日消费笔数"
        rightKey.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(rightKey)
        
        line = UILabel()
        line.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(line)
        
        chartView = WDBMonthChartView.init(frame: self.contentView.frame)
        self.contentView.addSubview(chartView)
        
        bottomGrayLine = UILabel()
        bottomGrayLine.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(bottomGrayLine)
        
        topLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(10)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(topLine.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        leftValue.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        leftKey.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.top.equalTo(leftValue.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        rightValue.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        rightKey.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH*3/4)
            make.top.equalTo(rightValue.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        line.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(leftValue.snp.bottom).offset(5)
            make.width.equalTo(1)
            make.height.equalTo(40)
        }
        
        chartView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(leftKey.snp.bottom).offset(10)
            make.bottom.equalTo(-30)
        }
        
        bottomGrayLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
        leftValue.text = "0"
        rightValue.text = "0"
    
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
