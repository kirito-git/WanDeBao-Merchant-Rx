//
//  WDBTurnoverManageCell.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift

class WDBTurnoverManageCell: UICollectionViewCell {
    
    var bgview:UIView!
    var tableNumLab:UILabel!
    var timeLab:UILabel!
    var startStatusBtn:UIButton!
    var endBtn:UIButton!
    var disposeBag = DisposeBag()
    
    //单元格重用时调用
    //注意 prepareForReuse() 方法里的 disposeBag = DisposeBag()
    //每次 prepareForReuse() 方法执行时都会初始化一个新的 disposeBag。这是因为 cell 是可以复用的，这样当 cell 每次重用的时候，便会自动释放之前的 disposeBag，从而保证 cell 被重用的时候不会被多次订阅，避免错误发生。
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        bgview = UIView()
        bgview.layer.borderWidth = 1
        bgview.layer.borderColor = UIColor_MainOrangeColor.cgColor
        bgview.layer.cornerRadius = 16
        self.contentView.addSubview(bgview)
        
        tableNumLab = UILabel()
        tableNumLab.font = UIFontWithSize(size: 12)
        tableNumLab.backgroundColor = UIColor_MainOrangeColor
        tableNumLab.layer.cornerRadius = 10
        tableNumLab.layer.masksToBounds = true
        tableNumLab.textAlignment = NSTextAlignment.center
        tableNumLab.text = ""
        self.contentView.addSubview(tableNumLab)
        
        timeLab = UILabel()
        timeLab.font = UIFontWithSize(size: 18)
        timeLab.textAlignment = NSTextAlignment.center
        timeLab.text = "00:00"
        self.contentView.addSubview(timeLab)
        
        startStatusBtn = UIButton()
        startStatusBtn.setTitle("未上菜", for: UIControlState.normal)
        startStatusBtn.setTitle("已上菜", for: UIControlState.selected)
        startStatusBtn.setTitleColor(TitleTextColor, for: UIControlState.normal)
        startStatusBtn.setTitleColor(.white, for: UIControlState.selected)
        startStatusBtn.titleLabel?.font = UIFontWithSize(size: 14)
        startStatusBtn.layer.cornerRadius = 12
        startStatusBtn.layer.masksToBounds = true
        startStatusBtn.layer.borderWidth = 1
        startStatusBtn.layer.borderColor = UIColor.lightText.cgColor
        self.contentView.addSubview(startStatusBtn)
        
        endBtn = UIButton()
        endBtn.setTitle("就餐结束", for: UIControlState.normal)
        endBtn.setTitle("就餐开始", for: UIControlState.selected)
        endBtn.setTitleColor(TitleTextColor, for: UIControlState.normal)
        endBtn.setTitleColor(.white, for: UIControlState.selected)
        endBtn.titleLabel?.font = UIFontWithSize(size: 14)
        endBtn.layer.cornerRadius = 12
//        endBtn.layer.masksToBounds = true
        endBtn.layer.borderWidth = 1
        endBtn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.contentView.addSubview(endBtn)
        
        
        bgview.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        tableNumLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(30)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableNumLab.snp.bottom).offset(10)
            make.width.equalTo(140)
            make.height.equalTo(21)
        }
        
        startStatusBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLab.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(24)
        }
        
        endBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(startStatusBtn.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(24)
        }
        
    }
}
