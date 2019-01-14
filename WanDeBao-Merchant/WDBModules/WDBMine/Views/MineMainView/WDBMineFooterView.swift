//
//  WDBMineFooterView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMineFooterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.backgroundColor = APP_BK_COLOR
    }
    
    func setupSubviews() {
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.frame = CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: 20)
        tipLabel.textAlignment = .center
        tipLabel.text = "联系电话:0571-28121863-808 工作时间:9:00-21:00"
        self.addSubview(tipLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
