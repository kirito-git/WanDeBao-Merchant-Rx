//
//  WDBRenewalBottomView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalBottomView: UIView {
    
    var totalPriceLabel: UILabel!
    var ensurePayBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupSubviews()
         self.backgroundColor = UIColor.white
    }
    
 
    func setupSubviews() {
        
         totalPriceLabel = UILabel()
         totalPriceLabel.text = "总计 ¥0.0"
         self.addSubview(totalPriceLabel)
        
         ensurePayBtn = UIButton()
         ensurePayBtn.setBackgroundImage(UIImage.init(named: "mine_renewal_bottombtnbg"), for: .normal)
         ensurePayBtn.setTitle("确认支付", for: .normal)
         self.addSubview(ensurePayBtn)
        
        
          setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        totalPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        ensurePayBtn.snp.makeConstraints { (make) in
             make.right.top.bottom.equalToSuperview()
             make.width.equalTo(100)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
