//
//  WDBGameManageCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBGameManageCell: UITableViewCell {

    var bgImageVi:UIImageView!
    var gameNameLab:UILabel!
    var gameInfoLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        bgImageVi = UIImageView()
        bgImageVi.image = UIImage.init(named: "gamecell-orange.png")
        self.contentView.addSubview(bgImageVi)
        
        gameNameLab = UILabel()
        gameNameLab.font = UIFontWithSize(size: 16)
        gameNameLab.textColor = UIColor.white
        gameNameLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(gameNameLab)
        
        gameInfoLab = UILabel()
        gameInfoLab.font = UIFontWithSize(size: 12)
        gameInfoLab.textColor = UIColor.white
        gameInfoLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(gameInfoLab)
        
        
        bgImageVi.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(15)
            make.bottom.equalTo(0)
        }
        
        gameNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.right.equalTo(-80)
            make.top.equalTo(30)
            make.height.equalTo(21)
        }
        
        gameInfoLab.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.right.equalTo(-80)
            make.top.equalTo(gameNameLab.snp.bottom).offset(5)
            make.height.equalTo(15)
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
