//
//  WDBRenewalPayTypeCell.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalPayTypeCell: UITableViewCell {
    
    //var payBgView: UIView!
    var payTipImgView: UIImageView!
    var payTipLabel: UILabel!
    var selectPayBtn: UIButton!
    
    private let kEdgeOffset = 10

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupSubviews()
         self.selectionStyle = .none
    }
    
    func setValueForView(image:String, title:String, isSelectWeChatPay:Bool) {
        payTipImgView.image = UIImage.init(named: image)
        payTipLabel.text = title
        selectPayBtn.isSelected = isSelectWeChatPay
    }

    func setupSubviews() {
        
        payTipLabel = UILabel()
        self.contentView.addSubview(payTipLabel)
        
        payTipImgView = UIImageView()
        self.contentView.addSubview(payTipImgView)
        
        selectPayBtn = UIButton()
        selectPayBtn.setBackgroundImage(UIImage.init(named: "mine_radius_select"), for: .selected)
        selectPayBtn.setBackgroundImage(UIImage.init(named: "mine_radius_unselect"), for: .normal)
        self.contentView.addSubview(selectPayBtn)
        
        setupSubviewsFrame()
    }
    
    func setupSubviewsFrame() {
        
        payTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(60)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        payTipImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.centerY.equalToSuperview()
        }
        
        selectPayBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kEdgeOffset*2)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
