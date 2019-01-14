//
//  WDBGameAddCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBGameAddCell: UITableViewCell {

    var imageVi:UIImageView!
    var gameNameLab:UILabel!
    var gameInfoLab:UILabel!
    var priceLab:UILabel!
    var selectButton:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
       
        imageVi = UIImageView()
        self.contentView.addSubview(imageVi)
        
        gameNameLab = UILabel()
        gameNameLab.font = UIFontWithSize(size: 16)
        gameNameLab.textColor = TitleTextColor
        self.contentView.addSubview(gameNameLab)
        
        gameInfoLab = UILabel()
        gameInfoLab.font = UIFontWithSize(size: 12)
        gameInfoLab.textColor = DetailTextColor
        self.contentView.addSubview(gameInfoLab)
        
        selectButton = UIButton()
        selectButton.setImage(UIImage.init(named: "manage_game_unselected.png"), for: UIControlState.normal)
        selectButton.setImage(UIImage.init(named: "manage_game_selected.png"), for: UIControlState.selected)
        self.contentView.addSubview(selectButton)
        selectButton.isUserInteractionEnabled = false
        
        priceLab = UILabel()
        priceLab.font = UIFontWithSize(size: 14)
        priceLab.textColor = UIColor_MainOrangeColor
        priceLab.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(priceLab)
        
        imageVi.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        gameNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(imageVi.snp.right).offset(15)
            make.width.equalTo(200)
            make.top.equalTo(15)
            make.height.equalTo(21)
        }
        
        gameInfoLab.snp.makeConstraints { (make) in
            make.left.equalTo(imageVi.snp.right).offset(15)
            make.width.equalTo(100)
            make.top.equalTo(gameNameLab.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(50)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.right.equalTo(selectButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
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
