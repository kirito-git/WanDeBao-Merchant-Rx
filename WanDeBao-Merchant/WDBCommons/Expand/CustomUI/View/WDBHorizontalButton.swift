//
//  WDBHorizontalButton.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBHorizontalButton: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: self.frame.size.width * 0.9, y: self.frame.size.height * 0.1, width: self.frame.size.width * 0.06, height: self.frame.size.height * 0.8)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.frame.size.width * 0.9, height: self.frame.size.height)
    }

}
