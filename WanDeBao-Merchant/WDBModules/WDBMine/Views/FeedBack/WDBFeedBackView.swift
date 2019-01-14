//
//  WDBFeedBackView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class WDBFeedBackView: UIView {
    
    lazy var inputBgImgView = UIImageView()
    lazy var inputTextView = KMPlaceholderTextView()
    lazy var submitFeedbackBtn = UIButton()

    override init(frame: CGRect) {
         super.init(frame: frame)
         self.setupSubviews()
    }
    
    func setupSubviews() {
        
        inputTextView.layer.cornerRadius = 8
        inputTextView.layer.borderWidth = 1
        inputTextView.placeholder = "请输入......"
        inputTextView.font = UIFont.systemFont(ofSize: 12)
        inputTextView.placeholderFont = UIFont.systemFont(ofSize: 12)
        inputTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(inputTextView)
        
        submitFeedbackBtn = UIButton()
        submitFeedbackBtn.layer.cornerRadius = 5
        submitFeedbackBtn.layer.masksToBounds = true
        submitFeedbackBtn.setTitle("提交", for: .normal)
        submitFeedbackBtn.setBackgroundImage(UIImage.init(named: "mine_feedback_submitbg"), for: .normal)
        self.addSubview(submitFeedbackBtn)
        
        
       self.setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        inputTextView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.height.equalTo(200)
        }
        
        submitFeedbackBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
            make.top.equalTo(inputTextView.snp.bottom).offset(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.endEditing(true)
    }
    
    

}
