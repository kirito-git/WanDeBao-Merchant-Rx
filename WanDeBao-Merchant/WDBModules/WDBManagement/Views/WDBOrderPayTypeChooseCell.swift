//
//  WDBOrderPayTypeChooseCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBOrderPayTypeChooseCell: UITableViewCell {

    @IBOutlet weak var imagevi: UIImageView!
    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectBtn.setImage(UIImage.init(named: "manage_game_unselected"), for: .normal)
        selectBtn.setImage(UIImage.init(named: "manage_game_selected"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
