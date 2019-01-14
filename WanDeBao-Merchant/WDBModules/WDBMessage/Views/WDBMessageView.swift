//
//  WDBMessageView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
import DZNEmptyDataSet

class WDBMessageView: UIView,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {

    var tableView:UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0,y:0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT))
        setUpSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpSubviews() {
        self.backgroundColor = UIColor.white
        
        tableView = UITableView.init()
        tableView.rowHeight = 90
        tableView.register(WDBMessageCell.self, forCellReuseIdentifier: "WDBMessageCell")
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make)->Void in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT-49-64)
        }
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "暂无消息", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }
}
