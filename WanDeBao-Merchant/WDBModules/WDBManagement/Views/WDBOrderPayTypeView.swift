//
//  WDBOrderPayTypeView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBOrderPayTypeView: UIView ,UITableViewDataSource ,UITableViewDelegate{

    var products = [WDBProductModel]()
    var orderModel:WDBOrderModel! {
        didSet {
            let paycode = orderModel.orderPay?.payActualCode
            let price = String(describing: orderModel.orderPay?.payActualAllSum ?? 0)
            section2Data = [paycode!,price,""]
            self.tableview.reloadData()
        }
    }
    var section2Data = ["","",""]
    var viewModel = WDBOrderPayTypeViewModel()
    
    let orderTitles = ["订单号","支付金额","支付方式"]
    var tableview:UITableView!
    var tableHeader:UIView!
    var confirmButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews(){
        
        tableview = UITableView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH), style: UITableViewStyle.plain)
        tableview.dataSource = self
        tableview.delegate = self
        self.addSubview(tableview)
        tableview.tableFooterView = UIView()
        tableview.register(UINib.init(nibName: "WDBOrderPaySection2Cell", bundle: nil), forCellReuseIdentifier: "WDBOrderPaySection2Cell")
        tableview.register(UINib.init(nibName: "WDBOrderPayTypeChooseCell", bundle: nil), forCellReuseIdentifier: "WDBOrderPayTypeChooseCell")
        tableview.register(WDBGameAddCell.self, forCellReuseIdentifier: "WDBGameAddCell")
        
        setTableHeaderView()
        setBottomView()
    }
    
    func setTableHeaderView() -> Void {
        
        tableHeader = UIView()
        tableHeader.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:40)
        tableHeader.backgroundColor = UIColor.white
        tableview.tableHeaderView = tableHeader
        
        let totalChoseLab = UILabel()
        totalChoseLab.text = "已选择游戏"
        totalChoseLab.font = UIFontWithSize(size: 14)
        totalChoseLab.textColor = DetailTextColor
        tableHeader.addSubview(totalChoseLab)
        
        let line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        tableHeader.addSubview(line)
        
        totalChoseLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(21)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    func setBottomView() -> Void {
        confirmButton = UIButton()
        confirmButton.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        confirmButton.setTitle("支 付", for: UIControlState.normal)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        confirmButton.titleLabel?.font = UIFontWithSize(size: 14)
        confirmButton.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(confirmButton)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return products.count
        }else if section == 2 {
            return viewModel.payTypeNames.count
        }
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBGameAddCell", for: indexPath) as! WDBGameAddCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.selectButton.isHidden = true
            let model = products[indexPath.row]
            cell.imageVi.kf.setImage(with: URL.init(string: model.productImgUrl ?? ""), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
            cell.gameNameLab.text = model.name ?? ""
            cell.gameInfoLab.text = model.timesTypeName ?? ""
            cell.priceLab.text = "¥\(String(describing: model.price ?? 0))"
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBOrderPaySection2Cell", for: indexPath) as! WDBOrderPaySection2Cell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentLab.text = section2Data[indexPath.row]
            cell.titleLab.text = orderTitles[indexPath.row]
            if indexPath.row == 1 {
                cell.contentLab.textColor = UIColor_MainOrangeColor
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBOrderPayTypeChooseCell", for: indexPath) as! WDBOrderPayTypeChooseCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.selectBtn.isSelected = viewModel.marks[indexPath.row]
            cell.typeName.text = viewModel.payTypeNames[indexPath.row]["name"]
            cell.imagevi.image = UIImage.init(named: viewModel.payTypeNames[indexPath.row]["icon"]!)
            cell.selectBtn.isUserInteractionEnabled = false
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.viewModel.cellSelect(row: indexPath.row)
            tableview.reloadData()
        }
    }
}
