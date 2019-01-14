//
//  WDBMyBankCardCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMyBankCardCell: UITableViewCell {

    @IBOutlet weak var bankBg: UIImageView!
    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var bankNameLab: UILabel!
    @IBOutlet weak var bankOwerLab: UILabel!
    @IBOutlet weak var bankCardLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
