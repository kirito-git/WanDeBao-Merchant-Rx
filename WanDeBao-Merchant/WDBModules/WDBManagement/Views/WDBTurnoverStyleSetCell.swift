//
//  WDBTurnoverStyleSetCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBTurnoverStyleSetCell: UITableViewCell {

    var bgImageVi:UIImageView!
    var storeNameLab:UILabel!
    
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
        
        storeNameLab = UILabel()
        storeNameLab.font = UIFontWithSize(size: 16)
        storeNameLab.textColor = UIColor.white
        storeNameLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(storeNameLab)
        
        bgImageVi.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(15)
            make.bottom.equalTo(0)
        }
        
        storeNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.right.equalTo(-80)
            make.top.equalTo(30)
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
