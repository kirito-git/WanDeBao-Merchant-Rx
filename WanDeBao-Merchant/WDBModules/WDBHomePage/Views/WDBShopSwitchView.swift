//
//  WDBShopSwitchView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/7/13.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

typealias SwitchShopFinishBlock = () -> Void

class WDBShopSwitchView: UIView ,UITableViewDelegate, UITableViewDataSource{

    var dataArray:[WDBMineShopModel]? {
        didSet{
            if let array = dataArray {
                let height = array.count * 50 + 100 + Int(iPhoneXBottomBarH)
                contentView.snp.updateConstraints({ (make) in
                    make.height.equalTo(min(300.0 + iPhoneXBottomBarH, CGFloat(height)))
                    make.bottom.equalToSuperview()
                })
                self.tableView.reloadData()
            }
        }
    }
    var switchBlock:SwitchShopFinishBlock?
    var minHeight:CGFloat = 150.0 + iPhoneXBottomBarH
    var maskview:UIView!
    var contentView:UIView!
    var button:UIButton!
    var line:UIView!
    var tableView:UITableView!
    var cancelButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI() {
        
        maskview = UIView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT))
        maskview.backgroundColor = UIColorRGB_Alpha(R: 0, G: 0, B: 0, alpha: 0.4)
        maskview.isUserInteractionEnabled = true
        self.addSubview(maskview)
        
        contentView = UIView.init(frame: CGRect(x:0.0,y:0.0,width:SCREEN_WIDTH,height:minHeight))
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        contentView.alpha = 0.2;

        button = UIButton.init(frame: CGRect.zero)
        button.setImage(UIImage.init(named: "shopAdd"), for: UIControlState.normal)
        button.setTitle("  新增店铺", for: UIControlState.normal)
        button.titleLabel?.font = UIFontWithSize(size: 14.0)
        button.setTitleColor(UIColor_MainOrangeColor, for: UIControlState.normal)
        contentView.addSubview(button)
        
        line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(line)

        tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.register(WDBShopSwitchViewCell.self, forCellReuseIdentifier: "WDBShopSwitchViewCell")
        
        cancelButton = UIButton.init(frame: CGRect.zero)
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.titleLabel?.font = UIFontWithSize(size: 16.0)
        cancelButton.backgroundColor = UIColor_MainOrangeColor
        contentView.addSubview(cancelButton)

        
        maskview.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(minHeight)
        }

        button.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-15)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(49)
            make.height.equalTo(1)
        }

        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(50)
            make.bottom.equalTo(-50)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-iPhoneXBottomBarH)
            make.height.equalTo(50)
        }
        
    }
    
    //开始动画
    func startAnimation() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.frame = (window?.bounds)!
        UIView.animate(withDuration: 0.2) {
            self.contentView.alpha = 1;
        }
    }
    
    func hideSwitchView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let array = dataArray {
            //点击店铺 将店铺shopid和shopname重新保存
            let model = array[indexPath.row]
            let shopid = String(describing:model.shopId ?? 0)
            WDBGlobalDataUserDefaults.saveShopID(shopId: shopid)
            let shopname = model.shopName ?? ""
            WDBGlobalDataUserDefaults.saveShopName(shopName: shopname)
        }
        hideSwitchView()
        if let back = switchBlock {
            back()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBShopSwitchViewCell", for: indexPath) as! WDBShopSwitchViewCell
        if let array = dataArray {
            let model = array[indexPath.row]
            cell.shopNameLab.text = model.shopName ?? ""
        }
        return cell
    }
}
