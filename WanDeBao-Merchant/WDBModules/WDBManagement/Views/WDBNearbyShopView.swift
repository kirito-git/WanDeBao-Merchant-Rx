//
//  WDBNearbyShopView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/28.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class WDBNearbyShopView: UIView ,UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate ,DZNEmptyDataSetSource{

    var viewModel = WDBNearbyShopViewModel()
    var tableView:UITableView!
    var confirmButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() -> Void {
        
        tableView = UITableView()
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        self.addSubview(tableView)
        tableView.register(WDBNearbyShopCell.self, forCellReuseIdentifier: "WDBNearbyShopCell")
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        setBottomView()
    }
    
    func setBottomView() -> Void {
        confirmButton = UIButton()
        confirmButton = UIButton()
        confirmButton.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        confirmButton.setTitle("确 定", for: UIControlState.normal)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        confirmButton.titleLabel?.font = UIFontWithSize(size: 14)
        confirmButton.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(confirmButton)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shopsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBNearbyShopCell", for: indexPath) as! WDBNearbyShopCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let model:WDBShopModel = viewModel.shopsArray[indexPath.row]
        cell.titleLab.text = model.shopName
        cell.selectButton.isSelected = viewModel.markArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mark:Bool = viewModel.markArray[indexPath.row]
        viewModel.markArray[indexPath.row] = !mark
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
}
