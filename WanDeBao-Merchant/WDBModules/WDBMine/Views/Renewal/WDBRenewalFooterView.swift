//
//  WDBRenewalFooterView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit


class WDBRenewalFooterView: UIView {
    
    var topSeparatorLineView: UIView!
    var titleLabel: UILabel!
    var bottomSeparatorLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        topSeparatorLineView = UIView()
        topSeparatorLineView.backgroundColor = APP_BK_COLOR
        self.addSubview(topSeparatorLineView)
        
        titleLabel = UILabel()
        titleLabel.text = "支付方式"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(titleLabel)
        
        bottomSeparatorLineView = UIView()
        bottomSeparatorLineView.backgroundColor = APP_BK_COLOR
        self.addSubview(bottomSeparatorLineView)
        
        setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        topSeparatorLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(20)
            make.height.equalTo(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(topSeparatorLineView.snp.bottom).offset(2)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        bottomSeparatorLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    
    
}

