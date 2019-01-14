//
//  WDBShopBillView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class WDBShopBillView: UIView, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {

    var tableView:UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        tableView = UITableView()
        tableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-64)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        self.addSubview(tableView)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.register(UINib.init(nibName: "WDBShopBillCell", bundle: nil), forCellReuseIdentifier: "WDBShopBillCell")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "暂无账单", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }
}
