//
//  WDBHomeCellView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/21.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBHomeCellView: UIView {

    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var topleftTips: UILabel!
    @IBOutlet weak var toprightTips: UILabel!
    
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var bottomLeftTips: UILabel!
    @IBOutlet weak var bottomRightTips: UILabel!
    
    //奖券
    @IBOutlet weak var sendDNum: UILabel!
    @IBOutlet weak var useDNum: UILabel!
    //顾客
    @IBOutlet weak var CustomerSendNum: UILabel!
    @IBOutlet weak var customerUseNum: UILabel!
    
    
    
    @IBOutlet weak var sendDNumTip: UILabel!
    @IBOutlet weak var userDNumTip: UILabel!
    @IBOutlet weak var cSendDNumTip: UILabel!
    @IBOutlet weak var cUseDNumTip: UILabel!
    
    var contentView:UIView!
    var bottomGrayline:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addBottomGrayLine()
        //初始化属性配置
        initialSetup()
        addLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //初始化默认属性配置
    func initialSetup(){
        
    }
    
    //设置约束
    func  addLayout() -> Void {
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(232)
        }
    }
    
     //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for:className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    //添加views
    func addBottomGrayLine() -> Void {
        bottomGrayline = UIView()
        bottomGrayline.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(bottomGrayline)
        
        bottomGrayline.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.bottom)
            make.height.equalTo(10)
        }
    }

}
