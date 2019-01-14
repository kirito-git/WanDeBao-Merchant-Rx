//
//  WDBDiscountManageView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD
import PGActionSheet

class WDBDiscountManageView: UIView ,DZNEmptyDataSetDelegate ,DZNEmptyDataSetSource{

    var exchangeButton:UIButton!
    var actionSheet:PGActionSheet!
    var setView:UIView!
    var tableView:UITableView!
    var bottomView:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        self.backgroundColor = UIColor.groupTableViewBackground
        creatSetView()
        creatTableView()
        setBottomView()
    }
    
    func creatSetView() -> Void {
        
        setView = UIView()
        setView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:50)
        setView.backgroundColor = UIColor.white
        self.addSubview(setView)
        
        let tipslab = UILabel()
        tipslab.frame = CGRect(x:15,y:0,width:140,height:50)
        tipslab.text = "用户积分兑换"
        tipslab.font = UIFontWithSize(size: 16)
        setView.addSubview(tipslab)
        
        exchangeButton = UIButton()
        exchangeButton.frame = CGRect(x:SCREEN_WIDTH-60,y:0,width:50,height:50)
        exchangeButton.setImage(UIImage.init(named: "right-arrows"), for: UIControlState.normal)
        exchangeButton.contentHorizontalAlignment = .right
        setView.addSubview(exchangeButton)
    }
    
    func setBottomView() -> Void {
        bottomView = UIButton()
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("+添加优惠券", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
    }
    
    func creatTableView() -> Void {
        tableView = UITableView()
        tableView.frame = CGRect(x:0,y:60,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-60-kNavibarH-iPhoneXBottomBarH)
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.addSubview(tableView)
        tableView.register(WDBDiscountCell.self, forCellReuseIdentifier: "WDBDiscountCell")
        
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
    }
    
    //点击跳转到修改优惠券  暂时无修改优惠券
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let model = dataArray[indexPath.row];
//        let current_Type = String(describing: model.discount?.type ?? 0)
//        let discountAddVC = WDBDiscountManageAddViewController()
//        discountAddVC.current_Type = current_Type
//        discountAddVC.isActionAdd = false //用户修改
//        discountAddVC.discountModel = model
//        parentControl.navigationController?.pushViewController(discountAddVC, animated: true)
//    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty_discount")
    }
    
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString.init(string: "暂无商品", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
//    }
    
}
