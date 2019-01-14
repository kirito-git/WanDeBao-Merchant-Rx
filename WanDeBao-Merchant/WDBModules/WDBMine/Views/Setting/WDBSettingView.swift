//
//  WDBSettingView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBSettingView: UIView {
    
    //@IBOutlet weak var onlinePaySwotch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
  
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "WDBSettingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
