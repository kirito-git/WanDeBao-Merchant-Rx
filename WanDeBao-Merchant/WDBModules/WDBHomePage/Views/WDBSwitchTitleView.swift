//
//  WDBSwitchTitleView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/13.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias TitleSelectBlock = () -> Void

class WDBSwitchTitleView: UIView {

    var titleStr:String? {
        didSet{
            if let title = titleStr {
                titleLab.text = title
                let rect:CGRect = sizeWithText(text:title, font:titleLab.font , size: CGSize(width:10000,height:20))
                let width = rect.size.width + 10 + 20
                bgImageVi.snp.updateConstraints({ (make) in
                    make.width.equalTo(width)
                })
            }
        }
    }
    var titleView:UIView!
    var titleLab:UILabel!
    var imageVi:UIImageView!
    var titleButton:UIButton!
    var bgImageVi:UIImageView!
    
    var titleSelectBlock:TitleSelectBlock?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0,y:0,width:250,height:44))
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI() {
        
        bgImageVi = UIImageView.init(image: UIImage.init(named: "titleButton"))
        self.addSubview(bgImageVi)
        
        titleLab = UILabel.init(frame: CGRect.zero)
        titleLab.text = ""
        titleLab.textAlignment = .center
        titleLab.textColor = UIColor.white
        titleLab.font = UIFontWithSize(size: 16)
        self.addSubview(titleLab)
        
        imageVi = UIImageView.init(image: UIImage.init(named: "arrow-down"))
        self.addSubview(imageVi)

        titleButton = UIButton.init(frame: CGRect.zero)
        titleButton.addTarget(self, action: #selector(titleSelect), for: UIControlEvents.touchUpInside)
        self.addSubview(titleButton)
        
        bgImageVi.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(28)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-8)
        }
        
        imageVi.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        
        titleButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(44)
        }

    }
    
    @objc func titleSelect () {
        if let titleSelect = titleSelectBlock {
            titleSelect()
        }
    }
    
    func sizeWithText(text: String, font: UIFont, size: CGSize) -> CGRect {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }

    
}
