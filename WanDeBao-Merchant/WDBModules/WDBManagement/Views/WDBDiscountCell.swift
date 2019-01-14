//
//  WDBDiscountCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBDiscountCell: UITableViewCell {

    var bgimgvi:UIImageView!
    var typeLab:UILabel!
    var line:UILabel!
    var titleLab:UILabel!
    var limitDate:UILabel!
    var limitNum:UILabel!
    //积分
    var intergralLab:UILabel!
    var selectButton:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.groupTableViewBackground
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func creatUI() -> Void {
                
        bgimgvi = UIImageView.init(image: UIImage.init(named: "quan-bg.png"))
        self.contentView.addSubview(bgimgvi)
        
        typeLab = UILabel()
        typeLab.font = UIFontWithSize(size: 16)
        typeLab.textColor = TitleTextColor
        typeLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(typeLab)
        
        line = UILabel()
        line.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(line)
        
        titleLab = UILabel()
        titleLab.font = UIFontWithSize(size: 16)
        titleLab.textColor = TitleTextColor
        self.contentView.addSubview(titleLab)
        
        limitDate = UILabel()
        limitDate.font = UIFontWithSize(size: 14)
        limitDate.textColor = DetailTextColor
//        limitDate.backgroundColor = UIColor.red
        self.contentView.addSubview(limitDate)
        
        limitNum = UILabel()
        limitNum.font = UIFontWithSize(size: 14)
        limitNum.textColor = DetailTextColor
//        limitNum.backgroundColor = UIColor.red
        self.contentView.addSubview(limitNum)
        
        
        intergralLab = UILabel()
        intergralLab.font = UIFontWithSize(size: 14)
        intergralLab.textColor = DetailTextColor
        intergralLab.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(intergralLab)
        intergralLab.isHidden = true
        
        selectButton = UIButton()
        selectButton.setImage(UIImage.init(named: "unSelect"), for: UIControlState.normal)
        selectButton.setImage(UIImage.init(named: "selected"), for: UIControlState.selected)
        selectButton.isUserInteractionEnabled = false
//        selectButton.backgroundColor = .red
        self.contentView.addSubview(selectButton)
        selectButton.isHidden = true
        
        bgimgvi.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        typeLab.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(typeLab.snp.right).offset(10)
            make.top.equalTo(25)
            make.bottom.equalTo(-15)
            make.width.equalTo(1)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(15)
            make.top.equalTo(25)
            make.right.equalTo(-30)
            make.height.equalTo(21)
        }
        
        limitDate.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        limitNum.snp.makeConstraints { (make) in
            make.left.equalTo(limitDate.snp.right).offset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        intergralLab.snp.makeConstraints { (make) in
            make.right.equalTo(-50)
            make.top.equalTo(titleLab.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        selectButton.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.top.equalTo(25)
            make.width.equalTo(30)
            make.height.equalTo(30)
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
