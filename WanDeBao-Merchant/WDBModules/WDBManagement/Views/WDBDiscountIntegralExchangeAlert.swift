//
//  WDBDiscountIntegralExchangeAlert.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias cancelBlock = () -> ()
typealias okBlock = (WDBIntergralModel) -> ()

class WDBDiscountIntegralExchangeAlert: UIView {
    
    var cancelClickBlock:cancelBlock!
    var okClickBlock:okBlock!
    
    var bgButtonView:UIButton!
    var contentView:UIView!
    var titleLab:UILabel!
    var scrollView:UIScrollView!
    var cancelButton:UIButton!
    var okButton:UIButton!
    var line:UIView!
    
    var selectedIndex = 0
    var dataArray:[WDBIntergralModel]! {
        didSet {
            print(dataArray)
            self.resetIntergralButtons(intergralArray: dataArray)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        bgButtonView = UIButton.init(type: UIButtonType.custom)
        bgButtonView.frame = self.bounds
        bgButtonView.backgroundColor = UIColorRGB_Alpha(R: 0, G: 0, B: 0, alpha: 0.4)
        bgButtonView.addTarget(self, action: #selector(cancelClick), for: UIControlEvents.touchUpInside)
        self.addSubview(bgButtonView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)
        
        titleLab = UILabel()
        titleLab.backgroundColor = UIColor_MainOrangeColor
        titleLab.text = "选择积分"
        titleLab.font = UIFont.systemFont(ofSize: 14.0)
        titleLab.textAlignment = NSTextAlignment.center
        contentView.addSubview(titleLab)
        
        scrollView = UIScrollView()
        contentView.addSubview(scrollView)
        
        cancelButton = UIButton.init(type: UIButtonType.custom)
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.backgroundColor = UIColor_MainOrangeColor
        cancelButton.addTarget(self, action: #selector(cancelClick), for: UIControlEvents.touchUpInside)
        contentView.addSubview(cancelButton)
        
        okButton = UIButton.init(type: UIButtonType.custom)
        okButton.setTitle("确定", for: UIControlState.normal)
        okButton.backgroundColor = UIColor_MainOrangeColor
        okButton.addTarget(self, action: #selector(okClick), for: UIControlEvents.touchUpInside)
        contentView.addSubview(okButton)
        
        line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(line)
        
                
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(273)
            make.height.equalTo(283)
            make.center.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.height.equalTo(160)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
        
        okButton.snp.makeConstraints { (make) in
            make.left.equalTo(cancelButton.snp.right)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(cancelButton.snp.right)
            make.bottom.equalToSuperview()
            make.top.equalTo(cancelButton.snp.top)
            make.width.equalTo(1)
        }
        
    }
    
    @objc func cancelClick() {
        cancelClickBlock()
    }
    
    @objc func okClick() {
        let model = dataArray[selectedIndex]
        okClickBlock(model)
    }
    
    
    //根据数据设置积分button
    func resetIntergralButtons(intergralArray:[WDBIntergralModel]) {
        
        let width = 273 - 40
        
        if intergralArray.count == 0 {
            return
        }
        
        for i in 0...(intergralArray.count-1) {
            
            let model = intergralArray[i]
            let value = String(describing:model.value ?? 0)
            
            let intergralBtn = UIButton()
            intergralBtn.setTitle(value, for: .normal)
            intergralBtn.setTitleColor(.gray, for: .normal)
            intergralBtn.tag = 100 + i
            scrollView.addSubview(intergralBtn)
            intergralBtn.backgroundColor = .white
            intergralBtn.frame = CGRect(x:(width-196)/2,y:40*i+5*(i+1),width:196,height:40)
            intergralBtn.addTarget(self, action: #selector(intergralBtnSelect(_:)), for: .touchUpInside)
            
            if i == 0 {
                //默认第一个为选中
                intergralBtn.backgroundColor = UIColor_MainOrangeColor
            }
            
            let label = UILabel()
            label.backgroundColor = UIColor.groupTableViewBackground
            scrollView.addSubview(label)
            label.frame = CGRect(x:Int((width-196)/2),y:45*(i+1),width:196,height:1)
        }
        scrollView.contentSize = CGSize(width:scrollView.frame.size.width,height:CGFloat(Float(45 * intergralArray.count + 10)))
    }
    
    @objc func intergralBtnSelect(_ button:UIButton) {
        for btn in scrollView.subviews {
            if btn.tag >= 100 {
                btn.backgroundColor = .white
            }
        }
        button.backgroundColor = UIColor_MainOrangeColor
        selectedIndex = button.tag - 100
    }
    

}
