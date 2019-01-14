//
//  MineCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMineCell: UITableViewCell {
    
    @IBOutlet weak var mineTipImgView: UIImageView!
    @IBOutlet weak var mineTitletLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Initialization code
    }

    public func setValueForCell(mineModel: WDBMineModel) {
        let imageStr = mineModel.image ?? ""
        mineTipImgView.image = UIImage.init(named:imageStr)
        mineTitletLabel.text = mineModel.title ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
