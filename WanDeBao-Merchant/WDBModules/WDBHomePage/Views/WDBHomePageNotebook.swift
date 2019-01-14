//
//  WDBHomePageNotebook.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBHomePageNotebook: UIView {

    var noteImg:UIImageView!
    var noteTitle:UILabel!
    var noteDetail:UILabel!
    var closeImage:UIImageView!
    var grayline:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:105))
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupSubviews() -> Void {
        
        noteImg = UIImageView()
        noteImg.image = UIImage.init(named: "noteimage.png")
        self.addSubview(noteImg)
        
        noteTitle = UILabel()
        noteTitle.text = "使用手册"
        noteTitle.font = UIFontWithSize(size: 16)
        noteTitle.textColor = TitleTextColor
        self.addSubview(noteTitle)
        
        noteDetail = UILabel()
        noteDetail.text = "新手商家的快捷引导手册"
        noteDetail.font = UIFontWithSize(size: 14)
        noteDetail.textColor = DetailTextColor
        self.addSubview(noteDetail)
        
        closeImage = UIImageView()
        closeImage.image = UIImage.init(named: "home_doc_delete")
        closeImage.isUserInteractionEnabled = true
        self.addSubview(closeImage)
        
        grayline = UILabel()
        grayline.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(grayline)
        
        noteImg.snp.makeConstraints { (make) in
            make.left.equalTo(60)
            make.top.equalTo(20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        noteTitle.snp.makeConstraints { (make) in
            make.left.equalTo(noteImg.snp.right).offset(20)
            make.top.equalTo(25)
            make.right.equalTo(30)
            make.height.equalTo(21)
        }
        
        noteDetail.snp.makeConstraints { (make) in
            make.left.equalTo(noteImg.snp.right).offset(20)
            make.top.equalTo(noteTitle.snp.bottom).offset(10)
            make.right.equalTo(30)
            make.height.equalTo(21)
        }
        
        closeImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        grayline.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(5)
        }
    }
}
